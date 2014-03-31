if exists('g:loaded_smarthome')
  finish
endif
let g:loaded_smarthome = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>(smarthome-n) <Esc>:<C-u>call smarthome#home("n")<CR>
vnoremap <silent> <Plug>(smarthome-v) <Esc>:<C-u>call smarthome#home("v")<CR>
inoremap <silent><expr> <Plug>(smarthome-i) smarthome#home("i")

nnoremap <silent> <Plug>(smartend-n) <Esc>:<C-u>call smarthome#end("n")<CR>
vnoremap <silent> <Plug>(smartend-v) <Esc>:<C-u>call smarthome#end("v")<CR>
inoremap <silent><expr> <Plug>(smartend-i) smarthome#end("i")

let &cpo = s:save_cpo
unlet s:save_cpo
