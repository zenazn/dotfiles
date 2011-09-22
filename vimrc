" Don't emulate vi bugs
set nocompatible

" Load pathogen
filetype off
call pathogen#runtime_append_all_bundles()

" Fix filetype detection
autocmd BufNewFile,BufRead *.tex set ft=tex

" Syntax highlighting
syntax enable

" Autocompletion
set wildmenu
set wildmode=list:longest

" Indentation and such
" Most things should be handled by the filetype plugin
filetype plugin indent on
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
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

" Ctags
set tags=tags;/
nnoremap <leader>d <C-w>}
nnoremap <leader>z <C-w>z

" Try to keep backups and .swp files out of the working directory
set directory=~/.tmp//,/tmp//,.
set backupdir=~/.tmp//,/tmp//,.

" Backspacing
set backspace=indent,eol,start

" Did you forget to sudo?
cmap w!! w !sudo tee % >/dev/null

" Useful (re)maps
nnoremap ' `
nnoremap ` '
let mapleader = ','

" NERDTree options
let NERDTreeIgnore = ['\.pyc$', '\.swp$', '\.cmi$', '\.cmo$']
nmap <leader>m :NERDTreeToggle<CR>

" Basic skeleton files
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Argh Python comments
au! FileType python setl nosmartindent

set background=light

" Are we running in a gui?
if has("gui_running")
    " No toolbar, left scrollbar, or menubar
    set go-=T
    set go-=L
    set go-=m
    " Awesome colorscheme
    set background=dark
    colorscheme solarized
    " Antialiasing
    set anti
    set columns=120
    set lines=60
    if has("gui_macvim")
        " Fullscreen
        set fuoptions=maxvert,maxhorz
        set guifont=Menlo:h10

        " Peepcode shortcut
        nmap <leader><space> <leader>p
    elseif has("gui_gtk2")
        set guifont=Inconsolata
    end
end
