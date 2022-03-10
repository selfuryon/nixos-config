-- Common
local options = {noremap = true}
vim.api.nvim_set_keymap('n', '<F3>', '<cmd>set list!<CR>', options)
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', options)
vim.api.nvim_set_keymap('n', '<A-3>', '<cmd>SymbolsOutline<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>F', '<cmd>Format<CR>', options)

-- Window navigation
-- utils.map('n', '<A-h>', '<C-W>h')
-- utils.map('n', '<A-j>', '<C-W>j')
-- utils.map('n', '<A-k>', '<C-W>k')
-- utils.map('n', '<A-l>', '<C-W>l')

local silent_options = {noremap = true, silent=true}
vim.g.tmux_navigator_no_mappings = 1
vim.api.nvim_set_keymap('n', '<m-h>', '<cmd>TmuxNavigateLeft<CR>', silent_options)
vim.api.nvim_set_keymap('n', '<m-j>', '<cmd>TmuxNavigateDown<CR>', silent_options)
vim.api.nvim_set_keymap('n', '<m-k>', '<cmd>TmuxNavigateUp<CR>', silent_options)
vim.api.nvim_set_keymap('n', '<m-l>', '<cmd>TmuxNavigateRight<CR>', silent_options)

-- Disable arrows
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', options)

-- Hop bindings
vim.api.nvim_set_keymap ('n', '//', [[<cmd>lua require('hop').hint_patterns()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>j', [[<cmd>lua require('hop').hint_words()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>l', [[<cmd>lua require('hop').hint_lines()<CR>]], options)
