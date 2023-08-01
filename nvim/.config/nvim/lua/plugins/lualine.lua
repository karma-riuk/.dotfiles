local n_words = "-"

local function n_words_component()
    return n_words .. " words"
end

local mygroup = vim.api.nvim_create_augroup("TexCount", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost", "BufWinEnter" }, {
    pattern = "*.tex",
    group = mygroup,
    callback = function()
        n_words = vim.fn.system("texcount -1 -sum -merge " .. vim.fn.shellescape(vim.fn.expand("%:p"))):gsub("%s+", "")
    end,
})

return {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            theme = "auto",
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" },
            globalstatus = true,
            disabled_filetypes = {
                winbar = { "toggleterm", "NvimTree" },
            },
        },
        inactive_winbar = {
            lualine_y = { "filename" },
        },
        winbar = {
            lualine_z = { "filename" },
        },
        sections = {
            lualine_x = {
                {
                    "selectioncount",
                    fmt = function(str)
                        if str == "" then
                            return ""
                        else
                            return "v_count: " .. str
                        end
                    end,
                },
                "fileformat",
                "filetype",
            },
        },
        extensions = {
            "toggleterm",
            "man",
        },
    },
    config = function(_, opts)
        local lualine_x = require("lualine").get_config().sections.lualine_x
        table.insert(lualine_x, 1, {
            n_words_component,
        })
        local texcount_ext = { filetypes = { "tex" }, sections = require("lualine").get_config().sections }
        texcount_ext.sections.lualine_x = lualine_x
        table.insert(opts.extensions, texcount_ext)

        require("lualine").setup(opts)
    end,
}
