for k, v in pairs(package.loaded) do
  if string.match(k, "*+") then
    package.loaded[k] = nil
  end
end

require "plugins"

local flags = require("flags")
flags.set_global_variables()
flags.set_options()
flags.set_events()
flags.create_autocommands()
flags.set_color_theme()

local keymaps = require("keymaps")
keymaps.setup_keymaps()


