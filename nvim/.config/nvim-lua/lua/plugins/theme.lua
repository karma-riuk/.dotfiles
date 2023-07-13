return {
    -- Theme inspired by Atom
    -- "sainnhe/sonokai",
    "navarasu/onedark.nvim",
    -- "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.opt.background = "dark"
        vim.opt.termguicolors = true

        -- [[ Sonokai config ]]
        -- vim.g.sonokai_diagnostic_virtual_text = "colored"
        -- vim.g.sonokai_transparent_background = 1
        -- vim.cmd.colorscheme("sonokai")

        -- [[ Onedark ]]
        vim.cmd.colorscheme("onedark")
        vim.cmd([[
            hi Normal guibg=None ctermbg=None
            hi NormalFloat guibg=None ctermbg=None
            " hi Terminal guibg=None ctermbg=None
            hi FloatBorder guibg=None ctermbg=None
            hi EndOfBuffer guibg=None ctermbg=None
            hi SignColumn guibg=None ctermbg=None
        ]])

        -- [[ Tokyonight (for light theme) ]]
        -- require("tokyonight").setup({
        --     style = "day",
        --     -- transparent = true,
        --     day_brightness = 0.1,
        -- })
        -- vim.cmd.colorscheme("tokyonight")

        -- Disable setting the colorscheme of the terminal
        for i = 0, 15 do
            vim.g["terminal_color_" .. i] = nil
        end
    end,
}
