
local G = {}

function G.setup_telescope()
  require('telescope').setup({
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = require("keymaps").telescope_keymaps,
    },
    pickers = {
      find_file = {
        theme = "dropdown"
      },
      lsp_references = {
        theme = "ivy"
      },
      lsp_definitions = {
        theme = "cursor"
      }
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        }
      }
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  })
  require("telescope").load_extension("ui-select")
  require("telescope").load_extension("noice")
end

return G
