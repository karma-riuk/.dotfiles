require("lualine").setup({
    options = {
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
    },
    extensions = {
        "toggleterm",
        "man",
    },
})
