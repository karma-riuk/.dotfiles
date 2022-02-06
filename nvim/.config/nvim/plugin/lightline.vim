let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'githead', 'readonly', 'filename', 'modified'],
      \             [ 'gitstatus'] ]
      \ },
      \ 'component_function': {
          \   'githead': "GitHead",
          \   'gitstatus': "GitStatus"
      \ },
      \ }

fun! GitHead()
    let b = get(b:,'gitsigns_head','')
    return b == "" ? "" : " " . b
endf

fun! GitStatus()
    return get(b:,'gitsigns_status','')
endf

""" Enable statuline for single buffer
set laststatus=2
""" Disable '--INSERT--' below the status line
set noshowmode
