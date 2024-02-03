return {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            init = function()
                vim.g.skip_ts_context_commentstring_module = true
            end,
            setup = false,
        },
    },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = {
                "bash", -- "bibtex",
                "c",
                "cpp",
                "go",
                "html",
                "java",
                "json", -- "latex",
                "lua",
                "markdown",
                "markdown_inline",
                "matlab",
                "python",
                "rust",
                "scala",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
            },

            -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
            auto_install = false,

            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = "<c-s>",
                    node_decremental = "<M-space>",
                },
            },
            context_commentstring = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                },
            },
        })
    end,
}
