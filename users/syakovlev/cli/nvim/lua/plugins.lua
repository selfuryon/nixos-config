return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- UI
  use 'projekt0n/github-nvim-theme'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'akinsho/nvim-toggleterm.lua'
  use 'chentau/marks.nvim'

  -- Navigation
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
  use 'christoomey/vim-tmux-navigator'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'ray-x/lsp_signature.nvim'
  use 'simrat39/symbols-outline.nvim'
  use {'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}}

  -- Completion/Formation
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'mhartington/formatter.nvim'

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'

  -- Snippets
  use 'dcampos/nvim-snippy'

  -- Git
 	use { 'TimUntersberger/neogit', requires = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim'
  }}
  use { 'lewis6991/gitsigns.nvim', requires = {
    'nvim-lua/plenary.nvim'
  }}

  -- Motions
  use 'windwp/nvim-autopairs'
  use 'chaoren/vim-wordmotion'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-commentary'
  use 'phaazon/hop.nvim'
  use 'ur4ltz/surround.nvim'

end)
