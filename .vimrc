" Gobal terminal settings
set encoding=utf-8
set t_Co=256

" General settings
set number
set cb=autoselect
set nocompatible
set background=dark
set autoindent
set sw=4
set ts=4
set expandtab
set backspace=indent,eol,start
set whichwrap=b,s,l,h,<,>,[,]
set icon
set title
set showbreak=\\
set noeol
set et
set hlsearch
set keywordprg=man\ -k
set formatprg=fmt
set hidden
set switchbuf=useopen
set showmatch
set matchtime=1
set showcmd
set lazyredraw
set viminfo='20,<50,/50  " Should appear after 'set nocompatible'
set history=50
set ruler
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set cpoptions=aABceFs
set smartcase
set incsearch
set autowrite
set scrolloff=3
set nosmartindent

set report=0
set wildmenu

filetype on
filetype off

if has("mouse")
  set mouse=a
  set mousemodel=extend
  set mousefocus
  set mousehide
endif

if has("syntax")
  syntax on
endif

if has("autocmd")
  " automatically delete trailing DOS-returns and trailing whitespaces
  autocmd BufWritePre *.c,*.go,*.h,*.y,*.yy,*.l,*.ll,*.C,*.cpp,*.hh,*.cc,*.hxx,*.cxx,*.hpp,*.java,*.rb,*.py,*.m4,*.pl,*.pm silent! %s/[\r \t]\+$//
endif

" Key mapping
" imap <C-SPACE> <C-P>
let mapleader = ","

" Paste
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Change buffer
" map <C-N> :bn<CR>
map <C-B> :bp<CR>

" Hide coloration of found words
nmap <silent> ,/ :nohlsearch<CR>

imap <C-TAB> <C-V><C-TAB>

" Paste toggle
" set pastetoggle=<C-P>
" noremap <C-P> :set invpaste<CR>

nmap _Y :!echo ""> ~/.vi_tmp<CR><CR>:w! ~/.vi_tmp<CR>
vmap _Y :w! ~/.vi_tmp<CR>
nmap _P :r ~/.vi_tmp<CR>

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'tristen/vim-sparkup'
Plugin 'corntrace/bufexplorer'
Plugin 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-surround'

" Go Plugins
Plugin 'fatih/vim-go'
Plugin 'jstemmer/gotags'
Plugin 'majutsushi/tagbar'

" Python Plugins
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/python.vim'
Plugin 'vim-scripts/indentpython.vim'

" Color Plugins
Plugin 'morhetz/gruvbox'
Plugin 'haensl/mustang-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Powerline
set laststatus=2

" NERDtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
map <leader>t :NERDTreeToggle<CR>

" Command-T
map <leader>f :CommandT<CR>

" Mapping window splits nav shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

map <C-x> :close<CR>

" These should be moved to ftplugin python.vim
" Flake8
let g:flake8_error_marker='EE'
let g:flake8_max_line_length=99
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
let g:flake8_show_quickfix=0
let g:flake8_pyflake_marker=1
autocmd FileType python map <buffer> <C-n> :call Flake8()<CR>
autocmd BufWritePost *.py call Flake8()

" Go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"

" YouCompleteMe YCM
" let g:ycm_auto_trigger = 0
" let g:ycm_key_invoke_completion = '<C-Space>'

" Colors
colorscheme mustang


" tagbar
nmap <F8> :TagbarToggle<CR>

" gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
