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
        },
        delay = 1000,
    },
    init = function()
        print("hello")
    end,
    config = function(_, opts)
        require("illuminate").configure(opts)
        -- disable bold
        vim.cmd("hi IlluminatedWordRead gui=NONE")
        vim.cmd("hi IlluminatedWordWrite gui=NONE")
    end,
}
