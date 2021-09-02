let g:vimtex_fold_enabled = 1


if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif

au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

let g:vimtex_view_method = 'zathura'
set conceallevel=2
let g:tex_conceal='abdmg'

let g:indentLine_setColors = 0
