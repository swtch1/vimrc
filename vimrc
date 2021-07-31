set nocompatible
set nowrap
set number  " line numbers
set ignorecase " don't care about case in search
set smartcase
set nosmartindent
set hlsearch
set incsearch
set noswapfile
set title
set showmatch " jump to matching bracket
set showcmd
set laststatus=2
set encoding=utf-8
set updatetime=100
"set splitbelow
set splitright
set timeoutlen=750 " ms to wait before waiting for extra keys
set shortmess-=S " show count when searching
set scrolloff=5
set visualbell
set history=10000
set wildignorecase
set number relativenumber
set hidden " allow navigating away from unsaved buffers
"set autochdir

" allow backspace to delete indentation and inserted text
set backspace=indent,eol,start

" make completion sane
set completeopt-="preview"
"set completeopt="menu,preview,longest" " muck with this, but it's not working now

" remember line position
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" syntax highlighting for things that might have large data
set maxmempattern=1048576

" properly handle colors in tmux
set background=dark
set t_Co=256
set t_ut=

" persistent undo
if has('persistent_undo')
    set undodir=$HOME/.vim/undo
    set undolevels=10000
    set undofile
endif

" change cursorline on insert
set cursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline

" system clipboard
set clipboard=unnamed
if system('uname -s') == 'Linux'
    set clipboard=unnamedplus
endif

" speed things up
set lazyredraw
set ttyfast

" tab spacing
autocmd FileType go setlocal tabstop=2

" syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on

" vim-go settings
"let g:go_auto_type_info=1 " auto show signature
let g:go_term_enabled=0
let g:go_term_reuse = 1
let g:go_term_close_on_exit = 0
let g:go_term_mode="split"
let g:go_metalinter_autosave=1
let g:go_code_completion_icase = 1
"let g:go_auto_sameids = 1
"let g:go_list_height = 25
let g:go_gopls_use_placeholders = "gopls"

" remap leader
let mapleader = "\<Space>"

" keymap | general
map Q <Nop>" this piece of trash needs to die
inoremap <C-@> <C-x><C-o>
nnoremap <Leader><Esc> :noh<CR>
nnoremap <Leader>! :q!<CR>
nnoremap <Leader>p :GFiles<CR>
nnoremap <Leader>w :w<CR>" make saving easier
nnoremap <Leader>v <C-v>
"make Y copy to the end of the line
nnoremap Y y$
" searching should keep the cursor in the same place
nnoremap n nzz
nnoremap N Nzz
" undo break points..don't undo every damn thing from last insert
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap = ?<c-g>u
inoremap , ,<c-g>u
"duplicate blocks of text
nnoremap <Leader>d Va}:t'><CR>

nnoremap <Leader>h <C-W>h
nnoremap <Leader>j <C-W>j
nnoremap <Leader>k <C-W>k
nnoremap <Leader>l <C-W>l

nnoremap <Leader>o <C-o>
nnoremap <Leader>i <C-i>

" keymap | buffers
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>Q :bd!<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bN :bNext<CR>
nnoremap <Leader><Space> :e#<CR>" switch to last buffer

" keymap | tabs
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tf :tabfind
nnoremap <Leader>th :tabprev<CR>
nnoremap <Leader>tl :tabnext<CR>

" keymap | location list
nmap <Leader>n :lnext<CR>
nmap <Leader>N :lprev<CR>

" keymap | focus
nnoremap <Leader>fn :NERDTreeTabsOpen<CR>:NERDTreeFocus<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>ft :TagbarOpenAutoClose<CR>
nnoremap <Leader>fT :TagbarOpen<CR>

" keymap | close
nmap <Leader>cc :cclose<CR>:lclose<CR>
nnoremap <Leader>cn :NERDTreeTabsClose<CR>

" keymap | resize
nmap <Leader>, :15winc<<CR> " \< to move window size left on vsplit
nmap <Leader>. :15winc><CR> " \> to move window size right on vsplit
nmap <Leader>- :resize -15<CR>
nmap <Leader>= :resize +15<CR>

" keymap | go
autocmd FileType go nnoremap <buffer> <silent> <C-w><C-m> :<C-u>call go#def#Jump("split", 0)<CR>
autocmd FileType go nnoremap <buffer> <silent> <C-w><C-]> :<C-u>call go#def#Jump("split", 0)<CR>
autocmd FileType go nnoremap <buffer> <silent> <C-w>] :<C-u>call go#def#Jump("split", 0)<CR>
autocmd FileType go nnoremap <buffer> <silent> <C-t> :<C-U>call go#def#StackPop(v:count1)<cr>
autocmd FileType go nnoremap <Leader>gd :GoDef<CR>
autocmd FileType go nnoremap <Leader>gy :GoDefType<CR>
autocmd FileType go nnoremap <Leader>gi :GoDoc<CR>
autocmd FileType go nnoremap <Leader>ga :GoAlternate<CR>" show test file
autocmd FileType go nnoremap <Leader>gr :GoReferrers<CR>" references to symbol
autocmd FileType go nnoremap <Leader>gn :GoRename<CR>
autocmd FileType go nnoremap <Leader>gc :GoCallers<CR>
autocmd FileType go nnoremap <Leader>gt :GoTest<CR>
autocmd FileType go nnoremap <Leader>gf :GoTestFunc<CR>
autocmd FileType go nnoremap <Leader>gg :GoRun<CR>
autocmd FileType go nnoremap <Leader>gs :GoFillStruct<CR>
autocmd FileType go nnoremap <Leader>gv :GoVet<CR>
autocmd FileType go nnoremap <Leader>gV :GoMetaLinter<CR>
autocmd FileType go nnoremap <Leader>gh :GoCoverageToggle<CR>
autocmd FileType go nnoremap <Leader>gl :TestLast<CR>
autocmd FileType go nnoremap <Leader>ife :GoIfErr<CR>kkA
"autocmd FileType go nnoremap <Leader>gh :<C-u>call GOVIMHover()<CR>

" keymap | gitgutter
nnoremap <Leader>Hs :GitGutterStageHunk<CR>
nnoremap <Leader>Hn :GitGutterNextHunk<CR>
nnoremap <Leader>HN :GitGutterPrevHunk<CR>
nnoremap <Leader>Hp :GitGutterPreviewHunk<CR>

" keymap | comment
"noremap <F4> :call CommentLine()<CR>

" macros
let @i="oif err != nil {\<CR>return \<CR>}\<Esc>kA"
let @f="A // FIXME: testing"
let @p="ifmt.Printf(\" -> DEBUG: %s %+v\\n\", ) // FIXME: testing\<Esc>BBBBi\""
let @d="BveyO// \<Esc>pA "

" tabs for go
autocmd FileType go setlocal noexpandtab

" plugins
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'myitcv/govim'
" plugin specific | govim
"call govim#config#Set("ExperimentalProgressPopups", 1)

Plug 'ervandew/ag'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_buffers_jump = 1

Plug 'tpope/vim-fugitive'
Plug '907th/vim-auto-save'
Plug 'jstemmer/gotags'
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

Plug 'majutsushi/tagbar'
let g:tagbar_width=120

"Plug 'jakedouglas/exuberant-ctags'
Plug 'morhetz/gruvbox'
Plug 'alfredodeza/jacinto.vim'
Plug 'elzr/vim-json'
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

Plug 'bling/vim-bufferline'
let g:bufferline_echo = 0 " dont let bufferline overwrite command line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='term'
let g:airline_section_y = '%-0.25{getcwd()}'
let g:airline_mode_map = {
    \ '__' : '--',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V-L',
    \ '' : 'V-B',
    \ 's'  : 'S',
    \ 'S'  : 'S-L',
    \ '' : 'S-B',
    \ 't'  : 'T',
    \ }

Plug 'dense-analysis/ale'
Plug 'mbbill/undotree'
"Plug 'ervandew/supertab'

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
let g:NERDTreeWinSize=70
"let g:nerdtree_tabs_open_on_console_startup = 1
"let g:nerdtree_tabs_autofind = 1
"let g:nerdtree_tabs_focus_on_files = 1

Plug 'vim-test/vim-test'

call plug#end()

" colorscheme
colorscheme gruvbox
" colorscheme everforest

" highlight extra whitespace
" keep this at the bottom
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
