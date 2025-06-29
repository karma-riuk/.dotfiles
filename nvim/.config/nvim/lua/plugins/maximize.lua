local function maximize_status()
    return vim.t.maximized and "   " or ""
end

return {
    "declancm/maximize.nvim",
    opts = {},
    keys = {
        "<leader>m",
    },
    config = function(_, opts)
        require("maximize").setup(opts)
        vim.keymap.set("n", "<leader>m", require("maximize").toggle, { desc = "[m]aximize current buffer" })
        require("lualine").setup({
            winbar = {
                lualine_y = { maximize_status },
            },
        })
    end,
}
