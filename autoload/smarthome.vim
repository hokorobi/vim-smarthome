" SmartHome and SmartEnd over wrapped lines
" http://vim.wikia.com/wiki/SmartHome_and_SmartEnd_over_wrapped_lines
" https://github.com/bootleq/vimrc_human/blob/master/.vimrc

let s:save_cpo = &cpo
set cpo&vim

function! s:GetMode()
  if stridx('vV<c-v>', mode()) > -1
    let l:mode = 'v'
  elseif stridx(mode(), 'i') == 0
    let l:mode = 'i'
  else
    let l:mode = 'n'
  endif
  return l:mode
endfunction

function! smarthome#home()
  let l:mode = s:GetMode()

  let l:curcol = col('.')
  " gravitate towards beginning for wrapped lines
  if l:curcol > indent('.') + 2
    call cursor(0, l:curcol - 1)
  endif
  if l:curcol == 1 || l:curcol > indent('.') + 1
    if &wrap
      normal! g^
    else
      normal! ^
    endif
  else
    if &wrap
      normal! g0
    else
      normal! 0
    endif
  endif
endfunction

function! s:GetCurCharLen() abort
  " https://eagletmt.hatenadiary.org/entry/20100623/1277289728
  return matchstr(getline('.'), '.', col('.') - 1)->byteidx(1)
endfunction

function! smarthome#end()
  let l:mode = s:GetMode()
  let l:curcol = col('.')
  let l:lastcol = col('$')
  " gravitate towards ending for wrapped lines
  if l:curcol < l:lastcol - 1
    call cursor(0, l:curcol + s:GetCurCharLen())
  endif
  if &wrap
    normal! g$
  else
    normal! $
  endif
  if l:mode !=# 'i'
    return
  endif

  " correct edit mode cursor position, put after current character
  if col('.') == l:lastcol - s:GetCurCharLen()
    call cursor(0, col('.') + s:GetCurCharLen())
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
