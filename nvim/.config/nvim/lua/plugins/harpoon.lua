return {
    "ThePrimeagen/harpoon",
    -- dependencies = { "rcarriga/nvim-notify" },
    config = function(_, opts)
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>ha", function()
            mark.add_file()
            vim.notify("File has been added", "info", { title = "Harpoon", timeout = 10 })
        end, { desc = "[h]arpoon: [a]dd file", silent = false })
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

        vim.keymap.set("n", "<leader>j", function()
            ui.nav_file(1)
        end, { desc = "Navigate to first file in list" })
        vim.keymap.set("n", "<leader>k", function()
            ui.nav_file(2)
        end, { desc = "Navigate to second file in list" })
        vim.keymap.set("n", "<leader>l", function()
            ui.nav_file(3)
        end, { desc = "Navigate to third file in list" })
        vim.keymap.set("n", "<leader>'", function()
            ui.nav_file(4)
        end, { desc = "Navigate to fourth file in list" })
    end,
    keys = {
        "<C-e>",
        "<leader>ha",
        "<leader>j",
        "<leader>k",
        "<leader>l",
        "<leader>'",
        -- "<C-I>",
    },
}
