local servers = {
    bashls = {},
    clangd = {},
    cssls = {},
    gopls = {},
    html = {},
    ltex = {},
    texlab = {},
    pyright = {},
    rust_analyzer = {},
    tsserver = {},
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
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
}

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>r", vim.lsp.buf.rename, "[R]ename")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("gh", "<cmd>Lspsaga finder<cr>", "LspSaga finder")
    nmap("gp", "<cmd>Lspsaga peek_definition<CR>", "[p]eak definition")

    nmap("<leader>e", "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>")
    nmap("<leader>E", "<cmd>Lspsaga show_buf_diagnostics<CR>")

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
        { "williamboman/mason.nvim", config = true },
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
        },

        -- Additional lua configuration, makes nvim stuff amazing!
        { "folke/neodev.nvim", config = true },
        {
            "glepnir/lspsaga.nvim",
            opts = {
                symbol_in_winbar = {
                    enable = false,
                },
            },
            dependencies = {
                { "nvim-tree/nvim-web-devicons" },
                --Please make sure you install markdown and markdown_inline parser
                { "nvim-treesitter/nvim-treesitter" },
            },
        },
    },
    config = function()
        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        capabilities.offsetEncoding = "utf-8"

        -- Ensure the servers above are installed
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup({
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

        require("lspconfig.ui.windows").default_options = {
            border = "rounded",
        }
        -- matlab really is special...
        require("lspconfig").matlab_ls.setup({})
    end,
}
