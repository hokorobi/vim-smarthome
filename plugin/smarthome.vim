vim9script

if exists('g:loaded_smarthome')
  finish
endif
const g:loaded_smarthome = 1

import autoload '../autoload/smarthome.vim'

noremap <silent> <Plug>(smarthome-home) <ScriptCmd>smarthome.Home()<CR>
inoremap <silent> <Plug>(smarthome-home) <ScriptCmd>smarthome.Home()<CR>

noremap <silent> <Plug>(smarthome-end) <ScriptCmd>call smarthome.End()<CR>
inoremap <silent> <Plug>(smarthome-end) <ScriptCmd>call smarthome.End()<CR>

