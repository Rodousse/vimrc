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

  use 'Mofiqul/vscode.nvim' -- Color scheme
  use 'peterhoeg/vim-qml' -- QML Syntaxe highlighting
  use 'nvim-lua/plenary.nvim'

  --use {
  --  'mfussenegger/nvim-dap',
  --  --require = {{'Pocco81/dap-buddy'}},
  --  config = [[]]
  --}

  use {
    'lewis6991/gitsigns.nvim',
    config = [[ require'gitsigns'.setup() ]],
  }

  use({
    "kdheepak/lazygit.nvim",
    config = [[vim.g.lazygit_floating_window_use_plenary = 1]]
  })

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
      config = [[
        require'nvim-web-devicons'.setup {}
      ]]
    },
    config = [[ require("line").setup() ]],
  }

  use {
      "neovim/nvim-lspconfig",
      requires = {{"williamboman/nvim-lsp-installer"}},
      config = [[ require'lsp-setup'.setup_lsp() ]],
  }

  use {
    'mfussenegger/nvim-lint',
    config = [[ require("linter").setup_linter()  ]],
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

