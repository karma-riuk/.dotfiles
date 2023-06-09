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

local orignal_sections = require("lualine").get_config().sections.lualine_x
local texcount_ext = { filetypes = { "tex" }, sections = require("lualine").get_config().sections }
texcount_ext.sections.lualine_x = vim.tbl_extend("keep", { n_words_component }, orignal_sections)

require("lualine").setup({
    options = {
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = {
            winbar = { "toggleterm" },
        },
    },
    inactive_winbar = {
        lualine_y = { "filename" },
    },
    winbar = {
        lualine_z = { "filename" },
    },
    extensions = {
        "toggleterm",
        "man",
        texcount_ext,
    },
})
