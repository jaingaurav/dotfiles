let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ],
      \             [ 'tagbar' ] ],
      \   'right': [ [ 'lineinfo', 'percent' ] ],
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'filename': 'MyFilename',
      \   'tagbar': 'MyTag',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤ "
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyTag()
  return tagbar#currenttag("[%s]", "", "f")
endfunction

function! MyFilename()
  let _ = MyReadonly() . MyFugitive() . expand('%') . MyTag()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%') ? ((winwidth(0) - strlen(_)) > 30 ? expand('%') : pathshorten(expand('%'))) : '[NoName]')
endfunction

" Use status bar even with single buffer
set laststatus=2
