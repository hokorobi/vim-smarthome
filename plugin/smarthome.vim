scriptencoding utf-8

if exists('g:loaded_smarthome')
  finish
endif
let g:loaded_smarthome = 1

let s:save_cpo = &cpo
set cpo&vim

noremap <silent> <Plug>(smarthome-home) <Cmd>call smarthome#home()<CR>
inoremap <silent> <Plug>(smarthome-home) <C-r>=smarthome#home()<CR>

noremap <silent> <Plug>(smarthome-end) <Cmd>call smarthome#end()<CR>
inoremap <silent> <Plug>(smarthome-end) <C-r>=smarthome#end()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
