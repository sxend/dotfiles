"
"" Filetype detection
"
augroup filetypedetect
" Detect .txt as 'text'
  au BufNewFile,BufRead *.txt setf text
  au BufNewFile,BufRead *.scala setf scala
augroup END
