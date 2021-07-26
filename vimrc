set nocompatible
set nowrap  " don't wrap
set number  " line numbers
set ignorecase " don't care about case in search
set smartcase
set hlsearch
set incsearch
set noswapfile
set title
set showmatch " jump to matching bracket
set showcmd
set laststatus=2
set encoding=utf-8
set updatetime=100

" system clipboard
set clipboard=unnamed
if system('uname -s') == 'Linux'
    set clipboard=unnamedplus
endif

" speed things up
set lazyredraw
set ttyfast

" syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on

" key mappings | general
"inoremap <C-Space> <C-x><C-o> " FIXME: remove
"inoremap <C-@> <C-Space> FIXME: remove
inoremap <C-@> <C-x><C-o>
nmap <Leader>< :10winc<<CR> " \< to move window size left on vsplit
nmap <Leader>> :10winc><CR> " \> to move window size right on vsplit
nmap <Esc><Esc> :noh<CR><C-g>
nnoremap <Backspace> <C-o>
nmap <Leader>q :q<CR>
nmap <Leader>Q :q!<CR>
nmap <Leader>w :w<CR>

" key mappings | go
autocmd FileType go nnoremap <buffer> <silent> <C-w><C-m> :<C-u>call go#def#Jump("split", 0)<CR>
autocmd FileType go nnoremap <buffer> <silent> <C-w><C-]> :<C-u>call go#def#Jump("split", 0)<CR>
autocmd FileType go nnoremap <buffer> <silent> <C-w>] :<C-u>call go#def#Jump("split", 0)<CR>
autocmd FileType go nnoremap <buffer> <silent> <C-t> :<C-U>call go#def#StackPop(v:count1)<cr>
autocmd FileType go nnoremap gd :GoDef<CR>              " go to definition
autocmd FileType go nnoremap gi :GoInfo<CR>             " show func signature
autocmd FileType go nnoremap ga :GoAlternate<CR>        " show test file
autocmd FileType go nmap <Leader>t :w<CR>:GoTestFunc<CR> " test func under cursor
autocmd FileType go nmap <Leader>f :GoFmt<CR>
autocmd FileType go nmap <Leader>d :GoDoc<CR>
autocmd FileType go nmap <Leader>w :GoFmt<CR>:w<CR> " caps + * to save, and do go fmt and stuff
autocmd FileType go nmap <Leader>r :GoRun<CR>

" macros
let @i="oif err != nil {\<CR>return \<CR>}\<Esc>kA"
let @f="A // FIXME: testing"
let @p="ifmt.Printf(\" -> DEBUG: %s %+v\", \"\", ) // FIXME: testing\<Esc>BBBBi"

" tabs for go
autocmd FileType go setlocal noexpandtab

" plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/ag'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug '907th/vim-auto-save'

call plug#end()

" colorscheme
" colorscheme everforest

