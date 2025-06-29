return {
    "RRethy/vim-illuminate",
    -- dependencies = { "rcarriga/nvim-notify" },
    event = "LspAttach",
    opts = {
        filetypes_denylist = {
            "dirbuf",
            "dirvish",
            "fugitive",
            "gitcommit",
            "toggleterm",
            "DressingInput",
            "NvimTree",
        },
        delay = 1000,
    },
    config = function(_, opts)
        require("illuminate").configure(opts)
        -- disable bold
        vim.cmd("hi IlluminatedWordRead gui=NONE")
        vim.cmd("hi IlluminatedWordWrite gui=NONE")
    end,
}
