function blue()
    local h = require("null-ls.helpers")
    local methods = require("null-ls.methods")

    local FORMATTING = methods.internal.FORMATTING

    return h.make_builtin({
        name = "blue",
        meta = {
            url = "https://github.com/grantjenks/blue",
            description = "Blue -- Some folks like black but I prefer blue.",
        },
        method = FORMATTING,
        filetypes = { "python" },
        generator_opts = {
            command = "blue",
            args = {
                "--stdin-filename",
                "$FILENAME",
                "--quiet",
                "-",
            },
            to_stdin = true,
        },
        factory = h.formatter_factory,
    })
end
return {
    "jay-babu/mason-null-ls.nvim",
    -- enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
        "gbprod/none-ls-luacheck.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        -- local helpers = require("null-ls.helpers")
        require("mason").setup()
        require("mason-null-ls").setup({
            ensure_installed = {
                -- [[ Linters ]]
                "eslint_d",
                "luacheck",
                -- "vale",
                -- [[ Formatters ]]
                "beautysh",
                "blue",
                "clang-format",
                "gofumpt",
                "stylua",
            },
            automatic_setup = true,
            automatic_installation = false,
            handlers = {
                clang_format = function()
                    null_ls.register(null_ls.builtins.formatting.clang_format.with({
                        extra_args = { "--style=file:" .. os.getenv("XDG_CONFIG_HOME") .. "/clang-format" },
                    }))
                end,
                luacheck = function()
                    null_ls.register(require("none-ls-luacheck.diagnostics.luacheck").with({
                        extra_args = {
                            "--globals",
                            "vim",
                            "awesome",
                            "client",
                            "root",
                        },
                    }))
                end,
                blue = function()
                    null_ls.register(blue().with({
                        extra_args = { "--config", os.getenv("XDG_CONFIG_HOME") .. "/blue/pyproject.toml" },
                    }))
                end,
            },
        })

        local augroup = vim.api.nvim_create_augroup("NullLspFormatting", {})


        require("null-ls").setup({
            border = "single",
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            require("karma.format").format()
                        end,
                    })
                end
            end,
            sources = {
            },
        })
    end,
}
