-- lspconfig
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.rnix.setup{}
local nvim_lsp = require('lspconfig')

local servers = { "rust_analyzer", "gopls", "rnix"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
	on_attach = on_attach,
	flags = {
	  debounce_text_changes = 150,
	}
}
end
