local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.del("n", "<C-t>", { buffer = bufnr })
    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))

    vim.keymap.set("n", "<C-n>", api.tree.close, opts("Toggle"))
end

return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- set termguicolors to enable highlight groups
        vim.opt.termguicolors = true
    end,

    opts = {
        on_attach = my_on_attach,
        update_focused_file = {
            enable = true,
        },
        filters = {
            custom = {
                "^\\.git$",
            },
        },
    },
    config = function(_, opts)
        local new_ignores = vim.opt.wildignore:get()
        for k, v in pairs(new_ignores) do
            new_ignores[k] = v:gsub([[%.]], [[\.]]):gsub("*", ".*"):gsub("~", "\\~")
        end
        vim.list_extend(opts.filters.custom, new_ignores)
        require("nvim-tree").setup(opts)
        vim.cmd([[hi! link NvimTreeNormal Normal]])
        vim.cmd([[hi! link NvimTreeEndOfBuffer EndOfBuffer]])
    end,
    keys = {
        {
            "<C-n>",
            "<cmd>NvimTreeFocus<CR>",
            desc = "Toggle/Focus NeoTree",
        },
    },
}
