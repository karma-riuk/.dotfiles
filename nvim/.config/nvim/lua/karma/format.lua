local M = {}

M.exclusion_list = {
    "clangd",
    "lua-ls",
    "lua_ls",
}

M.format = function()
    vim.lsp.buf.format({
        async = false,
        timeout_ms = 5000,
        filter = function(client)
            return not vim.tbl_contains(M.exclusion_list, client.name)
        end,
    })
end

return M
