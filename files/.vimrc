""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""

" I use vim-plug to install plugins
call plug#begin()

Plug 'scrooloose/nerdtree'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Add auto-complete for Go
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'editorconfig/editorconfig-vim'

call plug#end()

"""
" Fuzzy Finder
"""

" Ctrl-P opens fuzzy file finder
nnoremap <C-P> :Files<CR>

" Make FZF respect gitignore if `ag` is installed
if (executable('ag'))
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
endif

"""
" Deoplete Auto-completion
"""

" Start Deoplete on startup
let g:deoplete#enable_at_startup = 1

" Use tab to cycle through autocomplete suggestions
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"""
" Go
"""

" Use goimports rather than gofmt on save
let g:go_fmt_command = "goimports"

" Highlight types, struct fields, function declarations and invocations 
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM remembers
set history=500

" Turns off VI compatibility
set nocompatible

" Enable filetype plugins
filetype plugin on
filetype indent on

" :W saves the file with SUDO
command W w !sudo tee % > /dev/null

""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""

" Ignore compiled files, Git, and Mac files
set wildignore=*.o,*/.git/*,*/.DS_Store

" Show current position in file
set ruler

" Ignore case while searching and try to be smart about cases
set ignorecase
set smartcase

" Highlight search results
set hlsearch
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" Turn off error sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""""""""""""""""""""""""""""
" Colours and fonts
""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Enable 256 color palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Use the "desert" colorscheme
try
    colorscheme desert
catch
endtry

" Use a dark background
set background=dark

" Set UTF8 as default encodeing
set encoding=utf8

" Set preference order of file endings
set ffs=unix,dos,mac

""""""""""""""""""""""""""""""""""""""
" Files, backups, and undo
""""""""""""""""""""""""""""""""""""""

" Turn backups off
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""
" Text, tabs, and indendation
""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak after 100 characters
set lbr
set tw=100

" Auto indent and smart indent
set ai
set si

" Wrap lines
set wrap

""""""""""""""""""""""""""""""""""""""
" Visual mode
""""""""""""""""""""""""""""""""""""""

" Pressing '*' or '#' searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

