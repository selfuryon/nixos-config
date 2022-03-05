-- formatter configuration
require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    },
    python = {
      -- prettier
      function() return {exe = "black", args = {"--safe"}, stdin = false} end
    },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout", "--edition=2018"},
          stdin = true
        }
      end
    },
    go = {
      -- gofmt
      function()
        return {
          exe = "gofmt",
          args = {},
          stdin = true,
          cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
        }
      end
    },
    nix = {
      -- gofmt
      function()
        return {
          exe = "nixfmt",
          args = {},
          stdin = true,
        }
      end
    },
    terraform = {
      -- terraform
      function()
        return {exe = "terraform", args = {"fmt", "-"}, stdin = true}
      end
    }
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.rs,*.go,*.py,*.tf,*.nix FormatWrite
augroup END
]], true)
