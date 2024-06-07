local M = {}

M.exclusion_list = {
    "clangd",
    "texlab",
    "lua-ls",
}

M.format = function()
    vim.lsp.buf.format({
        async = false,
        filter = function(client)
            return not vim.tbl_contains(M.exclusion_list, client.name)
        end,
    })
end

return M
