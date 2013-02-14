if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.cheetah set ft=cheetah
  au! BufNewFile,BufRead *.genshi set ft=genshi
  au! BufNewFile,BufRead *.json set ft=javascript
  au! BufNewFile,BufRead *.md set ft=markdown
  au! BufNewFile,BufRead *.tex set ft=tex
augroup END
