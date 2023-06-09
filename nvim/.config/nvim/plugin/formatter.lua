require("formatter").setup({
    logging = true,
    filetype = {
        typescriptreact = require("formatter.filetypes.typescriptreact").prettier,
        typescript = require("formatter.filetypes.typescript").prettier,
        javascriptreact = require("formatter.filetypes.javascript").prettier,
        javascript = require("formatter.filetypes.javascript").prettier,
        tex = require("formatter.filetypes.latex").latexindent,
        lua = require("formatter.filetypes.lua").stylua,
        c = require("formatter.filetypes.c").clangformat,
        cpp = require("formatter.filetypes.cpp").clangformat,
        sh = require("formatter.filetypes.bash").beautysh,
        go = require("formatter.filetypes.go").gofumpt,
    },
})

vim.keymap.set("n", "<leader>f", "<cmd>Format<cr>")
local group = vim.api.nvim_create_augroup("Formatter", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", { group = group, command = "FormatWrite" })
