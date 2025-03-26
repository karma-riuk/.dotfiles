return {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    init = function()
        vim.cmd([[
        let g:rcsv_colorlinks = ['String', 'Title', 'NONE', 'Special', 'Keyword', 'Float', 'CursorLineNr', 'ModeMsg', 'Question']
        let g:disable_rainbow_statusline = 1
        ]])
    end,
    ft = {
        "csv",
        "tsv",
        "csv_semicolon",
        "csv_whitespace",
        "csv_pipe",
        "rfc_csv",
        "rfc_semicolon",
    },
    cmd = {
        "RainbowDelim",
        "RainbowDelimSimple",
        "RainbowDelimQuoted",
        "RainbowMultiDelim",
    },
}
