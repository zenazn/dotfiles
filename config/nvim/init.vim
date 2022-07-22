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
noremap Q gq

" Leader maps
let mapleader = ','

nmap <leader>gb :Git blame<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gg :Ggrep<Space>
nmap <leader>gs :Git<CR>
nmap <leader>gw :GBrowse<CR>
vmap <leader>gw :GBrowse<CR>
nmap <leader>gl :Gclog<CR>

nmap <leader>cc :cclose<CR>
nmap <leader>co :copen<CR>
nmap <leader>z  :pclose<CR>

nmap <leader>.  :nohlsearch<CR>

nmap <leader>s  :sp<CR>
nmap <leader>v  :vsp<CR>
nmap <leader>q  :q<CR>

nmap <leader>m  :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>
nnoremap <leader>S :%s/\<<C-r><C-w>\>/

nmap <leader><leader>  :confirm w<CR>

set background=light

set errorformat+="%f:%l:%c - %m%r"
set errorformat+="%f:%l:%m%r"

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Colors
highlight Pmenu ctermbg=darkgray ctermfg=white
highlight PmenuSel ctermbg=yellow ctermfg=black
highlight Search ctermbg=yellow ctermfg=black
highlight SignColumn ctermbg=black
highlight Whitespace ctermfg=darkgray

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

"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"    \ 'typescript': {'name': 'typescript', 'command': ['~/bin/ts-language-server', '--stdio'], 'initializationOptions': {
"    \   'preferences': { 'importModuleSpecifierPreference': 'non-relative'}
"    \ }},
"    \ 'typescriptreact': {'name': 'typescript', 'command': ['~/bin/ts-language-server', '--stdio'], 'initializationOptions': {
"    \   'preferences': { 'importModuleSpecifierPreference': 'non-relative'}
"    \ }},
"    \ }

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'cpp': ['clangd', '--log=verbose', '--compile-commands-dir=.'],
    \ 'typescript': {'name': 'typescript', 'command': ['~/bin/ts-language-server', '--stdio']},
    \ 'typescriptreact': {'name': 'typescript', 'command': ['~/bin/ts-language-server', '--stdio']},
    \ }

let g:LanguageClient_rootMarkers = {
      \ 'rust': ['Cargo.toml'],
      \ 'typescript': ['pnpm-lock.yaml', 'package-lock.json', '.git'],
      \ 'typescriptreact': ['pnpm-lock.yaml', 'package-lock.json', '.git'],
      \ }

" Nobody messes with my quickfix!
let g:LanguageClient_diagnosticsList = 'Disabled'

function LC_maps()
  "if exists('*LanguageClient#isServerRunning') && LanguageClient#isServerRunning()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <F5> :call LanguageClient_contextMenu()<CR>
    nnoremap <F6> :call LanguageClient#explainErrorAtPoint()<CR>
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    nnoremap <silent> <leader>a :call LanguageClient#textDocument_codeAction()<CR>
    nnoremap <silent> <leader>i :call LanguageClient#textDocument_codeAction('_typescript.applyWorkspaceEdit')<CR>

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

autocmd FileType typescript syn sync fromstart
autocmd FileType typescriptreact syn sync fromstart
