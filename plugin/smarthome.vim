if exists('g:loaded_smarthome')
  finish
endif
let g:loaded_smarthome = 1

let s:save_cpo = &cpo
set cpo&vim

noremap <silent><Plug>(smarthome-n) <Esc>:<C-u>call smarthome#home("n")<CR>
noremap <silent><Plug>(smarthome-v) <Esc>:<C-u>call smarthome#home("v")<CR>
noremap <silent><Plug>(smarthome-i) <C-r>=smarthome#home("i")<CR>

noremap <silent><Plug>(smartend-n) <Esc>:<C-u>call smarthome#end("n")<CR>
noremap <silent><Plug>(smartend-v) <Esc>:<C-u>call smarthome#end("v")<CR>
noremap <silent><Plug>(smartend-i) <C-r>=smarthome#end("i")<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
