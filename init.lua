  for k, v in pairs(package.loaded) do
    if string.match(k, "*+") then
      package.loaded[k] = nil
    end
  end

--------------------------- Plugins ----------------------
plugins = require("plugins-installer")
plugins.load_plugins()

---------------------------- Variables and options ----------------------

flags = require("flags")
flags.set_global_variables()
flags.set_options()
flags.set_events()
flags.create_autocommands()

---------------------------- Style ----------------------

flags.set_color_theme()
require("line").setup()

----------------------------- Notification/Keymaps -----------------------
-- Change default notification engine
vim.notify = require("notify")

keymaps = require("keymaps")
keymaps.setup_keymaps()


----------------------------- LSP and IDE features -----------------------
require("treesitter").setup_treesitter()
require("completion").setup_completion()
lsp = require("lsp-setup")
-- See ":h nvim-lsp-installer" for required dependencies
lsp.setup_lsp()

-- take care to install linters before hand
require("linter").setup_linter()

----------------------------- Telescope setup -----------------------
require("telescope-setup").setup_telescope()
