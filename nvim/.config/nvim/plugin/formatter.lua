require("formatter").setup({
	logging = true,
	filetype = {
		tex = {
            function ()
                return {
                    exe = "latexindent",
                    args = {"-g", "/tmp/latexindent.log"},
                    stdin = 1
                }
            end
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
	},
})

vim.keymap.set("n", "<leader>f", "<cmd>Format<cr>")
