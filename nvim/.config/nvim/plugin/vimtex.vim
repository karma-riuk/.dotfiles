let g:vimtex_quickfix_ignore_filters = [
            \ '\v(Over|Under)full',
            \ '\vunder(bar|line)',
            \ 'uop',
            \ '\v.*[Ll]istings.*cpp.*',
            \ "Package Listings Error: Couldn't load requested language.",
            \]

" let g:vimtex_matchparen_enabled = 0
let g:vimtex_imaps_enabled = 0 " vimtex imaps are cool by nothing compared to ultisnips

let g:vimtex_view_method = 'zathura'
" let g:vimtex_view_method = 'zathura_simple'
" let g:vimtex_view_general_viewer = 'mupdf'

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
" let g:AutoPairs = {
"                 \ '(':')',
"                 \ '[':']',
"                 \ '{':'}',
"                 \ "$":"$",
"                 \ "$$":"$$",
"                 \ }
augroup TexDollarPairs
    au!
    autocmd FileType tex let b:AutoPairs = AutoPairsDefine({'$': '$', "$$": "$$"})
augroup END

let g:vimtex_quickfix_autoclose_after_keystrokes = 2
