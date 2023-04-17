-- github theme
require('github-theme').setup({
  options = {
    styles = {
      comments = 'Italic',
      functions = 'NONE',
      keywords = 'Bold',
      variables = 'Underline',
    },
    darken = {
      floats = true,
      sidebars = {
        enable = true,
        list = { 'qf', 'vista_kind', 'terminal', 'packer' },
      },
    },
  },
})

vim.cmd ('colorscheme github_light')
