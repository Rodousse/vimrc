local G = {}

function G.setup()
    local lualine = require('lualine')
    local navic = require('nvim-navic')
    lualine.setup({
        options = {
            theme = 'auto',
            globalstatus = true,
            always_show_tabline = true
        },
        tabline =
        {
            lualine_a = {
                "mode"
            },
            lualine_b = {
                'filename',
            },
            lualine_c = {
                { "navic" }
            },
            lualine_x = {
                {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                    color = { fg = "#ff9e64" },
                },
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
                    colored = true,                -- Displays diagnostics status in color if set to true.
                    always_visible = false         -- Show diagnostics even if there are none.
                },
            },
            lualine_y = { 'lsp_status' },
            lualine_z =
            {
                {
                    function()
                        return require('auto-session.lib').current_session_name(true)
                    end
                },
                { 'branch' }
            },
        },
        sections = {}
    });
end

return G
