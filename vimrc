" Don't emulate vi bugs
set nocompatible

" Load pathogen
filetype off
call pathogen#runtime_append_all_bundles()

" Fix filetype detection
autocmd BufNewFile,BufRead *.tex set ft=tex

" Syntax highlighting
syntax enable
filetype plugin indent on

" Autocompletion
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version control
"set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.pdf " Images and PDFs
set wildignore+=*.o,*.pyc,*.aux,*.cmi,*.cmo,*.cmx " Various compiled formats

" Indentation and such
set autoindent
set expandtab
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2

" Reformatting
nnoremap Q gq
vnoremap Q gq

" Show matching brace
set showmatch

" Visual bells
set visualbell

" Always show ruler
set ruler
set title

" Search stuff
set nohlsearch
set incsearch
set ignorecase
set smartcase

" Hidden buffers
set hidden

" Automatically load changed buffers
set autoread

" Ctags
set tags=tags;/
nnoremap <leader>d <C-w>}
nnoremap <leader>z <C-w>z

" Try to keep backups and .swp files out of the working directory
set directory=~/.tmp//,/tmp//,.
set backupdir=~/.tmp//,/tmp//,.

" Backspacing
set backspace=indent,eol,start

" Useful (re)maps
nnoremap ' `
nnoremap ` '
let mapleader = ','
nnoremap Y y$

" NERDTree options
nmap <leader>m :NERDTreeToggle<CR>

" Basic skeleton files
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

set background=light

" Are we running in a gui?
if has("gui_running")
  " No toolbar, right scrollbar, left scrollbar, or menubar
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guioptions-=m
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
