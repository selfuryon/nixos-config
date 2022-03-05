local utils = require('utils')

-- Common
utils.map('n', '<F3>', '<cmd>set list!<CR>')
utils.map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
utils.map('n', '<A-3>', '<cmd>SymbolsOutline<CR>')
utils.map('n', '<leader>F', '<cmd>Format<CR>')

-- Window navigation
-- utils.map('n', '<A-h>', '<C-W>h')
-- utils.map('n', '<A-j>', '<C-W>j')
-- utils.map('n', '<A-k>', '<C-W>k')
-- utils.map('n', '<A-l>', '<C-W>l')

vim.g.tmux_navigator_no_mappings = 1
utils.map('n', '<m-h>', '<cmd>TmuxNavigateLeft<CR>', {noremap=true, silent=true})
utils.map('n', '<m-j>', '<cmd>TmuxNavigateDown<CR>', {noremap=true, silent=true})
utils.map('n', '<m-k>', '<cmd>TmuxNavigateUp<CR>', {noremap=true, silent=true})
utils.map('n', '<m-l>', '<cmd>TmuxNavigateRight<CR>', {noremap=true, silent=true})

-- Disable arrows
utils.map('n', '<Up>', '<Nop>')
utils.map('n', '<Down>', '<Nop>')
utils.map('n', '<Left>', '<Nop>')
utils.map('n', '<Right>', '<Nop>')

-- Hop bindings
utils.map('n', '//', [[<cmd>lua require('hop').hint_patterns()<CR>]])
utils.map('n', '<leader>j', [[<cmd>lua require('hop').hint_words()<CR>]])
utils.map('n', '<leader>l', [[<cmd>lua require('hop').hint_lines()<CR>]])
