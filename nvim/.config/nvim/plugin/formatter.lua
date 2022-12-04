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
    },
})

vim.keymap.set("n", "<leader>f", "<cmd>Format<cr>")
