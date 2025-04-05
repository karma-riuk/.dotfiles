function get_dictionary_words()
    local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
    local words = {}

    for word in io.open(path, "r"):lines() do
        table.insert(words, word)
    end
    return words
end

local servers = {
    bashls = {},
    clangd = {},
    cssls = {},
    gopls = {},
    html = {},
    -- ltex = {
    --     ltex = {
    --         checkFrequency = "save",
    --         dictionary = {
    --             ["en-US"] = get_dictionary_words(),
    --             ["en-GB"] = get_dictionary_words(),
    --         },
    --     },
    -- },
    texlab = {},
    pyright = {
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "openFilesOnly",
                },
            },
        },
    },
    -- tsserver = {},
    vimls = {},

    lua_ls = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = { globals = { "vim", "awesome", "client", "root" } },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    vim.api.nvim_get_runtime_file("", true),
                    "/usr/share/awesome/lib",
                },
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
            completion = { callSnippet = "Replace" },
        },
    },
}

local enable_formatting = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        if vim.tbl_contains(require("karma.format").exclusion_list, client.name) then
            print("Skipping formatting for " .. client.name)
            return
        end
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                -- vim.lsp.buf.format({ async = false })
                require("karma.format").format()
            end,
        })
    end
end

local on_attach = function(client, bufnr)
    enable_formatting(client, bufnr)

    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("gO", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("gh", "<cmd>Lspsaga finder<cr>", "LspSaga finder")
    nmap("gp", "<cmd>Lspsaga peek_definition<CR>", "[p]eak definition")

    -- nmap("<leader>e", "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>")
    -- nmap("<leader>E", "<cmd>Lspsaga show_buf_diagnostics<CR>")

    -- nmap("gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "LSP: [g]oto defintion" })

    -- nmap("<leader>r", "<cmd>Lspsaga rename ++project<CR>")
    -- nmap("gt", "<cmd>Lspsaga peek_type_definition<CR>")

    -- See `:help K` for why this keymap
    -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

return {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        {
            "j-hui/fidget.nvim",
            tag = "legacy",
            opts = {
                window = {
                    relative = "editor",
                    winblend = 0, -- doesn't work to disable black bg
                    -- border = "single",
                },
            },
        }, -- Additional lua configuration, makes nvim stuff amazing!
        { "folke/neodev.nvim", config = true },
        {
            "glepnir/lspsaga.nvim",
            opts = { symbol_in_winbar = { enable = false } },
            dependencies = {
                { "nvim-tree/nvim-web-devicons" },
                -- Please make sure you install markdown and markdown_inline parser
                { "nvim-treesitter/nvim-treesitter" },
            },
        },
    },
    config = function()
        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        capabilities.offsetEncoding = "utf-8"

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

        require("lspconfig.ui.windows").default_options = { border = "rounded" }

        -- Ensure the servers above are installed
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup({
            automatic_installation = true,
            ensure_installed = vim.tbl_keys(servers),
        })

        mason_lspconfig.setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                })
            end,
        })
    end,
}
