set nocompatible

" Plugins
call plug#begin(stdpath('data') . '/plugged')
""Theme
" Plug 'acoustichero/goldenrod.vim'

Plug 'tpope/vim-sensible'
Plug 'suan/vim-instant-markdown', { 'for' : 'markdown' }

Plug 'nvim-lualine/lualine.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'yggdroot/indentline'
Plug 'ap/vim-css-color'
" Highlighting search patterns when needed
Plug 'romainl/vim-cool'
Plug 'sainnhe/sonokai'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'szw/vim-maximizer'

Plug 'puremourning/vimspector'
Plug 'jason0x43/vim-wildgitignore'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'f3fora/cmp-spell'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'numToStr/Comment.nvim'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'mhartington/formatter.nvim'

Plug 'TimUntersberger/neogit'
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/toggleterm.nvim'

Plug 'ThePrimeagen/harpoon'

" Popups and input dialogs
Plug 'stevearc/dressing.nvim'


" PlantUML
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'

" Firenvim (nvim textbox in browser)
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" TS Text objects
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
call plug#end()

" Command
" command Src execute "so " . $MYVIMRC
command Src execute "so " . "~/.config/nvim/init.vim"

" Disabeling q: and Q (q: for search through last vim commands, Q for Ex mode)
nnoremap q: <nop>
nnoremap Q <nop>

" Look and feel
"" Colorscheme
set background=dark

" let g:sonokai_style = 'andromeda'
" let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnostic_virtual_text = 'colored'
colorscheme sonokai

"" Enable transparency
hi Normal ctermbg=None
hi Terminal ctermbg=None

set helpheight=40


"" Spelling errors
hi SpellBad ctermfg=red

"" Show keystrokes as they are pressed
set showcmd
set hlsearch incsearch
set wildmenu wildmode=longest:full,full
""" Ignore binary files
set wildignore+=*.a,*.o,*.class
""" Ignore image files
set wildignore+=*.png,*.jpg,*.bmp,*.gif,*.ico
""" Ignore useless directories
set wildignore+=.DS_Store,.git,.hg,.svn
""" Ignore temporary files directories
set wildignore+=+*~,*.sw?,*.tmp
" set updatetime=100
" set timeoutlen=1000 ttimeoutlen=10
set signcolumn=yes


"
set number relativenumber
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set tw=80
set scrolloff=8

"" Left side number column foreground color
hi LineNr ctermfg=darkgray

"" What to show when ':set list' is called (to show tabs, end of lines, spaces, etc.)
" set listchars=eol:¬,tab:\ »\ ,space:·,trail:█

"" Splits
set splitright

"" Smart case for searching
set ignorecase smartcase

" Mapings
let mapleader = ","

"" Saving and quitting
map <leader>s :w<Cr>
map <leader>jk :wq<Cr>
map <leader>q :q<Cr>
map <leader>Q :q!<Cr>


"" Fixing Y
map Y y$

"" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

"" Undo breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ( (<c-g>u
inoremap ) )<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u
inoremap { {<c-g>u
inoremap } }<c-g>u

"" Split window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

""" Same but for the terminal
" tmap <C-h> <C-w>h
" tmap <C-j> <C-w>j
" tmap <C-k> <C-w>k
" tmap <C-l> <C-w>l

"" Renaming vairables
map <leader>r :s/<C-R><C-W>//g<left><left>
map <leader>R :%s/<C-R><C-W>//gc<left><left><left>

"" Rapiddly correcting mispelled word
map <leader>z 1z=

"" Print and paste from  system clipboard
map <leader>p "+p
map <leader>P "+P
map <leader>y "+y
map <leader>Y "+Y
map <leader>d "+d
map <leader>D "+D

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


"" Fixing mistakes I usually make
imap <C-b> <Esc>b

"" Terminal mappings
tnoremap <C-n> <C-\><C-n>

" Filetype specific settings
"" Setting the filetype of service files
" augroup Compliers
"     autocmd!
"     autocmd Filetype c,cpp command -nargs=* Make make <args> | cwindow 10
"     autocmd Filetype c,cpp nmap <silent> <leader>m :make compile \| cwindow 10 <cr>
" augroup END

augroup TerminalNoSpell
    au TermOpen * setlocal nospell
augroup END

augroup RememberLastPosition
    autocmd!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zv" | endif
augroup END

"" Setting the filetype of service files
augroup Services
    autocmd!
    autocmd BufNewFile,BufRead *.service set ft=dosini
augroup END

"" Reloading configs after saving files
augroup ReloadConfigs
    autocmd!
    autocmd BufWritePost dunstrc silent exec "!killall dunst" | redraw!
augroup END

" Plugin settings

"" vim-cool
let g:CoolTotalMatches = 1

"" Indentline
let g:indentLine_char = '│'
let g:indentLine_color_term = 237

"" Auto-pairs
let g:AutoPairsShortcutToggle = '<leader>('
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-v>' " default: <M-b>, changed because otherwise doing <esc>b might do something unintended and it triggered be a lot

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 200})
augroup END

"" LSP Signature
lua require('lsp_signature').setup()

"" Git signs
lua require('gitsigns').setup()

"" Neogit
lua require('neogit').setup()

"" Dressing
lua require('dressing').setup()
