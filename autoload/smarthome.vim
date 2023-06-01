vim9script
# SmartHome and SmartEnd over wrapped lines
# http://vim.wikia.com/wiki/SmartHome_and_SmartEnd_over_wrapped_lines
# https://github.com/bootleq/vimrc_human/blob/master/.vimrc

export def Home()
  const curcol = col('.')

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

  if mode() !~# '^[vV\x16]'
    return 'v'
  endif

  return 'n'
enddef

def GetCurCharLen(): number
  # https://eagletmt.hatenadiary.org/entry/20100623/1277289728
  return getline('.')->matchstr('.', col('.') - 1)->byteidx(1)
enddef

export def End()
  const curcol = col('.')
  const lastcol = GetMode() ==# 'i' ? col('$') : col('$') - 1

  # Gravitate towards ending for wrapped lines
  if curcol < lastcol - 1
    cursor(0, curcol + 1)
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

  # Correct edit mode cursor position, put after current character
  if GetMode() ==# 'i'
    cursor(0, col('.') + GetCurCharLen())
    return
  endif

  if GetMode() ==# 'v'
    normal! msgv`s
  endif
enddef

