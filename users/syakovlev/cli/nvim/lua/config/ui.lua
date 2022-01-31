-- toggleterm configuration
require("toggleterm").setup {
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = false,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell -- change the default shell
}

-- lualine configuration
require('lualine').setup {options = {theme = 'github'}}

-- github theme
vim.o.background = "light"
require('github-theme').setup({
  theme_style = 'light',
  keyword_style = false,
  hide_inactive_statusline = false,
  sidebars = {"terminal"},
  dark_sidebar = false
})

-- marks.nvim configuration
require('marks').setup {
  default_mappings = true,
  builtin_marks = {".", "<", ">", "^"},
  cyclic = true,
  force_write_shada = false,
  refresh_interval = 250,
  sign_priority = {lower = 10, upper = 15, builtin = 8, bookmark = 20},
  bookmark_0 = {sign = "⚑", virt_text = "hello world"},
  mappings = {}
}
