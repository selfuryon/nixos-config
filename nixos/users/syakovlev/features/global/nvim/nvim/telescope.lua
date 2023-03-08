-- telescope
local actions = require('telescope.actions')
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

local options = {noremap = true}
local km = vim.keymap
km.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]],options)
km.set('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').find_files()<CR>]],options)
km.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]],options)
km.set('n', '<leader>/', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],options)
km.set('n', '<leader>j', [[<cmd>lua require('telescope.builtin').jumplist()<CR>]],options)
km.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],options)
km.set('n', '<leader>S', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]],options)
km.set('n', '<leader>d', [[<cmd>lua require('telescope.builtin').diagnosticj()<CR>]],options)
km.set('n', '<leader>t', [[<cmd>lua require('telescope.builtin').treesitter()<CR>]],options)
km.set('n', '<leader>?', [[<cmd>lua require('telescope.builtin').commands()<CR>]],options)

-- km.set('n', 'gi', [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]],options)
-- km.set('n', 'gr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],options)
-- km.set('n', 'gd', [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]],options)
-- km.set('n', 'gy', [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]],options)
