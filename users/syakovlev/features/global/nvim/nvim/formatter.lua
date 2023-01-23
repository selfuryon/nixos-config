-- formatter configuration
require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
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
      function() return {exe = "black", args = {"--safe"}, stdin = false} end
    },
    yaml = {
      function() return {exe = "yamlfix", args = {"-"}, stdin = true} end
    },
    rust = {
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout", "--edition=2018"},
          stdin = true
        }
      end
    },
    go = {
      function()
        return {
          exe = "gofmt",
          args = {},
          stdin = true,
          cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
        }
      end
    },
    -- nix = {
    --   function()
    --     return {
    --       exe = "nixfmt",
    --       args = {},
    --       stdin = true,
    --     }
    --   end
    -- },
    terraform = {
      function()
        return {exe = "terraform", args = {"fmt", "-"}, stdin = true}
      end
    }
  }
})
