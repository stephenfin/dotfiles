" Make existing Vim plugins and runtime files available.
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Share settings with Vim.
source ~/.vimrc
