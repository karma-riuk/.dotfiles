return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
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
                "stylua",
            },
            automatic_setup = true,
            automatic_installation = false,
            handlers = {
                latexindent = function()
                    null_ls.register(null_ls.builtins.formatting.latexindent.with({
                        extra_args = {
                            "-g",
                            "/dev/null",
                            "-m",
                            "-l",
                            os.getenv("XDG_CONFIG_HOME") .. "/latexindent/defaultSettings.yaml",
                        },
                    }))
                end,
                clang_format = function()
                    null_ls.register(null_ls.builtins.formatting.clang_format.with({
                        extra_args = { "--style=file:" .. os.getenv("XDG_CONFIG_HOME") .. "/clang-format" },
                    }))
                end,
                luacheck = function()
                    null_ls.register(null_ls.builtins.diagnostics.luacheck.with({
                        extra_args = {
                            "--globals",
                            "vim",
                            "awesome",
                            "client",
                            "root",
                        },
                    }))
                end,
            },
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
