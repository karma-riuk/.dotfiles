-- vim.keymap.set("n", "<leader>s", vim.cmd.up, {desc = "[s]ave file (only if changes happened)"})
-- vim.keymap.set("n", "<leader>jk", vim.cmd.wq, { desc = "Save and quit file" })
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = "[q]uit current file" })
vim.keymap.set("n", "<leader>Q", vim.cmd.Q, { desc = "[Q]uit current file, even with unsaved files" })
vim.keymap.set("n", "Q", "<nop>", { desc = "disable Q" })

-- Window navigation
for _, key in pairs({ "h", "j", "k", "l" }) do
    vim.keymap.set("n", "<C-" .. key .. ">", "<C-w>" .. key)
end

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Fixing Y
vim.keymap.set("n", "Y", "y$", { desc = "Yank until the end of the line" })
-- Keep it centered
for _, key in pairs({ "n", "N", "<C-u>", "<C-d>" }) do
    vim.keymap.set("n", key, key .. "zzzv")
end
vim.keymap.set("n", "J", "mzJ`z")

-- Undo breakpoints
for _, key in pairs({ ",", ".", "!", "?", "(", ")", "[", "]", "{", "}" }) do
    vim.keymap.set("i", key, key .. "<C-g>u", { noremap = true })
end

-- Format
vim.keymap.set({ "n", "v" }, "<leader>f", vim.lsp.buf.format, { desc = "[f]ormat current buffer / selection" })
