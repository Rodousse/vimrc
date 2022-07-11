local G = {}

function G.load_plugins()
  vim.cmd("call plug#begin(stdpath('data') . '/plugged')")
  vim.cmd("Plug 'dracula/vim'") -- Color scheme
  vim.cmd("Plug 'kristijanhusak/vim-hybrid-material'") -- Color scheme
  vim.cmd("Plug 'Shatur/neovim-ayu'") -- Color scheme
  vim.cmd("Plug 'marko-cerovac/material.nvim'") -- Color scheme
  vim.cmd("Plug 'Mofiqul/vscode.nvim'") -- Color scheme
  vim.cmd("Plug 'peterhoeg/vim-qml'") -- QML Syntaxe highlighting
  vim.cmd("Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }") -- Fuzzy finder
  vim.cmd("Plug 'junegunn/fzf.vim'") -- Fuzzy finder additional commands
  vim.cmd("Plug 'nvim-lua/plenary.nvim'")
  vim.cmd("Plug 'nvim-telescope/telescope.nvim'")
  vim.cmd("Plug 'nvim-telescope/telescope-ui-select.nvim'")
  vim.cmd("Plug 'rhysd/vim-clang-format'") -- Clang format
  vim.cmd("Plug 'nvim-lualine/lualine.nvim'")
  vim.cmd("Plug 'powerline/powerline'") -- Powerline support with special symbols for terminal
  vim.cmd("Plug 'scrooloose/nerdtree'") -- Project file structure and navigation
  vim.cmd("Plug 'williamboman/nvim-lsp-installer'") -- Install automagically lsp servers
  vim.cmd("Plug 'neovim/nvim-lspconfig'") -- lsp server configuration 
  vim.cmd("Plug 'mfussenegger/nvim-lint'")
  vim.cmd("Plug 'hrsh7th/cmp-nvim-lsp'")
  vim.cmd("Plug 'hrsh7th/cmp-buffer'")
  vim.cmd("Plug 'hrsh7th/cmp-path'")
  vim.cmd("Plug 'hrsh7th/cmp-cmdline'")
  vim.cmd("Plug 'hrsh7th/cmp-vsnip'")
  vim.cmd("Plug 'hrsh7th/nvim-cmp'")
  vim.cmd("Plug 'hrsh7th/vim-vsnip'") -- snippet engine to use with nvim-cmp
  vim.cmd("Plug 'rcarriga/nvim-notify'") -- Stylised notification system
  vim.cmd("Plug 'vhdirk/vim-cmake'") -- cmake features facilities
  -- On-demand lazy load
  vim.cmd("Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }")
  vim.cmd("Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}")
  vim.cmd("Plug 'vim-scripts/DoxygenToolkit.vim'") -- Doxygen comments
  vim.cmd("Plug 'tpope/vim-fugitive'")
  vim.cmd("call plug#end()")
end

return G
