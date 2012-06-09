if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.tex set ft=tex
  au! BufNewFile,BufRead *.json set ft=javascript
augroup END
