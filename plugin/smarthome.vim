scriptencoding utf-8

if exists('g:loaded_smarthome')
  finish
endif
let g:loaded_smarthome = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>(smarthome-home) <Esc>:<C-u>call smarthome#home()<CR>
vnoremap <silent> <Plug>(smarthome-home) <Esc>:<C-u>call smarthome#home()<CR>
inoremap <silent> <Plug>(smarthome-home) <C-r>=smarthome#home()<CR>

nnoremap <silent> <Plug>(smarthome-end) <Esc>:<C-u>call smarthome#end()<CR>
vnoremap <silent> <Plug>(smarthome-end) <Esc>:<C-u>call smarthome#end()<CR>
inoremap <silent> <Plug>(smarthome-end) <C-r>=smarthome#end()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
