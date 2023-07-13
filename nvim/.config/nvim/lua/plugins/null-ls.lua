return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-null-ls").setup({
            ensure_installed = {
                -- [[ Linters ]]
                "eslint_d",
                "luacheck",
                "pylint",
                -- "vale",

                -- [[ Formatters ]]
                "beautysh",
                "blue",
                "clang-format",
                "gofumpt",
                "jq",
                "latexindent",
                "prettier",
                "stylua",
            },
            automatic_setup = true,
            automatic_installation = false,
            handlers = {},
        })

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        require("null-ls").setup({
            border = "single",
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                            -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
            sources = {
                -- Anything not supported by mason.
            },
        })
    end,
}
