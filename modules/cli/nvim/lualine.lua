-- lualine configuration
require('lualine').setup{
  options = {theme = 'auto'},
	sections = { lualine_c = { 'filename', 'lsp_progress' }}
}
