vim.cmd ('syntax enable')
vim.cmd ('filetype plugin indent on')

-- Global variables
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.t_Co = 256
vim.o.updatetime = 100

-- general
vim.o.mouse = 'a'
vim.o.hidden = true
vim.o.number = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'

-- visual
vim.o.cursorline = true
vim.o.scrolloff = 2
vim.o.shiftround = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wildmode = 'list:longest'

-- tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.foldenable = false
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 2
vim.o.listchars = 'eol:$,tab:>-,space:.,trail:~,extends:>,precedes:<,nbsp:+'

-- search 
vim.o.smartcase = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.inccommand = 'nosplit'

-- language
vim.o.spelllang = 'ru,en_us'
vim.o.keymap = 'russian-jcukenwin'
vim.o.iminsert = 0
vim.o.imsearch = 0

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- UI
vim.o.termguicolors = true
vim.o.signcolumn = "auto:3"
vim.o.showmode = false
vim.o.guicursor ='n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

-- Common
local options = {noremap = true}
vim.api.nvim_set_keymap('n', '<F3>', '<cmd>set list!<CR>', options)
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', options)
vim.api.nvim_set_keymap('n', '<A-3>', '<cmd>SymbolsOutline<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>F', '<cmd>Format<CR>', options)

-- Window navigation
vim.api.nvim_set_keymap('n', '<A-h>', '<C-W>h', options)
vim.api.nvim_set_keymap('n', '<A-j>', '<C-W>j', options)
vim.api.nvim_set_keymap('n', '<A-k>', '<C-W>k', options)
vim.api.nvim_set_keymap('n', '<A-l>', '<C-W>l', options)

local silent_options = {noremap = true, silent=true}

-- Disable arrows
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', options)

-- Hop bindings
vim.api.nvim_set_keymap ('n', '//', [[<cmd>lua require('hop').hint_patterns()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>j', [[<cmd>lua require('hop').hint_words()<CR>]], options)
vim.api.nvim_set_keymap ('n', '<leader>l', [[<cmd>lua require('hop').hint_lines()<CR>]], options)
-- nvim-cmp configuration
local snippy = require("snippy")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require'snippy'.expand_snippet(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'snippy' }
  }, {
    { name = 'buffer' },
  })
})

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


-- vim.api.nvim_exec([[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost *.js,*.rs,*.go,*.py,*.tf,*.nix FormatWrite
-- augroup END
-- ]], true)

-- formatter configuration

require('lint').linters_by_ft = {
  yaml = {'yamllint',}
}

-- Enable linter
-- vim.cmd [[au BufWritePost *.yaml,*.yml lua require('lint').try_lint()]]

-- Navigator configurations
local disabled_lsp = {
  "angularls", "tsserver", "flow", "julials", "clojure_lsp",
  "jedi_language_server", "jdtls", "vimls","solargraph", "cssls",
  "clangd", "ccls", "sqls", "denols", "graphql", "dartls", "dotls",
  "kotlin_language_server", "nimls", "intelephense", "vuels", "phpactor", "omnisharp",
  "r_language_server", "terraformls", "texlab", "svelte"
}

-- symbol_outline configuration
vim.g.symbols_outline = {
    width = 50,
    show_numbers = true,
}

local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      }
    }
  }
}

local options = {noremap = true}
vim.api.nvim_set_keymap('n', '<F3>', '<cmd>set list!<CR>', options)
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').treesitter()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>fd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],options)
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],options)

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
    nix = {
      function()
        return {
          exe = "nixfmt",
          args = {},
          stdin = true,
        }
      end
    },
    terraform = {
      function()
        return {exe = "terraform", args = {"fmt", "-"}, stdin = true}
      end
    }
  }
})
-- github theme
require('github-theme').setup({
  theme_style = 'light',
  sidebars = {"terminal"},
  dark_sidebar = false
})
-- gitsigns configurations
require("gitsigns").setup()
-- hop configuration
require('hop').setup()
-- lsp_signature configurations
require "lsp_signature".setup()
-- lualine configuration
require('lualine').setup{options = {theme = 'auto'}}
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
-- neogit configuration
require("plenary")
local neogit = require('neogit')
neogit.setup {
  integrations = { diffview = true }
}
-- nvim-autopairs configuration
require('nvim-autopairs').setup{
  disable_filetype = { "TelescopePrompt" , "guihua", "guihua_rust", "clap_input" },
  vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }"),
  vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")
}
-- surround configuration
require("surround").setup({})
-- toggleterm configuration
require("toggleterm").setup {
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = false,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell -- change the default shell
}
