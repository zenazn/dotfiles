" Don't emulate vi bugs
set nocompatible

" Load pathogen
filetype off
call pathogen#runtime_append_all_bundles()

" Syntax highlighting
syntax on
filetype plugin indent on
au FileType tex setlocal tw=100

" Autocompletion
set wildmenu
set wildmode=list:longest

" Indentation and such
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Show matching brace
set showmatch

" Visual bells
set vb t_vb=

" Always show ruler
set ruler
set title

" Search stuff
set nohlsearch
set incsearch
set magic
set ignorecase
set infercase
set smartcase

" Hidden buffers
set hidden

" Backspacing
set backspace=indent,eol,start

" Did you forget to sudo?
cmap w!! w !sudo tee % >/dev/null

" Useful (re)maps
nnoremap ' `
nnoremap ` '
let mapleader = ','

" NERDTree options
let NERDTreeIgnore = ['\.pyc$', '\.swp$']
nmap <leader>m :NERDTreeToggle<CR>

" Peepcode shortcut
nmap <leader><space> <leader>p

" Basic skeleton files
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

" Yankring
let g:yankring_history_dir = "$HOME/.vim"

" Are we running in a gui?
if has("gui_running")
    " No toolbar
    set go-=T
    " No left scrollbar (eww)
    set go-=L
    " Awesome colorscheme
    colorscheme ir_black
    " Antialiasing
    set anti
    set columns=120
    set lines=60
    if has("gui_macvim")
        " Fullscreen
        set fuoptions=maxvert,maxhorz
        set guifont=Menlo:h10
    elseif has("gui_gtk2")
        set guifont=Inconsolata
    end
end
