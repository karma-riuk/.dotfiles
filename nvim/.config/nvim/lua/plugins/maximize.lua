local function maximize_status()
    return vim.t.maximized and "   " or ""
end

return {
    "declancm/maximize.nvim",
    opts = {
        default_keymaps = false,
    },
    keys = {
        "<leader>m",
    },
    config = function()
        require("maximize").setup({
            "<leader>m",
            require("maximize").toggle,
            desc = "[m]aximize current buffer",
        })
        require("lualine").setup({
            winbar = {
                lualine_y = { maximize_status },
            },
        })
    end,
}
