" SmartHome and SmartEnd over wrapped lines
" http://vim.wikia.com/wiki/SmartHome_and_SmartEnd_over_wrapped_lines
" https://github.com/bootleq/vimrc_human/blob/master/.vimrc

let s:save_cpo = &cpo
set cpo&vim

function! s:SaveReg(...) "{{{
  let l:name = a:0 ? a:1 : v:register
  let s:save_reg = [getreg(l:name), getregtype(l:name)]
endfunction "}}}

function! s:RestoreReg(...) "{{{
  let l:name = a:0 ? a:1 : v:register
  if exists('s:save_reg')
    call setreg(l:name, s:save_reg[0], s:save_reg[1])
  endif
endfunction "}}}

function! s:SaveMark(...)
  let l:name = a:0 ? a:1 : 'm'
  let s:save_mark = getpos("'" . l:name)
endfunction

function! s:RestoreMark(...)
  let l:name = a:0 ? a:1 : 'm'
  call setpos("'" . l:name, s:save_mark)
endfunction

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

  let curcol = col('.')
  " gravitate towards beginning for wrapped lines
  if curcol > indent('.') + 2
    call cursor(0, curcol - 1)
  endif
  if curcol == 1 || curcol > indent('.') + 1
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
  if l:mode ==# 'v'
    call s:SaveMark('m')
    call setpos("'m", getpos('.'))
    normal! gv`m
    call s:RestoreMark('m')
    delmarks m
  endif
  return ''
endfunction

function! smarthome#end()
  let l:mode = s:GetMode()
  let curcol = col('.')
  let lastcol = l:mode ==# 'i' ? col('$') : col('$') - 1
  " gravitate towards ending for wrapped lines
  if curcol < lastcol - 1
    call s:SaveReg()
    normal! yl
    let l:charlen = byteidx(getreg(), 1)
    call cursor(0, curcol + l:charlen)
    call s:RestoreReg()
  endif
  if curcol < lastcol
    if &wrap
      normal! g$
    else
      normal! $
    endif
  else
    normal! g_
  endif
  " correct edit mode cursor position, put after current character
  if l:mode ==# 'i'
    call s:SaveReg()
    normal! yl
    let l:charlen = byteidx(getreg(), 1)
    call cursor(0, col('.') + l:charlen)
    call s:RestoreReg()
  endif
  if l:mode ==# 'v'
    call s:SaveMark('m')
    call setpos("'m", getpos('.'))
    normal! gv`m
    call s:RestoreMark('m')
    delmarks m
  endif
  return ''
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
