-- hop configuration
require('hop').setup()
local hop = require('hop')
local directions = require('hop.hint').HintDirection
local options = {noremap=true}

-- Hop bindings
local km = vim.keymap
km.set('n', '//', [[<cmd>lua require('hop').hint_patterns()<CR>]], options)
km.set('n', '<leader>h', [[<cmd>lua require('hop').hint_patterns()<CR>]], options)
km.set('n', '<leader>j', [[<cmd>lua require('hop').hint_words()<CR>]], options)
km.set('n', '<leader>l', [[<cmd>lua require('hop').hint_lines()<CR>]], options)
km.set('n', '<leader>2', [[<cmd>lua require('hop').hint_char2()<CR>]], options)


km.set('', 'f', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end, options)
km.set('', 'F', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end, options)
km.set('', 't', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end, options)
km.set('', 'T', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end, options)
