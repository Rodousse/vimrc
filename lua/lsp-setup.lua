local lsp_servers = {'clangd', 'cmake', 'sumneko_lua'}

local G = {}
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local keymaps = require("keymaps")
  -- Mappings.
  keymaps.setup_buf_lsp_keymaps(bufnr)
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    keymaps.setup_buf_lsp_format_keymaps(bufnr)
  elseif client.resolved_capabilities.document_range_formatting then
    keymaps.setup_buf_lsp_format_range_keymaps(bufnr)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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

local function install_lsp_servers()
  require("nvim-lsp-installer").setup({
    ensure_installed = lsp_servers, -- ensure these servers are always installed
    automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    install_root_dir = vim.fn.stdpath "data".."/lsp_servers", 
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    },
    log_level = vim.log.levels.DEBUG
})
end

-- Setup lspconfig.

function G.setup_lsp()
  install_lsp_servers()
  nvim_lsp['clangd'].setup{
    on_attach=on_attach, 
    capabilities = require("completion").cmp_capabilities
  }
  nvim_lsp['cmake'].setup{
    on_attach=on_attach, 
    capabilities = require("completion").cmp_capabilities
  }
  nvim_lsp['pylsp'].setup{
    on_attach=on_attach, 
    capabilities = require("completion").cmp_capabilities
  }
  nvim_lsp['sumneko_lua'].setup{
    on_attach=on_attach, 
    capabilities = require("completion").cmp_capabilities
  }
end

return G
