let g:tex_flavor = "latex"

nmap <buffer> <C-T> :!pdflatex %<CR>
nmap <buffer> T :!open %<.pdf<CR><CR>

" Hard-wrap
setlocal tw=100
