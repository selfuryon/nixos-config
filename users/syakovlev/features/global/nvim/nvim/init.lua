vim.cmd ('syntax enable')
vim.cmd ('filetype plugin indent on')

-- Global variables
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.t_Co = 256
vim.o.updatetime = 100

-- general
vim.o.mouse = 'a'
vim.o.hidden = true
vim.o.number = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'

-- visual
vim.o.cursorline = true
vim.o.scrolloff = 2
vim.o.shiftround = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wildmode = 'list:longest'

-- tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.foldenable = false
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 2
vim.o.listchars = 'eol:$,tab:>-,space:.,trail:~,extends:>,precedes:<,nbsp:+'
vim.o.wildmode = "full:longest"

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

-- Common
local options = {noremap = true}
vim.api.nvim_set_keymap('n', '<F3>', '<cmd>set list!<CR>', options)
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', options)
vim.api.nvim_set_keymap('n', '<A-3>', '<cmd>SymbolsOutline<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>F', '<cmd>Format<CR>', options)

-- Window navigation
vim.api.nvim_set_keymap('n', '<A-h>', '<C-W>h', options)
vim.api.nvim_set_keymap('n', '<A-j>', '<C-W>j', options)
vim.api.nvim_set_keymap('n', '<A-k>', '<C-W>k', options)
vim.api.nvim_set_keymap('n', '<A-l>', '<C-W>l', options)

-- Disable arrows
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', options)

