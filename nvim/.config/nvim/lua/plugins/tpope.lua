return {
    {
        "tpope/vim-repeat",
        event = "VeryLazy",
        config = function() end,
    },
    {
        "tpope/vim-surround",
        event = "VeryLazy",
        init = function()
            vim.cmd([[
            augroup SurroundCommandTex
                au!
                au Filetype tex let b:surround_{char2nr('e')} = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
                au Filetype tex let b:surround_{char2nr('c')} = "\\\1command: \1{\r}"
            augroup END
            ]])
        end,
    },
}
