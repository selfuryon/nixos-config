local cmd = vim.cmd
local indent = 2

cmd 'syntax enable'
cmd 'filetype plugin indent on'

-- Global variables
vim.g.t_Co = 256
vim.o.updatetime = 100

-- general
vim.o.mouse = 'a'
vim.o.hidden = true
vim.opt.number = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'

-- visual
vim.w.cursorline = true
vim.o.scrolloff = 2
vim.o.shiftround = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wildmode = 'list:longest'

-- tabs
vim.b.tabstop = 'indent'
vim.b.softtabstop = 'indent'
vim.b.shiftwidth = 'indent'
vim.b.expandtab = true
vim.b.smartindent = true
vim.o.smarttab = true
vim.o.foldenable = false
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 2
vim.o.listchars = 'eol:$,tab:>-,space:.,trail:~,extends:>,precedes:<,nbsp:+'

-- search 
vim.o.smartcase = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.inccommand = 'nosplit'

-- language
vim.o.spelllang = 'ru,en_us'
vim.o.keymap = 'russian-jcukenwin'
vim.o.iminsert = 0
vim.o.imsearch = 0

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- UI
vim.o.termguicolors = true
vim.o.signcolumn = "auto:3"
vim.o.showmode = false
vim.o.guicursor ='n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
