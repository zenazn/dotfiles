set nocompatible

" Load pathogen
filetype off
call pathogen#infect()

" Syntax highlighting
syntax enable
filetype plugin indent on

" Display
set encoding=utf-8
set ruler
set title
set showcmd
set showmode
set showmatch

" Indentation
set autoindent
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2

set list!
set listchars=tab:>-

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
if has("patch-7.4.941")
  set tagcase=match
end

" Autocompletion
set wildmenu
set wildmode=list:longest
set wildignore+=.hg/,.git/,.svn/ " Version control
set wildignore+=tags " ctags
set wildignore+=*.aux,*.out,*.toc " LaTeX
"set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.pdf " Images and PDFs
set wildignore+=*.o,*.lo,*.la " C
set wildignore+=*.pyc,*.cmi,*.cmo,*.cmx " Python and OCaml
set completeopt=longest,menu,preview

" Other behaviors
set autoread
set backspace=indent,eol,start
set formatoptions=tcqnl
set hidden
set nofoldenable
set textwidth=80
set ttyfast
set visualbell
set nojoinspaces

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

fu! SingleQuote(str)
  return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfu
fu! Cabbrev(key, value)
  exe printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
    \ a:key, 1+len(a:key), SingleQuote(a:value), SingleQuote(a:key))
endfu

" ctags / cscope
set tags=tags;/
if has("cscope")
  set cscopetagorder=1
  set cscopetag
  " Try to load databases
  set nocscopeverbose
  if filereadable("cscope.out")
    cs add cscope.out
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set cscopeverbose
else
  " Use tjump
  call Cabbrev('tag', 'tjump')
  nnoremap <C-]> g<C-]>
  vnoremap <C-]> g<C-]>
  nnoremap <C-w>] <C-w>g<C-]>
end

" Try to keep backups and .swp files out of the working directory
set directory=~/.tmp//,/tmp//,.
set backupdir=~/.tmp//,/tmp//,.

" Keep more data
set history=50
set undolevels=1000

" Useful (re)maps
nnoremap ' `
nnoremap ` '
nnoremap Y y$
map Q gq

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
nmap <leader>z  :pclose<CR>

nmap <leader>.  :nohlsearch<CR>

nmap <leader>s  :sp<CR>
nmap <leader>v  :vsp<CR>
nmap <leader>q  :q<CR>

nmap <leader>m  :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>

nmap <leader><leader>  :confirm w<CR>

" Basic skeleton files
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

" Colors!
set t_Co=256
set background=light

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

if executable("ag") == 1
  set grepprg=ag\ --nogroup\ --nocolor
elseif executable("ack") == 1
  set grepprg=ack\ -k
end

" This speeds up ctrlp *a lot*.
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

if !executable("go")
  let g:go_disable_autoinstall = 1
end

let g:go_fmt_command = "goimports"

" This makes opening Ruby files much faster
let g:ruby_path = []

if executable("fzf")
  let g:ctrlp_cmd = 'FZF'
end
