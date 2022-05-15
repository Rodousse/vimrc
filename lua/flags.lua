local G = {}

function G.set_global_variables()
  vim.g.mapleader = " "

  -- rhysd/vim-clang-format settings
  vim.g['clang_format#detect_style_file'] = 1 -- Use .clangformat at the root of the project
  if vim.fn.has("win32") == 1 then
    vim.g["clang_format#command"] = "D:\\Soft\\LLVM\\bin\\clang-format.exe" -- Fix embedded clang format set by msvc command prompt
  else
    vim.g["clang_format#command"] = "clang-format"
  end
  -- vhdirk/vim-cmake
  vim.g.cmake_project_generator = 'Ninja'
  vim.g.cmake_export_compile_commands = 1 -- same as -DCMAKE_EXPORT_COMPILE_COMMANDS'
  vim.g.cmake_ycm_symlinks = 1 -- create symlinks to the generated compilation database for use with clangd in neovim/nvim-lspconfig'

  -- Termdebug
  vim.g.termdebug_wide = 1
end

function G.set_options()
  vim.opt.encoding = "utf-8"
  vim.opt.timeoutlen = 500
  vim.opt.updatetime = 500
  vim.opt.scrolloff = 13

  -- Only hide buffer when switching between them
  vim.opt.hidden = true

  -- Blank caracters visibility
  vim.opt.list = true
  vim.opt.listchars = {
    space = "·", 
    tab = "→  "
  }

  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  -- Display line number relatively except the current line in absolute
  vim.opt.relativenumber = true 
  vim.opt.number = true 
  vim.opt.completeopt = "menuone,noinsert,noselect,preview,noselect"  -- Set completeopt to have a better completion experience
  vim.opt.shortmess:append("c")
end


function G.set_events()
  -- Turn on syntax highligting
  vim.cmd("syntax on")
end

function G.set_color_theme()
  require('material').setup({
    italics = {comments = true, functions = true}
  })
  vim.cmd 'colorscheme material'
  vim.g.material_style = "palenight"
  -- Remove the background color of the theme to match the terminal
  -- Does throw a warning on startup since none is not an acceptable value
  -- vim.cmd("highlight Normal guibg=none guifg=none ")
  vim.opt.termguicolors = true
  vim.opt.background = "dark"
  require'shade'.setup({
    overlay_opacity = 50,
    opacity_step = 1
  })
end

function G.create_autocommands()
  vim.api.nvim_create_autocmd({"VimEnter"}, {pattern = "*", callback = function() vim.cmd("ClangFormatAutoEnable") end})
end

return G
