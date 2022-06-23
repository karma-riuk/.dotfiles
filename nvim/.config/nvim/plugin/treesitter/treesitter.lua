require'nvim-treesitter.configs'.setup {
    context_commentstring = {enable = true},
    highlight = {enable = true, disable = {"latex"}},
    indent = {enable = true, disable = {"c", "cpp"}},
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    }
}
