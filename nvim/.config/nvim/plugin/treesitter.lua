require'nvim-treesitter.configs'.setup {
    context_commentstring = {enable = true},
    highlight = {enable = true, disable = {"latex"}},
    indent = {enable = true, disable = {"c", "cpp"}}
}
