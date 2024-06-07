return {
    "zbirenbaum/copilot.lua",
    -- enabled = false,
    opts = { suggestion = { auto_trigger = true } },
    keys = {
        {
            "<leader>cd",
            "<cmd>Copilot disable<CR>",
            desc = "Disable Copilot",
            silent = false,
        },
        {
            "<leader>ce",
            "<cmd>Copilot enable<CR>",
            desc = "Enable Copilot",
            silent = false,
        },
    },
}
