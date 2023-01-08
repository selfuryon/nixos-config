-- lspsaga config
local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.init_lsp_saga()

keymap("n", "<leader>r", "<cmd>Lspsaga rename<CR>", { silent = true })
keymap({"n","v"}, "<leader>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>",{ silent = true })
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "<A-t>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
keymap("t", "<A-t>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

