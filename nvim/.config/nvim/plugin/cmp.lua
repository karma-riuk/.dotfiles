-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.compose({ "expand", "select_next_item" })(fallback)
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.jump_forwards(fallback)
        end, { "i" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "ultisnips" },
        { name = "buffer", keyword_length = 5, max_item_count = 3 },
        { name = "spell", keyword_length = 5, max_item_count = 2 },
        { name = "path" },
    },
    formatting = {
        format = lspkind.cmp_format({
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

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "cmdline", max_item_count = 5 } },
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer", max_item_count = 5 } },
})
