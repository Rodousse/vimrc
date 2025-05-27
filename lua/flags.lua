local G = {}

function G.set_global_variables()
  vim.g.mapleader = " "

  -- rhysd/vim-clang-format settings
  vim.g['clang_format#detect_style_file'] = 1          -- Use .clangformat at the root of the project
  if vim.fn.has("win32") == 1 then
    vim.g["clang_format#command"] = "clang-format.exe" -- Fix embedded clang format set by msvc command prompt
  else
    vim.g["clang_format#command"] = "clang-format"
  end
  -- Termdebug
  vim.g.termdebug_wide = 1
end

function G.set_options()
  vim.opt.encoding = "utf-8"
  vim.opt.timeoutlen = 500
  vim.opt.updatetime = 500
  vim.opt.scrolloff = 13
  vim.opt.cursorline = true
  vim.opt.fillchars = {eob = " "}

  if vim.fn.has("win32") == 1 then
      vim.opt.shell='pwsh.exe'
      vim.opt.shellcmdflag='-command'
      vim.opt.shellquote=''
      vim.opt.shellxquote=''
  end

  -- Only hide buffer when switching between them
  vim.opt.hidden = true

  vim.opt.clipboard = "unnamedplus"
  vim.fn.matchadd('errorMsg', [[\s\+$]])

  -- Blank caracters visibility
  vim.opt.list = true
  vim.opt.listchars = {
    --space = "·",
    space = " ",
    tab = "→  ",
    trail = "█"
  }

  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = true
  -- Display line number relatively except the current line in absolute
  vim.opt.relativenumber = true
  vim.opt.number = true
  vim.opt.completeopt = "menuone,noselect,popup" -- Set completeopt to have a better completion experience
  vim.opt.shortmess:append("c")
end

function G.set_events()
  -- Turn on syntax highligting
  vim.cmd("syntax on")
end

function G.set_color_theme()
end

function G.create_autocommands()
  vim.api.nvim_create_autocmd({ "VimEnter" }, { pattern = "*", callback = function() vim.cmd("ClangFormatAutoEnable") end })
end

return G
