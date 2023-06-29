require("nvim-treesitter.configs").setup({
    context_commentstring = { enable = true },
    highlight = {
        enable = true,
        disable = { "latex" },
    },
    indent = { enable = true, disable = { "c", "cpp" } },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                -- ["aF"] = "@frame.outer", -- try for latex
                -- ["as"] = "@statement.outer", -- try for latex
            },
        },
    },
})
