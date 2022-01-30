local utils = require('utils')

local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      }
    }
  }
}

utils.map('n', '<leader><space>',
          [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
utils.map('n', '<leader>ff',
          [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
utils.map('n', '<leader>fp',
          [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
utils.map('n', '<leader>ft',
          [[<cmd>lua require('telescope.builtin').treesitter()<CR>]])
utils.map('n', '<leader>fb',
          [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
utils.map('n', '<leader>fh',
          [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
utils.map('n', '<leader>fd',
          [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
utils.map('n', '<leader>?',
          [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
