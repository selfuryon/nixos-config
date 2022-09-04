-- hop configuration
require('hop').setup()

-- Hop bindings
vim.api.nvim_set_keymap ('n', '//', [[<cmd>lua require('hop').hint_patterns()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>j', [[<cmd>lua require('hop').hint_words()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>l', [[<cmd>lua require('hop').hint_lines()<CR>]], options)
