let g:vimtex_quickfix_ignore_filters = [
            \ '\v(Over|Under)full',
            \]

" let g:vimtex_enabled = 0
" let g:tex_fast = 'bMpr'
let g:tex_fast = ''

let g:vimtex_matchparen_enabled = 0
let g:vimtex_imaps_enabled = 0 " vimtex imaps are cool by nothing compared to ultisnips
set conceallevel=2
set colorcolumn=81

let g:vimtex_delim_toggle_mod_list = [
            \ ['\left', '\right'],
            \ ['\bigl', '\bigr'],
            \ ['\Bigl', '\Bigr'],
            \ ['\biggl', '\biggr'],
            \ ['\Biggl', '\Biggr'],
            \]

augroup MyVimtex
    autocmd!
    " autocmd User VimtexEventQuit call vimtex#latexmk#clean(0)
    autocmd User VimtexEventQuit VimtexClean
augroup END

" Affects the 'jiangmiao/auto-pairs' plugin
let g:AutoPairs = {
                \ '(':')',
                \ '[':']',
                \ '{':'}',
                \ "$":"$",
                \ "$$":"$$",
                \ }

