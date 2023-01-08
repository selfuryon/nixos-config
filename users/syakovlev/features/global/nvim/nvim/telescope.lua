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
vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').find_files()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>/', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>j', [[<cmd>lua require('telescope.builtin').jumplist()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>S', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>d', [[<cmd>lua require('telescope.builtin').diagnosticj()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').treesitter()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').commands()<CR>]],options)

-- vim.api.nvim_set_keymap('n', 'gi', [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]],options)
-- vim.api.nvim_set_keymap('n', 'gr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],options)
-- vim.api.nvim_set_keymap('n', 'gd', [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]],options)
-- vim.api.nvim_set_keymap('n', 'gy', [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]],options)
