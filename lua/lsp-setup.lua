local lsp_servers = { 'clangd', 'cmake', 'lua_ls', 'rust_analyzer' }

local G = {}
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    if client.server_capabilities.documentSymbolProvider then
        require 'nvim-navic'.attach(client, bufnr)
    end

    local keymaps = require("keymaps")
    -- Mappings.
    keymaps.setup_buf_lsp_keymaps(bufnr, client.server_capabilities)

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#666666
      hi LspReferenceText cterm=bold ctermbg=red guibg=#666666
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#666666
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
    end
end

local mason_setup = false
local function setup_mason()
    if (not mason_setup) then
        require 'mason'.setup()
        mason_setup = true
    end
end

-- Setup lspconfig.

function G.setup_lsp()
    setup_mason()
    require 'mason-lspconfig'.setup({
        automatic_enable = false,
        ensure_installed = lsp_servers, -- ensure these servers are always installed
        automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    })
    local capabilities = require("completion").cmp_capabilities
    capabilities.offsetEncoding = { "utf-16" }
    for _, server in ipairs(require 'mason-lspconfig'.get_installed_servers()) do
        nvim_lsp[server].setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
    end
end

-- Setup lspconfig.

function G.setup_dap()
    setup_mason()
    require 'mason-nvim-dap'.setup({
        ensure_installed = { 'codelldb' }, -- ensure these servers are always installed
        handlers = {},
    })

    local dap = require 'dap'

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
        },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
    dap.configurations.objc = dap.configurations.cpp
    dap.configurations.objcpp = dap.configurations.cpp

    require("dapui").setup()
    local dapui = require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

return G
