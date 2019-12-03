augroup filetypedetect
    " Mail
    autocmd BufRead,BufNewFile /tmp/mutt*              setfiletype mail
    autocmd Filetype mail                              setlocal spell tw=72 colorcolumn=73
    autocmd Filetype mail                              setlocal fo+=w
augroup END
