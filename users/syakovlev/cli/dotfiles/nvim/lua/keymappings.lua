local utils = require('utils')

-- Common
utils.map('n', '<F3>', '<cmd>set list!<CR>')
utils.map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
utils.map('n', '<A-3>', '<cmd>SymbolsOutline<CR>')
utils.map('n', '<leader>F', '<cmd>Format<CR>')

-- Window navigation
utils.map('n', '<A-h>', '<C-W>h')
utils.map('n', '<A-j>', '<C-W>j')
utils.map('n', '<A-k>', '<C-W>k')
utils.map('n', '<A-l>', '<C-W>l')
-- utils.map('n', '<C-h>', '<C-W>h')
-- utils.map('n', '<C-j>', '<C-W>j')
-- utils.map('n', '<C-k>', '<C-W>k')
-- utils.map('n', '<C-l>', '<C-W>l')

-- Disable arrows
utils.map('n', '<Up>', '<Nop>')
utils.map('n', '<Down>', '<Nop>')
utils.map('n', '<Left>', '<Nop>')
utils.map('n', '<Right>', '<Nop>')

-- Hop bindings
utils.map('n', '//', [[<cmd>lua require('hop').hint_patterns()<CR>]])
utils.map('n', '<leader>j', [[<cmd>lua require('hop').hint_words()<CR>]])
utils.map('n', '<leader>l', [[<cmd>lua require('hop').hint_lines()<CR>]])
