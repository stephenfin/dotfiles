set nocompatible      "Turn off compatibility mode"
set autoindent        "Automatically indent code"
set showmatch         "show bracket matches"
set laststatus=2      "show two status lines"
set number            "enable line numbers"
set ruler             "show ruler at bottom
set incsearch         "move pages as match found"
set hlsearch          "highlight search"
set ignorecase        "case insesitive search"
set confirm           "show confirm dialog if file has unsaved changes"
set backspace=indent,eol,start       "make backspace work like most other programs"
set t_kb=

set splitbelow        " ensure vertical splits go below current pane
set splitright        " ensure horizontal splits go to right of current pane

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
" Key remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <S-Tab> <C-V><Tab>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("autocmd")
    " Enable storing of last location
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Enable INI formatting of devstack 'local.conf' files
    au BufNewFile,BufFilePre,BufRead local.conf set filetype=dosini

    " Enable Markdown formatting of '.md' files
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

    " Set custom formatting style on per-file basis
    au FileType python,rst setlocal textwidth=79
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle package manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Manage Vundle itself
Plugin 'gmarik/Vundle.vim'

" Other plugins
Plugin 'bling/vim-airline'

" Bundles
Bundle 'altercation/vim-colors-solarized'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'rhysd/conflict-marker.vim'
Bundle 'tpope/vim-sleuth'

call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bing/vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline_theme = 'luna'
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rhysd/conflict-marker.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:conflict_marker_enable_mappings = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" altercation/vim-colors-solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
colorscheme solarized

