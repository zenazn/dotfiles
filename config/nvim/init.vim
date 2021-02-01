" Indentation
set expandtab
set shiftround
set shiftwidth=2
set softtabstop=2
set tabstop=2

set list
set listchars=tab:>-

" Search
set ignorecase
set smartcase
set tagcase=match

" Completion
set wildmode=list:longest

set formatoptions=tcqnlj
set nojoinspaces
set hidden
set nofoldenable
set textwidth=80
set visualbell

set tags=./tags;/

" Try to keep backups and .swp files out of the working directory
set directory=/tmp//,.
set backupdir=/tmp//,.

" Consistency
nnoremap Y y$
inoremap <C-c> <ESC>
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

set background=light

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

if executable("rg")
  set grepprg=rg\ -n
end

" Language stuff

if !executable("go")
  let g:go_disable_autoinstall = 1
end
let g:go_fmt_command = "goimports"
let g:go_template_autocreate = 0
hi SpellBad cterm=bold ctermbg=gray
hi SpellRare cterm=bold ctermbg=darkgray

" This makes opening Ruby files much faster
let g:ruby_path = []

let g:omni_sql_no_default_maps = 1

let g:javascript_plugin_flow = 1

let g:rustfmt_autosave = 1
let g:rust_clip_command = 'pbcopy'

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'typescriptreact': ['typescript-language-server', '--stdio'],
    \ }

function LC_maps()
  if exists('*LanguageClient#isServerRunning') && LanguageClient#isServerRunning()
    nnoremap <F5> :call LanguageClient_contextMenu()<CR>
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
  endif
endfunction

autocmd FileType * call LC_maps()

nnoremap <C-p> :Files<CR>
nnoremap <C-q> :Buffers<CR>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

call plug#begin(stdpath('data') . '/plug-data')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'zenazn/gotodef.vim'

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp', { 'do': 'pip3 install pynvim' }

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'vim-ruby/vim-ruby'
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'

" tsx
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'jparise/vim-graphql'

call plug#end()

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

augroup LanguageClient_config
  autocmd!
  autocmd User LanguageClientStarted setlocal signcolumn=yes
  autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END
