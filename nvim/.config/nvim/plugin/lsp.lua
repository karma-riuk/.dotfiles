-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- nvim lua api
require("neodev").setup()

-- for winbar context
local navic = require("nvim-navic")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")

    -- Mappings.
    local opts = { noremap = true, silent = false, buffer = bufnr }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>Do", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>Dk", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>Dj", vim.diagnostic.goto_next, opts)
end

require("mason").setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler (optional)
        local setup = {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = { debounce_text_changes = 150 },

            -- Have border around floating windows
            handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            },
        }

        if server_name == "sumneko_lua" then
            setup.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
        end

        -- if server_name == "clangd" then
        -- print("world")
        setup.capabilities.offsetEncoding = "utf-8"
        -- end

        require("lspconfig")[server_name].setup(setup)
    end,
})

require("mason-null-ls").setup({
    automatic_setup = true,
    ensure_installed = { "stylua", "jq", "vale" },
})
require("null-ls").setup({
    on_init = function(new_client, _)
        new_client.offset_encoding = "utf-32"
    end,
    sources = {
        require("null-ls").builtins.diagnostics.vale,
    },
})

-- local win = require("lspconfig.ui.windows")
-- local _default_opts = win.default_opts
--
-- win.default_opts = function(options)
--     local opts = _default_opts(options)
--     opts.border = "single"
--     return opts
-- end

-- local group = vim.api.nvim_create_augroup("Mason", { clear = true })
-- vim.api.nvim_create_autocmd(
--     "FileType",
--     { pattern = "mason", group = group, command = "hi LineNr guibg=None ctermbg=None" }
-- )
