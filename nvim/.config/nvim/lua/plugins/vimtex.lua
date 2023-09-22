return {
    "lervag/vimtex",
    ft = "tex",
    init = function()
        vim.g.vimtex_quickfix_ignore_filters = {
            "\v(Over|Under)full",
            "\vunder(bar|line)",
            "uop",
            "\v.*[Ll]istings.*cpp.*",
            "Package Listings Error: Couldn't load requested language.",
        }

        vim.g.vimtex_view_method = "zathura"

        vim.g.vimtex_delim_toggle_mod_list = {
            { "left", "\right" },
            { "\bigl", "\bigr" },
            { "Bigl", "Bigr" },
            { "\biggl", "\biggr" },
            { "Biggl", "Biggr" },
        }

        vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2

        vim.cmd([[
            augroup MyVimtex
                autocmd!
                " autocmd User VimtexEventQuit call vimtex#latexmk#clean(0)
                autocmd User VimtexEventQuit VimtexClean
            augroup END

            " augroup TexDollarPairs
            "     au!
            "     autocmd FileType tex let b:AutoPairs = AutoPairsDefine({'$': '$', "$$": "$$"})
            " augroup END
        ]])
    end,
}
