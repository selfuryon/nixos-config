-- formatter configuration

require('lint').linters_by_ft = {
  yaml = {'yamllint',}
}

-- Enable linter
-- vim.cmd [[au BufWritePost *.yaml,*.yml lua require('lint').try_lint()]]
