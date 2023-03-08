-- github theme
require('github-theme').setup({
  theme_style = 'light',
  sidebars = {"terminal"},
  dark_sidebar = false
})

vim.cmd ('colorscheme github_light')
