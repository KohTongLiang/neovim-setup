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
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'ibhagwan/fzf-lua', {'branch': 'main'}

" optional for icon support
Plug 'nvim-tree/nvim-web-devicons'

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

" Debugger Adapter Protocol
Plug 'mfussenegger/nvim-dap'

" Log Highlighter
Plug 'fei6409/log-highlight.nvim'

Plug 'pechorin/any-jump.nvim'

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
nnoremap <leader>ff <cmd>FZF<cr>
nnoremap <leader>fd <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>

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

" DAP Configure Unity Adapter
lua << EOF
local dap = require("dap")
dap.adapters.unity = {
	type = 'executable',
	command = '',
	args = { '' }
}
EOF

" fzf for telescope
" lua << EOF
" -- You dont need to set any of these options. These are the default ones. Only
" -- the loading is important
" require('telescope').setup {
"   extensions = {
"     fzf = {
"       fuzzy = true,                    -- false will only do exact matching
"       override_generic_sorter = true,  -- override the generic sorter
"       override_file_sorter = true,     -- override the file sorter
"       case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
"                                        -- the default case_mode is "smart_case"
"     }
"   }
" }
" -- To get fzf loaded and working with telescope, you need to call
" -- load_extension, somewhere after setup function:
" require('telescope').load_extension('fzf')
" EOF

colorscheme tokyonight-moon

" Git Signs
lua << EOF
require('gitsigns').setup {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm = {
        enable = false
      },
    }
EOF

" Normal mode: Jump to definition under cursor
nnoremap <leader>j :AnyJump<CR>

" Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>

" Normal mode: open previous opened file (after jump)
nnoremap <leader>ab :AnyJumpBack<CR>

" Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>

let g:any_jump_disable_default_keybindings = 1

au FileType any-jump nnoremap <buffer> o :call g:AnyJumpHandleOpen()<cr>
au FileType any-jump nnoremap <buffer><CR> :call g:AnyJumpHandleOpen()<cr>
au FileType any-jump nnoremap <buffer> p :call g:AnyJumpHandlePreview()<cr>
au FileType any-jump nnoremap <buffer> <tab> :call g:AnyJumpHandlePreview()<cr>
au FileType any-jump nnoremap <buffer> q :call g:AnyJumpHandleClose()<cr>
au FileType any-jump nnoremap <buffer> <esc> :call g:AnyJumpHandleClose()<cr>
au FileType any-jump nnoremap <buffer> u :call g:AnyJumpHandleUsages()<cr>
au FileType any-jump nnoremap <buffer> U :call g:AnyJumpHandleUsages()<cr>
au FileType any-jump nnoremap <buffer> b :call g:AnyJumpToFirstLink()<cr>
au FileType any-jump nnoremap <buffer> T :call g:AnyJumpToggleGrouping()<cr>
au FileType any-jump nnoremap <buffer> a :call g:AnyJumpToggleAllResults()<cr>
au FileType any-jump nnoremap <buffer> A :call g:AnyJumpToggleAllResults()<cr>

" Show line numbers in search rusults
let g:any_jump_list_numbers = 0

" Auto search references
let g:any_jump_references_enabled = 1

" Auto group results by filename
let g:any_jump_grouping_enabled = 0

" Amount of preview lines for each search result
let g:any_jump_preview_lines_count = 5

" Max search results, other results can be opened via [a]
let g:any_jump_max_search_results = 10

" Prefered search engine: rg or ag
let g:any_jump_search_prefered_engine = 'rg'


" Search results list styles:
" - 'filename_first'
" - 'filename_last'
let g:any_jump_results_ui_style = 'filename_first'

" Any-jump window size & position options
let g:any_jump_window_width_ratio  = 0.6
let g:any_jump_window_height_ratio = 0.6
let g:any_jump_window_top_offset   = 4

" Customize any-jump colors with extending default color scheme:
" let g:any_jump_colors = { "help": "Comment" }

" Or override all default colors
let g:any_jump_colors = {
      \"plain_text":         "Comment",
      \"preview":            "Comment",
      \"preview_keyword":    "Operator",
      \"heading_text":       "Function",
      \"heading_keyword":    "Identifier",
      \"group_text":         "Comment",
      \"group_name":         "Function",
      \"more_button":        "Operator",
      \"more_explain":       "Comment",
      \"result_line_number": "Comment",
      \"result_text":        "Statement",
      \"result_path":        "String",
      \"help":               "Comment"
      \}

" Disable default any-jump keybindings (default: 0)
let g:any_jump_disable_default_keybindings = 1

" Remove comments line from search results (default: 1)
let g:any_jump_remove_comments_from_results = 1

" Custom ignore files
" default is: ['*.tmp', '*.temp']
let g:any_jump_ignored_files = ['*.tmp', '*.temp']

" Search references only for current file type
" (default: false, so will find keyword in all filetypes)
let g:any_jump_references_only_for_current_filetype = 0

" Disable search engine ignore vcs untracked files
" (default: false, search engine will ignore vcs untracked files)
let g:any_jump_disable_vcs_ignore = 0

