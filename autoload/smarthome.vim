vim9script
# SmartHome and SmartEnd over wrapped lines
# http://vim.wikia.com/wiki/SmartHome_and_SmartEnd_over_wrapped_lines
# https://github.com/bootleq/vimrc_human/blob/master/.vimrc

#  g^: 行が折り返されている場合、画面上の最初の非空白文字に移動。
#      行が折り返されていない場合、画面上の一番左側にある非空白文字に移動。（使わない）
#  ^:  行の最初の非空白文字に移動
#  g0: 行が折り返されている場合、画面上の最初の文字に移動。
#      行が折り返されていない場合、画面上の一番左側の文字に移動。（使わない）
#  0:  行の最初の文字に移動。

# Patterns:
# * 現在位置→Home() 実行後
# - 折り返した行の画面上の先頭→画面上の一つ前の行の先頭
# - 最初の非空白文字、行頭の空白文字の途中→行の先頭
# - 折り返した行の先頭以外→折り返した行の先頭
# - 上記以外→最初の非空白文字（行頭にいた（curcol == 1）場合も、最初の非空白文字、インデントがなければそのままなので、これに含まれる）

export def Home()
  var curcol = col('.')

  # gravitate towards beginning for wrapped lines

  # 折り返した行の画面上の先頭にいた場合に、画面上の前の行に移動できるように一つ左に移動
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
