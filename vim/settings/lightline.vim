let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'shortfilename', 'modified' ],
      \             [ 'tagbar' ] ],
      \   'right': [ [ 'lineinfo', 'percent' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename'] ],
      \   'right': [],
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'filename': 'MyFilename',
      \   'shortfilename': 'MyShortFilename',
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
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%') ? expand('%') : '[NoName]')
endfunction

function! MyShortFilename()
  let _ = MyReadonly() . MyFugitive() . MyFilename() . MyTag()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%') ? ((winwidth(0) - strlen(_)) > 30 ? expand('%') : pathshorten(expand('%'))) : '[NoName]')
endfunction

" Use status bar even with single buffer
set laststatus=2
