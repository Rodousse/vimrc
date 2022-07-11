vim.cmd [[packadd packer.nvim]]
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'Mofiqul/vscode.nvim' -- Color scheme
  use 'peterhoeg/vim-qml' -- QML Syntaxe highlighting
  use 'nvim-lua/plenary.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function() require("telescope-setup").setup_telescope() end,
  }

  use 'rhysd/vim-clang-format' -- Clang format
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 
      'kyazdani42/nvim-web-devicons',
      opt = true,
      config = function() 
        require'nvim-web-devicons'.setup {}
      end
    },
    config = function() require("line").setup() end,
  }

  use {
      "williamboman/nvim-lsp-installer",
      "neovim/nvim-lspconfig",
      config = function() require'lsp-setup'.setup_lsp()end,
  }

  use {
    'mfussenegger/nvim-lint',
    config = function() require("linter").setup_linter() end,
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/nvim-cmp',
    'hrsh7th/vim-vsnip',-- snippet engine to use with nvim-cmp
    config = function() require("completion").setup_completion() end,
  }

  use {
    -- Stylised notification system
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
    end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require("treesitter").setup_treesitter() end,
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use 'vim-scripts/DoxygenToolkit.vim' -- Doxygen comments

  use 'tpope/vim-fugitive'

end)
