nmap <buffer> <C-T> :!pdflatex "%:p"<CR>

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    nmap <buffer> T :!open "%:p:r.pdf"<CR><CR>
  else
    nmap <buffer> T :!gnome-open "%:p:r.pdf"<CR><CR>
  endif
endif


set spell

" Hard-wrap
setlocal tw=100
