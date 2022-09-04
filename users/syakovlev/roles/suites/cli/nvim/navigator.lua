-- Navigator configurations
local disabled_lsp = {
  "angularls", "tsserver", "flow", "julials", "clojure_lsp",
  "jedi_language_server", "jdtls", "vimls","solargraph", "cssls",
  "clangd", "ccls", "sqls", "denols", "graphql", "dartls", "dotls",
  "kotlin_language_server", "nimls", "intelephense", "vuels", "phpactor", "omnisharp",
  "r_language_server", "terraformls", "texlab", "svelte"
}

require('navigator').setup({
  keymaps = {{key = "gd", func = "require('navigator.definition').definition()"}},
  lsp = {
    disable_lsp = disabled_lsp,
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {command = "clippy"},
        }
      }
    }
  }
})
