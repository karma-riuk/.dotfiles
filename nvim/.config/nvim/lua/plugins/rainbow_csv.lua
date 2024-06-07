return {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    init = function()
        vim.cmd(
            "let g:rcsv_colorpairs = [['red', 'red'], ['green', 'green'], ['magenta', 'magenta'], ['NONE', 'NONE'], ['darkred', 'darkred'], ['darkgreen', 'darkgreen'], ['darkmagenta', 'darkmagenta'], ['darkcyan', 'darkcyan'], ['darkyellow', 'darkyellow']]"
        )
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
