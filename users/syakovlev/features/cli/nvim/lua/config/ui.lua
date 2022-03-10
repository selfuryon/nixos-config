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

-- github theme
require('github-theme').setup({
  theme_style = 'light',
  sidebars = {"terminal"},
  dark_sidebar = false
})

-- lualine configuration
require('lualine').setup{options = {theme = 'auto'}}
