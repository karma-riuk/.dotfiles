return {
    "folke/noice.nvim",
    -- enabled = false,
    event = "VeryLazy",
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        routes = {
            {
                view = "cmdline_popup",
                filter = { cmdline = "Git pu", event = "msg_show" },
            },
        },
    },
    config = function(_, opts)
        require("noice").setup(opts)
        vim.opt.showmode = false

        local lualine_x = require("lualine").get_config().sections.lualine_x
        table.insert(lualine_x, 1, {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
        })
        -- local new_x = vim.tbl_extend("keep", {
        --     ,
        -- }, orignal_sections)

        require("lualine").setup({ sections = { lualine_x = lualine_x } })
    end,
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim", -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
}
