vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.colorcolumn = "80"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.wildignore:append({
    -- Ignore binary files
    "*.o",
    "*.a",
    "*.class",
    -- Ignore image files
    "*.png",
    "*.jpg",
    "*.bmp",
    "*.gif",
    "*.ico",
    -- Ignore useless directories
    ".DS_Store",
    ".git",
    ".hg",
    ".svn",
    -- Ignore temporary files directories
    "+*~",
    "*.sw?",
    "*.tmp",
})

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Set vertical split to the right
vim.o.splitright = true
