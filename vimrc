"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                     " turn off compatibility mode
set smartindent                      " use context-aware code indentation
set showmatch                        " show bracket matches
set laststatus=2                     " show two status lines
set number                           " enable line numbers
set ruler                            " show ruler at bottom
set incsearch                        " move pages as match found
set hlsearch                         " highlight search
set ignorecase                       " case insensitive search
set smartcase                        " ...but use case sensitivity if capitilisation present
set confirm                          " show confirm dialog if file has unsaved changes
set backspace=indent,eol,start       " make backspace work like most other programs
set t_kb=
set mouse=a                          " enable selection of panes with the mouse
set nofoldenable                     " require manual folding
set splitbelow                       " ensure vertical splits go below current pane
set splitright                       " ensure horizontal splits go to right of current pane
set nojoinspaces                     " don't insert two spaces after eol punctuation
set encoding=utf8                    " set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac                 " use Unix as the standard file type
set expandtab                        " use spaces instead of tabs
set lazyredraw                       " fix potential issue with vim-airline
set smarttab                         " be smart when using tabs ;)
set t_Co=256                         " enable 256 colors
set linebreak                        " linebreak on 500 characters
set textwidth=500                    " ...
set autoindent                       " auto indent
set smartindent                      " smart indent
set nowrap                           " wrap lines
set list                             " show tabs as characters (>-------)
"set listchars=tab:..                 " ...
set listchars=tab:\ \ ┊,trail:.,extends:…,precedes:…
set belloff=all                      " disable bell

syntax enable                        " enable syntax highlighting
filetype plugin indent on            " enable automatic text width-setting

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set <leader> to -
let mapleader = "-"

" allow Ctrl+Shift+Tab to insert a real tab
inoremap <S-Tab> <C-V><Tab>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tmux compatibility
" from https://vi.stackexchange.com/a/28284
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &term =~ "screen"
    let &t_BE = "\e[?2004h"
    let &t_BD = "\e[?2004l"
    exec "set t_PS=\e[200~"
    exec "set t_PE=\e[201~"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("autocmd")
  " Enable storing of last location
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " Enable INI formatting of devstack 'local.conf' files
  autocmd BufNewFile,BufFilePre,BufRead local.conf set filetype=dosini

  " Enable Markdown formatting of '.md' files
  autocmd BufNewFile,BufFilePre,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown

  " Enable mail formatting of 'mutt' files
  autocmd BufRead,BufNewFile *mutt-* set filetype=mail

  " Set custom formatting style on per-file basis
  autocmd FileType sh setlocal textwidth=79 shiftwidth=4
  autocmd FileType python setlocal textwidth=79 shiftwidth=4
  autocmd FileType json,html,htmldjango setlocal shiftwidth=2
  autocmd FileType rst setlocal textwidth=79 shiftwidth=4 spell
  autocmd FileType markdown setlocal textwidth=79 shiftwidth=4 spell
  autocmd FileType gitcommit,gitsendemail setlocal textwidth=72 spell
  autocmd FileType hgcommit setlocal textwidth=72 spell
  autocmd FileType yaml setlocal shiftwidth=2
  autocmd FileType css setlocal shiftwidth=2
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

  " Enable Python formatting of '.pyi' files. This comes after the general
  " Python setting
  autocmd BufNewFile,BufRead *.pyi set filetype=python textwidth=130
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extensions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  if has("autocmd")
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

call plug#begin('~/.vim/plugged')

" Other plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/conflict-marker.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'dense-analysis/ale'
Plug 'sjl/badwolf'
Plug 'sickill/vim-monokai'
Plug 'glench/vim-jinja2-syntax'
Plug 'editorconfig/editorconfig-vim'
" Plug 'fatih/vim-go'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-airline/vim-airline

let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1

" rhysd/conflict-marker.vim

let g:conflict_marker_enable_mappings = 1

" dense-analysis/ale

let g:ale_virtualenv_dir_names = ['.tox/shared', '.tox/pep8', '.env', '.venv', 'env', 've-py3', 've', 'virtualenv', 'venv']
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
let g:ale_virtualtext_cursor = 'current'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" -- Keymaps
nnoremap <silent> <Leader>le <Cmd>lopen<CR>
nnoremap <silent> <Leader>lr <Cmd>ALERename<CR>
nnoremap <silent> <Leader>la <Cmd>ALECodeAction<CR>
nnoremap <silent> <Leader>ld <Cmd>ALEGoToDefinition<CR>
nnoremap <silent> <Leader>lf <Cmd>ALEFix<CR>
nnoremap <silent> <Leader>lh <Cmd>ALEHover<CR>
nnoremap <silent> <Leader>li <Cmd>ALEInfo<CR>

" sjl/badwolf

"colorscheme badwolf
"let g:badwolf_darkgutter = 1

" sickill/vim-monokai

colorscheme monokai
