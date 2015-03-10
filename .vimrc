
set term=screen-256color
set nocompatible              " be iMproved, required
filetype off                  " required
set nowrap
set number
"set relativenumber
set cursorline
set colorcolumn=80,100

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'terryma/vim-multiple-cursors'

Bundle 'tpope/vim-surround'
Bundle 'gcmt/breeze.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'SirVer/ultisnips'
Bundle 'tomtom/tcomment_vim'
Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
Bundle 'valloric/YouCompleteMe'
Bundle 'scrooloose/nerdtree'


Bundle 'zeis/vim-kolor'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Color Themes
colorscheme kolor 

if has('autocmd')
	filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
	syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set showmatch
set showmode
set smarttab

set nrformats-=octal
set shiftround

set ttimeout
set ttimeoutlen=50

set incsearch

" Use <C-L> to clear the highlighting of :set hlsearch.

if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set ruler
set showcmd
set wildmenu

set autoread

"set encoding=utf-8
set tabstop=2 shiftwidth=2 expandtab
set listchars=tab:▒░,trail:▓
set list

set hlsearch
set ignorecase
set smartcase

" Don't use Ex mode, use Q for formatting
map Q gq

" do not allow hidden buffers
set hidden

set nobackup
set nowritebackup
set noswapfile
set fileformats=unix,dos,mac

set completeopt=menuone,longest,preview

"
" Plugins config
"

" NERDTree
map <C-t> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" CtrlP
let g:ctrlp_max_height = 20
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/tmp/*,*/vendor/* 
" Refresh the CtrlP cache when a file is written
function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction
if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
endif

" Ultisnip
" NOTE: <f1> otherwise it overrides <tab> forever
let g:UltiSnipsExpandTrigger="<f1>"
let g:UltiSnipsJumpForwardTrigger="<f1>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:did_UltiSnips_vim_after = 1

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:bufferline_fname_mod = ':.'


"
" Basic shortcuts definitions
"  most in visual mode / selection (v or ⇧ v)
"

" Increment and decrement numbers, one per line. Thanks Toran!
function! Incr(...)
  let a = line('.') - line("'<") + 1
  let c = virtcol("'<")
  if a:0
    execute 'normal! '.c.'|'.a."\<C-x>"
  else
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap ++ :call Incr()<CR>
vnoremap -- :call Incr('reverse')<CR>

" Swap the word the cursor is on with the next word (which can be on a
" newline, and punctuation is "skipped"):
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>:noh<CR>

" indend / deindent after selecting the text with (⇧ v), (.) to repeat.
vnoremap <Tab> >
vnoremap <S-Tab> <
" Disable tComment to escape some entities
let g:tcomment#replacements_xml={}
" Text wrap simpler, then type the open tag or ',"
vmap <C-w> S

" lazy ':'
map \ :

let mapleader = ','
" Toggle paste mode with ", p" to paste from non-vim sources
nnoremap <Leader>p :set paste!<CR>
noremap  <Leader>g :GitGutterToggle<CR>

" Strip whitespace
autocmd FileType c,cpp,java,php,python,javascript,html autocmd BufWritePre <buffer> :%s/\s\+$//e

" this machine config
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

