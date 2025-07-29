vim9script
# SmartHome and SmartEnd over wrapped lines
# http://vim.wikia.com/wiki/SmartHome_and_SmartEnd_over_wrapped_lines
# https://github.com/bootleq/vimrc_human/blob/master/.vimrc

# Patterns:
# * 現在位置→Home() 実行後
# - 行の先頭→そのまま
# - 折り返した行の先頭→折り返す一つ前の行の先頭
# - インデント後の先頭、インデントの途中→行の先頭
# - 折り返した行の先頭以外→折り返した行の先頭
# - 上記以外→行の先頭、インデントされていればインデント後の先頭
export def Home()
  var curcol = col('.')

  # gravitate towards beginning for wrapped lines
  if curcol > indent('.') + 2
    cursor(0, curcol - 1)
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
enddef

def GetMode(): string
  if mode() ==# 'i'
    return 'i'
  endif

  if mode() =~# '^[vV\x16]'
    return 'v'
  endif

  return 'n'
enddef

def GetCurCharLen(): number
  # https://eagletmt.hatenadiary.org/entry/20100623/1277289728
  return getline('.')->matchstr('.', col('.') - 1)->byteidx(1)
enddef

# FIXME: wrap でない場合に画面上の末尾になっている。
export def End()
  # gravitate towards ending for wrapped lines
  if col('.') < col('$') - 1
    cursor(0, col('.') + GetCurCharLen())
  endif
  normal! g$

  if GetMode() ==# 'v'
    if getline('.')[col('.') - 1] == ''
      cursor(0, col('.') - 1)
    endif
    return
  endif

  if GetMode() !=# 'i'
    return
  endif

  # correct edit mode cursor position, put after current character
  if col('.') == col('$') - GetCurCharLen()
    cursor(0, col('$'))
  endif
enddef
