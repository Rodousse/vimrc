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
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
        vim.cmd("autocmd! TermOpen term://* lua require'keymaps'.setup_toggle_terminal_keymaps()")
    end }

    use {
        'Mofiqul/vscode.nvim',
        --     config = [[
        --    vim.o.background = "dark"
        --    vim.cmd("colorscheme vscode")
        -- ]]
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
            { "mfussenegger/nvim-dap" },
            { "williamboman/mason.nvim" },
            { "jay-babu/mason-nvim-dap.nvim" },
            { "nvim-neotest/nvim-nio" }
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
        requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-ui-select.nvim' } },
        config = [[ require("telescope-setup").setup_telescope() ]],
    }

    use 'rhysd/vim-clang-format' -- Clang format
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'nvim-tree/nvim-web-devicons',
            'SmiteshP/nvim-navic',
        },
        config = [[ require("line").setup() ]],
    }

    use {
        'hrsh7th/cmp-nvim-lsp',
        requires = {
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/vim-vsnip' }, -- snippet engine to use with nvim-cmp
        },
        config = [[ require("completion").setup_completion()  ]],
    }

    use {
        "neovim/nvim-lspconfig",
        requires = { { 'williamboman/mason.nvim' }, { 'williamboman/mason-lspconfig.nvim' } },
        config = [[ require'lsp-setup'.setup_lsp() ]],
    }

    use {
        'mfussenegger/nvim-lint',
        config = [[ require("linter").setup_linter() ]],
    }

    use {
        -- Stylised notification system
        'rcarriga/nvim-notify',
        config = [[
      vim.notify = require("notify")
      require("notify").setup()
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

    use 'tpope/vim-fugitive'

    use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons',
        config = [[
            vim.opt.termguicolors = true
            require("bufferline").setup {}
            ]] }

    use { "savq/melange-nvim",
        --config = function ()
        --    vim.cmd.colorscheme "melange"
        --end
    }

    use { "catppuccin/nvim", as = "catppuccin",
        --config = function()
        --    vim.cmd.colorscheme "catppuccin-frappe"
        --end
    }

    use { "projekt0n/github-nvim-theme",
        config = function()
            vim.cmd.colorscheme "github_dark"
        end
    }

    use {
        'folke/noice.nvim',
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end
    }
end)
