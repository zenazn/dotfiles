" Don't emulate vi bugs
set nocompatible

" Syntax highlighting
syntax on
filetype on
au FileType python setlocal sw=4 ts=4
au FileType c setlocal sw=4 ts=4
au BufNewFile,BufRead *.phpt set filetype=php

" Autocompletion
set wildmenu
set wildmode=list:longest

" Indentation and such
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
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

