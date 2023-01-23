-- lspsaga config
require('lspsaga').setup({
  scroll_preview = {
    scroll_down = '<C-j>',
    scroll_up = '<C-k>',
  },
  lightbulb = {
    enable = false,
  },
  ui = {
    theme = 'round',
    title = true,
    -- border type can be single,double,rounded,solid,shadow.
    border = 'rounded',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = ' ',
    code_action = '💡',
    diagnostic = '🐞',
    incoming = ' ',
    outgoing = ' ',
    colors = {
      --float window normal background color
      normal_bg = '#ffffff',
      --title background color
      title_bg = '#afd700',
    },
    kind = {},
  }
})
local keymap = vim.keymap.set

keymap("n", "<leader>r", "<cmd>Lspsaga rename<CR>", { silent = true })
keymap({"n","v"}, "<leader>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>",{ silent = true })
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
--
-- Callhierarchy
keymap("n", "gci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "gco", "<cmd>Lspsaga outgoing_calls<CR>")

-- Show cursor diagnostic
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnostic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filter like Only jump to error
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

keymap({"n", "t"}, "<A-t>", "<cmd>Lspsaga term_toggle<CR>")

