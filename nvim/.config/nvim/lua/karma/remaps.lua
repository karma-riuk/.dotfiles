-- vim.keymap.set("n", "<leader>s", vim.cmd.up, {desc = "[s]ave file (only if changes happened)"})
-- vim.keymap.set("n", "<leader>jk", vim.cmd.wq, { desc = "Save and quit file" })
vim.keymap.set("n", "<leader>q", function()
    vim.cmd("silent q") -- silent to prevent 'Press enter to continue' on last buffer close
end, { desc = "[q]uit current file" })
vim.keymap.set("n", "<leader>Q", function()
    vim.cmd("silent Q") -- silent to prevent 'Press enter to continue' on last buffer close
end, { desc = "[Q]uit current file, even with unsaved files" })

-- Disable annoying mappings
vim.keymap.set("n", "q:", "<nop>", { desc = "disable q:" })
vim.keymap.set("n", "Q", "<nop>", { desc = "disable Q" })

-- Window navigation
for _, key in pairs({ "h", "j", "k", "l" }) do
    vim.keymap.set("n", "<C-" .. key .. ">", "<C-w>" .. key)
end

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
vim.keymap.set(
    { "n", "v" },
    "<leader>f",
    require("karma.format").format,
    { desc = "[f]ormat current buffer / selection" }
)

-- System clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["+d]], { desc = "[d]elete to system clipboard" })
vim.keymap.set("n", "<leader>D", [["+D]], { desc = "[D]elete to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "[p]aste from system clipboard" })
vim.keymap.set("x", "<leader>P", [["_dP]], { desc = "[P]aste without yanking what you pasted over" })
vim.keymap.set("n", "<leader>P", [["+P]], { desc = "[P]aste from system clipboard" })

-- wqa!
vim.keymap.set("n", "ZA", function()
    -- wirte all buffers first
    vim.cmd.wa()
    -- quit all buffers
    vim.cmd("silent qa") -- silent to prevent 'Press enter to continue' on last buffer close
end, { desc = ":wa | silent qa" })

-- Disbale format on save
vim.keymap.set("n", "<leader>F", function()
    vim.notify("Disabling formatting on save")
    pcall(function()
        vim.api.nvim_clear_autocmds({ group = "LspFormatting" })
    end)
    pcall(function()
        vim.api.nvim_clear_autocmds({ group = "NullLspFormatting" })
    end)
end, { desc = "Choose closest spell match" })

-- Ctrl-Delete
vim.keymap.set(
    "i",
    "<C-Backspace>",
    "<C-W>",
    { desc = "Delete from current position to the beginning of the word in insert mode" }
)
