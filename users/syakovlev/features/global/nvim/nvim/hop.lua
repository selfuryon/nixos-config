-- hop configuration
require('hop').setup()
local hop = require('hop')
local directions = require('hop.hint').HintDirection
local options = {noremap=true}

-- Hop bindings
vim.api.nvim_set_keymap ('n', '//', [[<cmd>lua require('hop').hint_patterns()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>h', [[<cmd>lua require('hop').hint_patterns()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>j', [[<cmd>lua require('hop').hint_words()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>l', [[<cmd>lua require('hop').hint_lines()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>2', [[<cmd>lua require('hop').hint_char2()<CR>]], options)


vim.keymap.set('', 'f', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end, options)
vim.keymap.set('', 'F', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end, options)
vim.keymap.set('', 't', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end, options)
vim.keymap.set('', 'T', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end, options)
