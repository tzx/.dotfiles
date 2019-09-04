"Vim-Plug
call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
call plug#end()

"Automatic toggling of relative and absolute line numbers
set number relativenumber

"Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

"Smart Indent
set si

"Highlight cursorline
set cursorline
