vim.cmd [[packadd packer.nvim]]
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  --use 
  use {
    'Mofiqul/vscode.nvim',
    --'nyoom-engineering/oxocarbon.nvim',
    config = [[
      -- For dark theme (neovim's default)
      vim.o.background = "dark"
      -- For light theme
      -- vim.o.background = "light"
      -- Enable transparent background
      -- vim.g.vscode_transparent = 1
      -- Enable italic comment
      -- vim.g.vscode_italic_comment = 1
      -- Disable nvim-tree background color
      -- vim.g.vscode_disable_nvimtree_bg = true
       vim.cmd("colorscheme vscode")
      --vim.cmd("colorscheme oxocarbon")
      -- Remove the background color of the theme to match the terminal
      -- Does throw a warning on startup since none is not an acceptable value
      -- vim.cmd("highlight Normal guibg=none guifg=none ")
      -- vim.opt.termguicolors = true
    ]]
  }

  use {
    'ggandor/leap.nvim',
    requires = {
      'tpope/vim-repeat',
    },
    config = [[require('leap').add_default_mappings()]]
  }

  use {
    "rcarriga/nvim-dap-ui",
    requires = {
      {"mfussenegger/nvim-dap"},
      {"williamboman/mason.nvim"},
      {"jay-babu/mason-nvim-dap.nvim"}
    },
    config = [[ require'lsp-setup'.setup_dap() ]],
  }

  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = [[ require'gitsigns'.setup() ]],
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-ui-select.nvim'} },
    config = [[ require("telescope-setup").setup_telescope() ]],
  }

  use 'rhysd/vim-clang-format' -- Clang format
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
      config = [[ require'nvim-web-devicons'.setup {} ]]
    },
    config = [[ require("line").setup() ]],
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    requires = {
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'hrsh7th/cmp-vsnip'},
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/vim-vsnip'},-- snippet engine to use with nvim-cmp
    },
    config = [[ require("completion").setup_completion()  ]],
  }

  use {
      "neovim/nvim-lspconfig",
      requires = { {'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'} },
      config = [[ require'lsp-setup'.setup_lsp() ]],
  }

  use {
    'mfussenegger/nvim-lint',
    config = [[ require("linter").setup_linter()  ]],
  }

  use {
    -- Stylised notification system
    'rcarriga/nvim-notify',
    config = [[
      vim.notify = require("notify")
    ]]
  }

  use {
    "folke/which-key.nvim",
    config = [[
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    ]]
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = [[ require("treesitter").setup_treesitter()  ]],
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use 'vim-scripts/DoxygenToolkit.vim' -- Doxygen comments

  use 'tpope/vim-fugitive'

end)

