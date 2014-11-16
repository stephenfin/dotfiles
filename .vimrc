set nocompatible      "Turn off compatibility mode"
set autoindent        "Automatically indent code"
set showmatch         "show bracket matches"
set laststatus=2      "show two status lines"
set ruler             "show ruler at bottom
set incsearch         "move pages as match found"
set hlsearch          "highlight search"
set ignorecase        "case insesitive search"
set confirm           "show confirm dialog if file has unsaved changes"
set backspace=indent,eol,start       "make backspace work like most other programs" 
set t_kb=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable highlighting of EOL
set list
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set listchars=eol:$,tab:>-

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Fix potential issue with vim-airline
set lazyredraw

" Be smart when using tabs ;)
set smarttab

" Enable 256 colors
set t_Co=256

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Misc fixes for vim-airline
set ambiwidth=double
set timeoutlen=50

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle package manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Manage Vundle itself
Plugin 'gmarik/Vundle.vim'

" Other plugins
Plugin 'bling/vim-airline'

Bundle 'altercation/vim-colors-solarized'
Bundle 'desert-warm-256'
Bundle 'monokai'
Bundle 'vim-scripts/busybee'
Bundle 'ntpeters/vim-better-whitespace'

call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:airline_theme             = 'powerlineish'
let g:airline_theme             = 'luna'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline_powerline_fonts   = 1

" Set color scheme

