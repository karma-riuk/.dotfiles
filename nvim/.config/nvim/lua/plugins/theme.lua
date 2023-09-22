-- from https://www.reddit.com/r/neovim/comments/yexeil/extending_highlight_groups_in_lua/
-- Usage extend_hl('Comment', { italic = true })
function extend_hl(name, def)
    local current_def = vim.api.nvim_get_hl_by_name(name, true)
    local new_def = vim.tbl_extend("force", {}, current_def, def)

    vim.api.nvim_set_hl(0, name, new_def)
end

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
            hi! link SpellBad DiagnosticError
        ]])
        extend_hl("SpellBad", { italic = true, underline = true, bold = true })

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
