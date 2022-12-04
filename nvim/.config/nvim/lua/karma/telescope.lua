-- Setup
local t = require('telescope')
t.setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true
        }
    },
    pickers = {
        find_files = {theme = "dropdown"},
        git_files = {theme = "dropdown"}
    }
}
t.load_extension('fzy_native')
t.load_extension("file_browser")

local telescope = require('telescope.builtin')

-- Custom functions 
local M = {}

M.git_or_find = function()
    local opts = {}
    local ok = pcall(telescope.git_files, opts)
    if not ok then t.extensions.file_browser.file_browser(opts) end
end

M.search_buffer = function()
    local opts = {previewer = false}
    local ok = pcall(telescope.current_buffer_fuzzy_find, opts)
    if not ok then vim.cmd('/') end -- kinda doesn't work
end


M.dotfiles = function()
    telescope.find_files {
        file_ignore_patterns = {"UltiSnips"},
        cwd = vim.env.XDG_CONFIG_HOME .. "/nvim",
        prompt_title = "< VIMRC >"
    }
end

return M
