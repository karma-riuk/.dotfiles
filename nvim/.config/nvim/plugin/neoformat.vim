nmap <leader>F <cmd>Neoformat<Cr>
let g:neoformat_tex_latexindent = {
        \ 'exe': 'latexindent',
        \ 'stdin': 1,
        \ }

augroup fmt
    autocmd!
    " autocmd BufWritePre * undojoin | Neoformat
augroup END
