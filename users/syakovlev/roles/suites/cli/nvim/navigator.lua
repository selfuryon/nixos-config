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
