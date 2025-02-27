return {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        -- Adds LSP completion capabilities
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "f3fora/cmp-spell",
        "petertriho/cmp-git",

        -- Adds a number of user-friendly snippets
        "rafamadriz/friendly-snippets",

        -- Vscode-like pictograms for neovim lsp completion items
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()
        luasnip.config.setup({})

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = { documentation = cmp.config.window.bordered() },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete({}),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                        -- elseif luasnip.locally_jumpable(-1) then
                        --     luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = {
                { name = "nvim_lsp" },
                {
                    name = "luasnip",
                    entry_filter = function(entry, ctx)
                        local before_cursor = ctx.cursor_before_line
                        -- If the string before cursor is exactly "...", filter out specific entries
                        if before_cursor:match("%.$") then
                            local item = entry:get_completion_item()
                            if item.data.filetype == "tex" and item.label == "..." then
                                return false
                            end
                        end
                        return true
                    end,
                },
                -- { name = "ultisnips" },
                { name = "buffer",  keyword_length = 5, max_item_count = 3 },
                { name = "spell",   keyword_length = 5, max_item_count = 2 },
                { name = "path" },
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.kind,
                },
            },
            formatting = {
                format = require("lspkind").cmp_format({
                    with_text = true, -- do not show text alongside icons
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    menu = {
                        buffer = "[Buf]",
                        nvim_lsp = "[LSP]",
                        path = "[Path]",
                        spell = "[Spell]",
                    },
                }),
            },
            experimental = { ghost_text = true },
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, { { name = "buffer" } }),
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = "buffer" } },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
        })
    end,
}
