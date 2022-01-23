" XDG
" set undodir=$XDG_DATA_HOME/vim/undo
" set directory=$XDG_DATA_HOME/vim/swap
" set backupdir=$XDG_DATA_HOME/vim/backup 
" set viewdir=$XDG_DATA_HOME/vim/view
" set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after

set nocompatible

" Plugins
call plug#begin(stdpath('data') . '/plugged')
""Theme
" Plug 'acoustichero/goldenrod.vim' 
" Plug 'preservim/nerdcommenter'

Plug 'tpope/vim-sensible'
Plug 'suan/vim-instant-markdown', { 'for' : 'markdown' }
Plug 'xuhdev/vim-latex-live-preview', { 'for' : 'tex' }
Plug 'itchyny/lightline.vim'
Plug 'SirVer/ultisnips'
" Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'yggdroot/indentline'
Plug 'ap/vim-css-color'
" Highlighting search patterns when needed
Plug 'romainl/vim-cool'
Plug 'sainnhe/sonokai'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'

" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'tacahiroy/ctrlp-funky'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Plug 'nikvdp/ejs-syntax'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'szw/vim-maximizer'
" Plug 'ymagossou/Conque-GDB', { 'for': 'c' }
Plug 'puremourning/vimspector'
Plug 'jason0x43/vim-wildgitignore'

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

Plug 'sbdchd/neoformat'

Plug 'TimUntersberger/neogit'
Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/toggleterm.nvim'

Plug 'ThePrimeagen/harpoon'
call plug#end()

" Command
" command Src execute "so " . $MYVIMRC
" command Src execute "so " . "~/.config/nvim/init.vim"

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

"" Print and paste from clipboard
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
augroup SetSpell
    autocmd!
    autocmd FileType tex,markdown set spell
augroup END

"" Reloading configs after saving files
augroup ReloadConfigs
    autocmd!
    autocmd BufWritePost dunstrc silent exec "!killall dunst" \| redraw!
augroup END

"" Disable the indent lines plugins on files that use italize / bold / etc...
"" because it gets wierd
augroup DisableIndents
    autocmd!
    autocmd FileType tex,markdown set conceallevel=2 | let g:indentLine_enabled = 0 | let g:indentLine_color_term = 5
augroup END

" Plugin settings

"" Markdown previewer
let g:instant_markdown_browser = "qutebrowser --target window"

"" LateX previewer
let g:livepreview_previewer = 'zathura'

"" Lightline
""" Enable statuline for single buffer
set laststatus=2
""" Disable '--INSERT--' below the status line
set noshowmode

"" Ultisnips
""" Trigger configuration
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

""" Split snippet edit vertically
let g:UltiSnipsEditSplit="vertical"

""" Help ultisnips find the location of the dot directory of vim
let g:UltiSnipsSnippetsDir = expand("$XDG_CONFIG_HOME/vim/ultisnips")
" let g:UltiSnipsSnippetDirectories = [expand("$XDG_CONFIG_HOME/vim/ultisnips"), 'UltiSnips']
" let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = "~/.config/vim/plugged/vim-snippets/snippets"

" augroup LATEX_RTP
"     autocmd!
"     autocmd Filetype tex set rtp-=~/.dotfiles/vim/.config/vim/plugged/vim-snippets " to fix the issue with vim-polyglot and snippets duplication of snippets
" augroup END

let g:CoolTotalMatches = 1

"" Indentline
let g:indentLine_char = '│'
let g:indentLine_color_term = 237

"" vimtex
let g:vimtex_quickfix_ignore_filters = [
            \ '\v(Over|Under)full',
            \]

" let g:vimtex_enabled = 0
" let g:tex_fast = 'bMpr'
" let g:tex_fast = ''
let g:vimtex_matchparen_enabled = 0
let g:vimtex_imaps_enabled = 0 " vimtex imaps are cool by nothing compared to ultisnips
set conceallevel=2

let g:vimtex_delim_toggle_mod_list = [
            \ ['\left', '\right'],
            \ ['\bigl', '\bigr'],
            \ ['\biggl', '\biggr'],
            \ ['\Biggl', '\Biggr'],
            \]

augroup MyVimtex
  autocmd!
  " autocmd User VimtexEventQuit call vimtex#latexmk#clean(0)
  autocmd User VimtexEventQuit VimtexClean
augroup END

"" Auto-pairs
let g:AutoPairsShortcutToggle = '<leader>('
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-v>' " default: <M-b>, changed because otherwise doing <esc>b might do something unintended and it triggered be a lot

augroup Latex_Dollar_Separator
    autocmd!
    autocmd FileType tex let g:AutoPairs = {
                \ '(':')',
                \ '[':']',
                \ '{':'}',
                \ "$":"$",
                \ "$$":"$$",
                \ }
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 200})
augroup END

"" ConqueGDB
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly 
let g:ConqueGdb_Leader = '\' 

"" Maximizer
nnoremap <leader>m :MaximizerToggle!<CR>
vnoremap <leader>m :MaximizerToggle!<CR>gv

"" Vimspector
nmap <leader>dd <Plug>VimspectorContinue
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nmap <leader>de :call vimspector#Reset()<Cr>


nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

"" Telescope
noremap <C-p> :Telescope git_files<cr>
nnoremap <F11> <cmd>Telescope help_tags<cr>
lua << EOF
local t = require('telescope')
t .setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
            }
        }
    }
t.load_extension('fzy_native')
EOF

nnoremap <C-f> <cmd>Telescope find_files<cr>
" nnoremap <C-p><C-g> <cmd>Telescope live_grep<cr>

"" Harpoon
nnoremap <silent><leader>fa :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
" nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

nnoremap <silent><leader>fj :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><leader>fk :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><leader>fl :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><leader>f; :lua require("harpoon.ui").nav_file(4)<CR>

"" Comment.nvim
lua require('Comment').setup()

"" LSP Signature
lua require('lsp_signature').setup()

"" Git signs
lua require('gitsigns').setup()

""" Lightline colorscheme
let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'githead', 'readonly', 'filename', 'modified'],
      \             [ 'gitstatus'] ]
      \ },
      \ 'component_function': {
          \   'githead': "GitHead",
          \   'gitstatus': "GitStatus"
      \ },
      \ }

fun! GitHead()
    let b = get(b:,'gitsigns_head','')
    return b == "" ? "" : " " . b
endf

fun! GitStatus()
    return get(b:,'gitsigns_status','')
endf

"" Neoformat
let g:neoformat_tex_latexindent = {
        \ 'exe': 'latexindent',
        \ 'stdin': 1,
        \ }

augroup fmt
  autocmd!
  " autocmd BufWritePre * undojoin | Neoformat
augroup END

"" Neogit
lua require('neogit').setup()

"" Nvim-web-devicons
lua << EOF
require'nvim-web-devicons'.setup {
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
        zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
            }
        };
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true;
    }
EOF


"" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup { 
    context_commentstring = {
        enable = true 
        },
    highlight = {
        enable = true,
        disable = { "latex" },
        },
    indent = {
        enable = true,
        disable = { "c", "cpp" },
        },
    }
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
augroup Fold
    autocmd!
    autocmd FileType c,cpp set fdm=manual | set foldexpr=
augroup END

lua << EOF

local nvim_lsp = require('lspconfig')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=false }
  local formattingParams = vim.lsp.util.make_formatting_params({tabSize = 6})
  -- formatingParams.options.tabSize = 10;

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting({tabSize = 4, trimTrailingWhitespace = false})<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'pyright', 'bashls', 'cssls', 'tsserver', 'html'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end


-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


-- nvim-cmp setup
local cmp = require 'cmp'
local lspkind = require('lspkind')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
        },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
            },
        ["<Tab>"] = cmp.mapping(
          function(fallback)
            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
          end,
          { "i" }
        ),
        ["<S-Tab>"] = cmp.mapping(
          function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
          end,
          { "i" }
        ),
},
  sources = {
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      -- { name = 'buffer', keyword_length = 5, max_item_count = 3 },
      -- { name = 'spell', keyword_length = 5, max_item_count = 2},
      { name = 'path' },
      },
  formatting = {
      format = lspkind.cmp_format({
      with_text = true, -- do not show text alongside icons
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      menu = {
          buffer = '[Buf]',
          nvim_lsp = '[LSP]',
          path = '[Path]',
          spell = '[Spell]',
        },
    })
  },
  experimental = {
      ghost_text = true,
      }

}

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' , max_item_count = 5}
  }
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' , max_item_count = 5 }
  }
})

require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.35
    end
  end,
  open_mapping = [[<c-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = 'horizontal',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = 'single',
    width = 175,
    height = 25,
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}
EOF
