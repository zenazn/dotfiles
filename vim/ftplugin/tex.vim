let g:tex_flavor = "latex"

nmap <buffer> <C-T> :!pdflatex "%:p"<CR>
if has('macunix')
    nmap <buffer> T :!open "%:p:r.pdf"<CR><CR>
elseif has('unix')
    nmap <buffer> T :!gnome-open "%:p:r.pdf"<CR><CR>
end

" Hard-wrap
setlocal tw=100
