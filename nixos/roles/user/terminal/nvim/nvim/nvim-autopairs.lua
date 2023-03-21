-- nvim-autopairs configuration
require('nvim-autopairs').setup{
  disable_filetype = { "TelescopePrompt" , "guihua", "guihua_rust", "clap_input" },
  vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }"),
  vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")
}
