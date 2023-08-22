set number
set relativenumber
set ruler                    " show the cursor position at the bottom right corner
set laststatus=2             " always show the status line
set statusline=%<%F\ %h%m%r%{strftime('\ \|\ %c:%l',getpos('.'))}\ %{&fileencoding}\ %=%P

" Allow copy paste inbetween neovim and other processes
set clipboard=unnamed

" Plugin manager
call plug#begin('~/.local/share/nvim/plugged')

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theme
Plug 'folke/tokyonight.nvim'

" OmniSharp
Plug 'OmniSharp/omnisharp-vim'

" Copilot
Plug 'github/copilot.vim'

" NERDTree
Plug 'preservim/nerdtree'

" Comment
Plug 'numToStr/Comment.nvim'

call plug#end()

" Set leader key
let mapleader = "\<Space>"

" Setup comment
lua << EOF
	require('Comment').setup()
EOF

" nerd tree config
let g:NERDTreeShowHidden=1          " show hidden files
let g:NERDTreeMinimalUI=1           " hide the toolbar
let g:NERDTreeAutoDeleteBuffer=1    " delete buffer when file is deleted
" let g:NERDTreeAutoCenter=1          " center NERDTree when opening a file
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" autocmd BufWinEnter * silent NERDTreeFind
nnoremap <C-t> :NERDTreeToggle<CR>
autocmd BufWritePost * NERDTreeRefreshRoot

" Fuzzy finder
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Omni Sharp
let g:OmniSharp_translate_cygwin_wsl = 1
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1

" Autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint','coc-json','coc-yaml','coc-prettier','coc-go','coc-python',	'coc-css','coc-html','coc-omnisharp', 'coc-clangd']

let g:coc_node_args = ['--max-http-header-size=102400']
let g:coc_install_retry = 1
nnoremap <C-f> :CocCommand prettier.formatFile<CR>


" Git integration
nnoremap <leader>gs :Git<CR>
lua << EOF
	require('gitsigns').setup()
EOF


" Statusline
" Buffer Switching
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline_theme='tokyonight'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

" Set colorscheme
syntax enable

colorscheme tokyonight-night

