
local lualine = require('lualine')
local G = {}

function G.setup()
  lualine.setup({
    options = { theme = 'auto' },
    sections = {
      lualine_b = {'branch', 'diff'},
      lualine_x = {
          'encoding', 
          {
            'diagnostics',

            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { 'nvim_diagnostic' },

            -- Displays diagnostics for the defined severity types
            sections = { 'error', 'warn', 'info', 'hint' },

            diagnostics_color = {
              -- Same values as the general color option can be used here.
              error = 'DiagnosticError', -- Changes diagnostics' error color.
              warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
              info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
              hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
            },
            symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
            colored = true,           -- Displays diagnostics status in color if set to true.
            always_visible = false   -- Show diagnostics even if there are none.
          },
          'filetype'
        
      }
    }
  })
end

return G
