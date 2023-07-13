return {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    opts = {
        highlight = true,
        lsp = {
            auto_attach = true,
        },
    },
    dependencies = "neovim/nvim-lspconfig",
    config = function(_, opts)
        require("nvim-navic").setup(opts)
        require("lualine").setup({
            winbar = {
                lualine_c = {
                    {
                        "navic",
                        color_correction = "static",
                        padding = {
                            left = 1,
                            right = 0,
                        },
                    },
                },
            },
        })
    end,
}
