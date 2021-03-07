set nocompatible      " turn off compatibility mode
set smartindent       " use context-aware code indentation
set showmatch         " show bracket matches
set laststatus=2      " show two status lines
set number            " enable line numbers
set ruler             " show ruler at botto
set incsearch         " move pages as match found
set hlsearch          " highlight search
set ignorecase        " case insensitive search
set smartcase         " ...but use case sensitivity if capitilisation present
set confirm           " show confirm dialog if file has unsaved changes
set backspace=indent,eol,start       " make backspace work like most other programs
set t_kb=
set mouse=a           " enable selection of panes with the mouse
set nofoldenable      " require manual folding

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

" Enable automatic text width-setting
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable automatic paste mode
" From https://coderwall.com/p/if9mda/
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

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
  au BufNewFile,BufFilePre,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown

  " Enable mail formatting of 'mutt' files
  aut BufRead,BufNewFile *mutt-* set filetype=mail

  " Set custom formatting style on per-file basis
  au FileType sh setlocal textwidth=79 shiftwidth=4
  au FileType python setlocal textwidth=79 shiftwidth=4
  au FileType json,html setlocal shiftwidth=2
  au FileType rst setlocal textwidth=79 shiftwidth=4 spell
  au FileType markdown setlocal textwidth=79 shiftwidth=4 spell
  au FileType gitcommit,gitsendemail setlocal textwidth=72 spell
  au FileType hgcommit setlocal textwidth=72 spell
  au FileType yaml setlocal shiftwidth=2
  au FileType css setlocal shiftwidth=2

  " Enable Python formatting of '.pyi' files. This comes after the general
  " Python setting
  au BufNewFile,BufRead *.pyi set filetype=python textwidth=130
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extensions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Other plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/conflict-marker.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline/vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline_theme = 'luna'
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rhysd/conflict-marker.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:conflict_marker_enable_mappings = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scrooloose/syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle this using F4
" Courtesy of Mark Gray <mark.d.gray@intel.com>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
