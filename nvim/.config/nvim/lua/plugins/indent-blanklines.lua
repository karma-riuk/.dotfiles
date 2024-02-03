return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- enabled = false,
    config = function(opts)
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local hooks = require("ibl.hooks")
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            -- Original rainbow colors
            -- vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            -- vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            -- vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            -- vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            -- vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            -- vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            -- vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

            -- Dimmer version of those colors
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#9c4b51" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#a08656" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#437aa7" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#926b47" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#6a8854" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#8a549a" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#3c7f87" })
        end)

        require("ibl").setup({
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
            },
            indent = {
                highlight = highlight,
            },
        })
    end,
}
