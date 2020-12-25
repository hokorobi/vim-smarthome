" SmartHome and SmartEnd over wrapped lines
" http://vim.wikia.com/wiki/SmartHome_and_SmartEnd_over_wrapped_lines
" https://github.com/bootleq/vimrc_human/blob/master/.vimrc

let s:save_cpo = &cpo
set cpo&vim

function! smarthome#home()
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

function! s:IsInsertMode()
  return mode()[0] ==# 'i'
endfunction

function! s:GetCurCharLen() abort
  " https://eagletmt.hatenadiary.org/entry/20100623/1277289728
  return matchstr(getline('.'), '.', col('.') - 1)->byteidx(1)
endfunction

function! smarthome#end()
  " gravitate towards ending for wrapped lines
  if col('.') < col('$') - 1
    call cursor(0, col('.') + s:GetCurCharLen())
  endif
  if &wrap
    normal! g$
  else
    normal! $
  endif
  if !s:IsInsertMode()
    return
  endif

  " correct edit mode cursor position, put after current character
  if col('.') == col('$') - s:GetCurCharLen()
    call cursor(0, col('$'))
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
