

" Turn on syntax highligting
syntax on

set encoding=utf-8

" Display line number relatively except the current line in absolute
set relativenumber number

" ---------------------Plugin related commands ------------

" :CocInstall coc-cmake
" :CocInstall coc-clangd and use the CMAKE_EXPORT_COMPILE_COMMANDS file compile_command.json, copy to the source root directory

" -------------------------- Plugins ----------------------

call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'dracula/vim' " Color scheme
Plug 'ajmwagar/vim-deus' " Color scheme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder
Plug 'junegunn/fzf.vim' " Fuzzy finder additional commands
Plug 'rhysd/vim-clang-format' " Clang format
Plug 'vim-airline/vim-airline' " Tab and status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree' " Project file structure and navigation
Plug 'neovim/nvim-lspconfig' " lsp seerver configuration 
Plug 'nvim-lua/completion-nvim' " lsp completion engine
Plug 'vhdirk/vim-cmake' " cmake features facilities
Plug 'jiangmiao/auto-pairs' " Automatically set corresponding character "(" to ")" or "{" to "}"
call plug#end()

" -------------------------- Plugin related ----------------------
" junegunn/fzf settings
" Look for a file in the current folder hierarchy
nnoremap <silent> <C-K> :Files<CR>

" ajmwagar/vim-deus settings
set t_Co=256
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark 
colorscheme deus
let g:deus_termcolors=256

" rhysd/vim-clang-format settings
let g:clang_format#detect_style_file=1 " Use .clangformat at the root of the project
autocmd VimEnter * ClangFormatAutoEnable " Enable clangformat on launch

" nvim-lua/completion-nvim neovim/nvim-lspconfig
lua << EOF
local lspconfig=require'lspconfig'
lspconfig.clangd.setup({
	on_attach=require'completion'.on_attach, 
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	semanticHighlighting = true
})
lspconfig.cmake.setup{on_attach=require'completion'.on_attach}
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" vhdirk/vim-cmake
let g:cmake_project_generator = "Ninja"
let g:cmake_export_compile_commands = 1 " same as -DCMAKE_EXPORT_COMPILE_COMMANDS
let g:cmake_ycm_symlinks = 1 " create symlinks to the generated compilation database for use with clangd in neovim/nvim-lspconfig

" scrooloose/nerdtree
autocmd VimEnter * NERDTree | wincmd p " Enable nerdtree on launch

autocmd VimEnter * AirlineTheme deus
let g:airline#extensions#tabline#enabled = 1
