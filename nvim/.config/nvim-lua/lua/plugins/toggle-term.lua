return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = "<C-t>",
    opts = {
        size = 20,
        open_mapping = "<C-t>",
        shade_terminals = false,
        direction = "horizontal",
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)
        vim.keymap.set("t", "<C-n>", "<C-\\><C-n>", { desc = "Go in normal mode inside terminal" })
    end,
}
