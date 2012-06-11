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
