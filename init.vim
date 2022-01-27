

" Turn on syntax highligting
syntax on

set encoding=utf-8
set timeoutlen=300
set updatetime=300

" Only hide buffer when switching between them
set hidden

" Blank caracters visibility
set list
set listchars=space:·,tab:→\ \ 

set tabstop=2 shiftwidth=2 expandtab
" Display line number relatively except the current line in absolute
set relativenumber number

let g:mapleader = "\<Space>"

" -------------------------- Plugins ----------------------

call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'dracula/vim' " Color scheme
Plug 'ajmwagar/vim-deus' " Color scheme
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'peterhoeg/vim-qml' " QML Syntaxe highlighting
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder
Plug 'junegunn/fzf.vim' " Fuzzy finder additional commands
Plug 'rhysd/vim-clang-format' " Clang format
Plug 'vim-airline/vim-airline' " Tab and status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/powerline' " Powerline support with special symbols for terminal
Plug 'scrooloose/nerdtree' " Project file structure and navigation
Plug 'neovim/nvim-lspconfig' " lsp seerver configuration 
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'vhdirk/vim-cmake' " cmake features facilities
"Plug 'jiangmiao/auto-pairs' " Automatically set corresponding character '(' to ')' or '{' to '}'
Plug 'tikhomirov/vim-glsl' " glsl syntaxe highlighting
Plug 'liuchengxu/vim-which-key' " Shortcut
" On-demand lazy load
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-scripts/DoxygenToolkit.vim' " Doxygen comments
Plug 'tpope/vim-fugitive'
call plug#end()

" -------------------------- Plugin related ----------------------
" junegunn/fzf settings
" Look for a file in the current folder hierarchy
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
tnoremap <C-[> <C-\><C-n>

" ajmwagar/vim-deus settings
set t_Co=256
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

colorscheme hybrid_reverse
set background=dark 
" Remove the background color of the theme to match the terminal
highlight Normal guibg=none guifg=none 
let g:deus_termcolors=256

" rhysd/vim-clang-format settings
let g:clang_format#detect_style_file=1 " Use .clangformat at the root of the project
autocmd VimEnter * ClangFormatAutoEnable " Enable clangformat on launch
if has('win32')
  let g:clang_format#command='D:\Soft\LLVM\bin\clang-format.exe' " Fix embedded clang format set by msvc command prompt 
else
  let g:clang_format#command='clang-format-8'
endif

set completeopt=menuone,noinsert,noselect  " Set completeopt to have a better completion experience
set shortmess+=c
lua << EOF
  
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', '<space>d', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<space>p', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>P', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>rf', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<space>R', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<space>F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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
  

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm{ behavior = cmp.ConfirmBehavior.Replace, select = true },
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.



  nvim_lsp['clangd'].setup{
    on_attach=on_attach, 
    capabilities = capabilities,
  }
  nvim_lsp['cmake'].setup{
    on_attach=on_attach,
  }
  nvim_lsp['pylsp'].setup{
    on_attach=on_attach,
  }

--  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--  }
EOF
nnoremap <silent> <leader>h :ClangdSwitchSourceHeader<CR>

"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    },
  } 
EOF
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" vhdirk/vim-cmake
let g:cmake_project_generator = "Ninja"
let g:cmake_export_compile_commands = 1 " same as -DCMAKE_EXPORT_COMPILE_COMMANDS
let g:cmake_ycm_symlinks = 1 " create symlinks to the generated compilation database for use with clangd in neovim/nvim-lspconfig

" scrooloose/nerdtree
"autocmd VimEnter * NERDTree | wincmd p " Enable nerdtree on launch

" vim-airline/vim-airline
autocmd VimEnter * AirlineTheme hybrid
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "hybrid"

" liuchengxu/vim-which-key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"Still need fixes
"call which_key#register('<Space>', "g:which_key_map")
"
"nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
"vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
"let g:which_key_map =  {}
"let g:which_key_map = {
" \ 'name' : '+lsp',
" \ 'f' : 'formatting' ,
" \ 'd' : 'go to' ,
" \ 'D' : 'definition' ,
" \ 'k' : 'hover',
" \ 'K' : 'signature_help', 
" \ 'r' : {
"   \ 'n': 'rename'
" \ },
" \ 'e' : 'show_line_diagnostics'
"\ }

" tikhomirov/vim-glsl
autocmd! BufNewFile,BufRead *.vs,*.fs,*.gs,*.tese,*.tesc set ft=glsl


" 'vim-scripts/DoxygenToolkit.vim'
nnoremap <silent> <leader>cd :Dox<CR>

" Termdebug
let g:termdebug_wide=1

