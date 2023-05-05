set number
set relativenumber
set ruler                    " show the cursor position at the bottom right corner
set laststatus=2             " always show the status line
set statusline=%<%F\ %h%m%r%{strftime('\ \|\ %c:%l',getpos('.'))}\ %{&fileencoding}\ %=%P

" Plugin manager
 call plug#begin('~/.local/share/nvim/plugged')

 " Fuzzy finder
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'

 " Autocomplete
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 "
 " Git integration
 Plug 'tpope/vim-fugitive'

 " Syntax highlighting
 Plug 'sheerun/vim-polyglot'

 " Statusline
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'

 " molokai theme
 Plug 'tomasr/molokai'
 
 " Gruvbox theme
 Plug 'gruvbox-community/gruvbox'

" NERD Tree
 Plug 'preservim/nerdtree'

 " OmniSharp
 Plug 'OmniSharp/omnisharp-vim'

 " Copilot
 Plug 'github/copilot.vim'

 call plug#end()
 
 " NERDTree settings
 let g:NERDTreeShowHidden=1          " show hidden files
 let g:NERDTreeMinimalUI=1           " hide the toolbar
 let g:NERDTreeAutoDeleteBuffer=1    " delete buffer when file is deleted
 let g:NERDTreeAutoCenter=1          " center NERDTree when opening a file
 let g:NERDTreeIgnore=['\.pyc$', '\~$']  " ignore files with these patterns
 autocmd StdinReadPre * let s:std_in=1
 autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
 autocmd BufWinEnter * silent NERDTreeFind
 nnoremap <C-t> :NERDTreeToggle<CR>

 " Auto-refresh NERDTree when new file is created
 autocmd BufWritePost * NERDTreeRefreshRoot

 " Set leader key
 let mapleader = "\<Space>"

 " Fuzzy finder
 set rtp+=~/.fzf
 let g:fzf_layout = { 'down': '40%' }
 let g:fzf_buffers_jump = 1
 nnoremap <leader>f :FZF<CR>

 " Omni Sharp
 let g:OmniSharp_translate_cygwin_wsl = 1
 let g:OmniSharp_selector_ui = 'fzf'

 " Autocomplete
 inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
 inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
 let g:coc_global_extensions = [
														 	  'coc-tsserver',
 																'coc-eslint',
																'coc-json',
																'coc-yaml',
															  'coc-prettier', 
																'coc-go',
																'coc-python',
																'coc-css',
																'coc-html',
																'coc-omnisharp'
																]
let g:coc_node_args = ['--max-http-header-size=102400']
let g:coc_install_retry = 1
nnoremap <C-f> :CocCommand prettier.formatFile<CR>


 " Git integration
 nnoremap <leader>gs :Git<CR>

 " Buffer Switching
 let g:airline#extensions#tabline#enabled = 1
 let g:airline#extensions#tabline#buffer_nr_show = 1

 " Statusline
 let g:airline_theme='gruvbox'
 let g:airline#extensions#tabline#enabled=1
 let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
 let g:airline_powerline_fonts = 1

 " Set colorscheme
 syntax enable

 " set termguicolors
 set background=dark
 
 " colorscheme molokai
 colorscheme gruvbox

