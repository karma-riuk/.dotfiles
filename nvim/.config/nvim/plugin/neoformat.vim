nmap <leader>F <cmd>Neoformat<Cr>
let g:neoformat_tex_latexindent = {
        \ 'exe': "latexindent",
        \ 'args': ['-g', '/tmp/neoformat/latex_indent.log'],
        \ 'stdin': 1,
        \ }

let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
augroup fmt
    autocmd!
    " autocmd BufWritePre * undojoin | Neoformat
augroup END
