" Don't emulate vi bugs
set nocompatible

" Load pathogen
filetype off
call pathogen#infect()

" Fix filetype detection
autocmd BufNewFile,BufRead *.tex set ft=tex

" Syntax highlighting
syntax enable
filetype plugin indent on

" Autocompletion
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version control
set wildignore+=tags " ctags
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

" Try to keep backups and .swp files out of the working directory
set directory=~/.tmp//,/tmp//,.
set backupdir=~/.tmp//,/tmp//,.

" Backspacing
set backspace=indent,eol,start

" Useful (re)maps
nnoremap ' `
nnoremap ` '
nnoremap Y y$

" Leader maps
let mapleader = ','

nmap <leader>gb :Gblame<CR>
nmap <leader>ge :Gedit<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gg :Ggrep<Space>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gw :Gbrowse<CR>
vmap <leader>gw :Gbrowse<CR>
nmap <leader>gl :Glog<CR><CR><CR>:copen<CR>

nmap <leader>cc :cclose<CR>
nmap <leader>co :copen<CR>

nmap <leader>s  :sp<CR>
nmap <leader>v  :vsp<CR>

nmap <leader><Space> :NERDTreeToggle<CR>

nmap <leader>m  :make<CR>

nmap <leader>z  :pclose<CR>

" Basic skeleton files
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

" Colors!
set t_Co=256
set background=dark
colorscheme solarized

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Are we running in a gui?
if has("gui_running")
  " No toolbar, right scrollbar, left scrollbar, or menubar
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guioptions-=m
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
