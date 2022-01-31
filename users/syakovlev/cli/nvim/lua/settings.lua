local utils = require('utils')

local cmd = vim.cmd
local indent = 2

cmd 'syntax enable'
cmd 'filetype plugin indent on'

-- Global variables
vim.g.t_Co = 256
vim.o.updatetime = 100

-- general
utils.opt('o', 'mouse', 'a')
utils.opt('o', 'hidden', true)
utils.opt('w', 'number', true)
utils.opt('o', 'clipboard', 'unnamedplus')
-- utils.opt('o', 'clipboard','unnamed,unnamedplus')
utils.opt('o', 'completeopt', 'menuone,noselect')

-- visual
utils.opt('w', 'cursorline', true)
utils.opt('o', 'scrolloff', 2)
utils.opt('o', 'shiftround', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'wildmode', 'list:longest')

-- tabs
utils.opt('b', 'tabstop', indent)
utils.opt('b', 'softtabstop', indent)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'expandtab', true)
utils.opt('b', 'smartindent', true)
utils.opt('o', 'smarttab', true)
utils.opt('o', 'foldenable', false)
utils.opt('o', 'foldmethod', 'indent')
utils.opt('o', 'foldlevelstart', 2)
utils.opt('o', 'listchars',
          'eol:$,tab:>-,space:.,trail:~,extends:>,precedes:<,nbsp:+')

-- search 
utils.opt('o', 'smartcase', true)
utils.opt('o', 'showmatch', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'incsearch', true)
utils.opt('o', 'hlsearch', true)
utils.opt('o', 'inccommand', 'nosplit')

-- language
utils.opt('o', 'spelllang', 'ru,en_us')
utils.opt('o', 'keymap', 'russian-jcukenwin')
utils.opt('o', 'iminsert', 0)
utils.opt('o', 'imsearch', 0)

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- UI
utils.opt('o', 'termguicolors', true)
utils.opt('o', 'signcolumn', "auto:3")
utils.opt('o', 'showmode', false)
utils.opt('o', 'guicursor',
          'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175')
