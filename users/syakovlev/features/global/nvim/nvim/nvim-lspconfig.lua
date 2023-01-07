-- lspconfig
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.nil_ls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.hls.setup{}
local nvim_lsp = require('lspconfig')

local servers = { "rust_analyzer", "gopls", "nil_ls", "yamlls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
	on_attach = on_attach,
	flags = {
	  debounce_text_changes = 150,
	}
}
end
