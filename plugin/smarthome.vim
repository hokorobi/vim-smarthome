if exists('g:loaded_smarthome')
  finish
endif
let g:loaded_smarthome = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>(smarthome-n) <Esc>:<C-u>call smarthome#home("n")<CR>
vnoremap <silent> <Plug>(smarthome-v) <Esc>:<C-u>call smarthome#home("v")<CR>
inoremap <silent> <Plug>(smarthome-i) <C-r>=smarthome#home("i")<CR>

nnoremap <silent> <Plug>(smartend-n) <Esc>:<C-u>call smarthome#end("n")<CR>
vnoremap <silent> <Plug>(smartend-v) <Esc>:<C-u>call smarthome#end("v")<CR>
inoremap <silent> <Plug>(smartend-i) <C-r>=smarthome#end("i")<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
