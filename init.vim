

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

" Display line number relatively except the current line in absolute
set relativenumber number

let g:mapleader = "\<Space>"

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
Plug 'jiangmiao/auto-pairs' " Automatically set corresponding character '(' to ')' or '{' to '}'
Plug 'tikhomirov/vim-glsl' " glsl syntaxe highlighting
Plug 'liuchengxu/vim-which-key' " Shortcut
" On-demand lazy load
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" -------------------------- Plugin related ----------------------
" junegunn/fzf settings
" Look for a file in the current folder hierarchy
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" ajmwagar/vim-deus settings
set t_Co=256
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark 
colorscheme dracula
let g:deus_termcolors=256

" rhysd/vim-clang-format settings
let g:clang_format#detect_style_file=1 " Use .clangformat at the root of the project
autocmd VimEnter * ClangFormatAutoEnable " Enable clangformat on launch
if has('win32')
	let g:clang_format#command='D:\Soft\LLVM\bin\clang-format.exe' " Fix embedded clang format set by msvc command prompt 
endif

" nvim-lua/completion-nvim neovim/nvim-lspconfig
let g:completion_matching_ignore_case = 1
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1
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
		buf_set_keymap('n', '<space>p', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
		buf_set_keymap('n', '<space>P', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
		buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
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
	
	local on_attach_clangd = function(client, bufnr)
		require('completion').on_attach(client, bufnr)
		on_attach(client, bufnr)
	end


	local lspconfig=require'lspconfig'
	lspconfig.clangd.setup{on_attach=on_attach_clangd}
	lspconfig.cmake.setup{on_attach=require'completion'.on_attach}

EOF
nnoremap <silent> <leader>h :ClangdSwitchSourceHeader<CR>

"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
lua <<EOF
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		custom_captures = {
			-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
			["foo.bar"] = "Identifier",
			},
		},
	} 
EOF
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set completeopt=menuone,noinsert,noselect  " Set completeopt to have a better completion experience
set shortmess+=c

" vhdirk/vim-cmake
let g:cmake_project_generator = "Ninja"
let g:cmake_export_compile_commands = 1 " same as -DCMAKE_EXPORT_COMPILE_COMMANDS
let g:cmake_ycm_symlinks = 1 " create symlinks to the generated compilation database for use with clangd in neovim/nvim-lspconfig

" scrooloose/nerdtree
"autocmd VimEnter * NERDTree | wincmd p " Enable nerdtree on launch

" vim-airline/vim-airline
autocmd VimEnter * AirlineTheme deus
let g:airline#extensions#tabline#enabled = 1

" liuchengxu/vim-which-key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"Still need fixes
"call which_key#register('<Space>', "g:which_key_map")
"
"nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
"vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
"let g:which_key_map =  {}
"let g:which_key_map = {
"	\ 'name' : '+lsp',
"	\ 'f' : 'formatting' ,
"	\ 'd' : 'go to' ,
"	\ 'D' : 'definition' ,
"	\ 'k' : 'hover',
"	\ 'K' : 'signature_help', 
"	\ 'r' : {
"		\ 'n': 'rename'
"	\ },
"	\ 'e' : 'show_line_diagnostics'
"\ }

" tikhomirov/vim-glsl
autocmd! BufNewFile,BufRead *.vs,*.fs,*.gs,*.tese,*.tesc set ft=glsl
