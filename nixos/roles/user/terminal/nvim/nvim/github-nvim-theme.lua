-- github theme
require('github-theme').setup({
  options = {
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
