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
" ms to wait before waiting for extra keys
set timeoutlen=750 ttimeoutlen=0
set shortmess-=S " show count when searching
set scrolloff=3
set visualbell
set history=10000
set wildignorecase
set number relativenumber
set hidden " allow navigating away from unsaved buffers
"set autochdir " will determine whether we should always use dir of the current file
"for nvim
set completeopt=menuone,menu,longest,preview
" for vim
"set completeopt=menuone,menu,longest,popup
set wildmenu
set wildmode=longest,list,full

" allow backspace to delete indentation and inserted text
set backspace=indent,eol,start

" remember my buffers
exec 'set viminfo=%,' . &viminfo

" nvim terminal
tnoremap <Esc> <C-\><C-n>

" remember line position
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" syntax highlighting for things that might have large data
set maxmempattern=1048576

" properly handle colors in tmux
"set background=light
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
let g:go_metalinter_autosave=0
let g:go_code_completion_icase = 1
"let g:go_auto_sameids = 1
"let g:go_list_height = 25
let g:go_gopls_use_placeholders = "gopls"

" remap leader
let mapleader = "\<Space>"

" keymap | general
" this piece of trash needs to die
map Q <Nop>
inoremap <C-@> <C-x><C-o>
nnoremap <Leader><Esc> :noh<CR>
nnoremap <Leader>9 :only<CR>
nnoremap <Leader>1 :q<CR>
nnoremap <Leader>! :q!<CR>
"nnoremap <Leader>p :Telescope find_files<CR>
nnoremap <Leader>p :FZF<CR>
" make saving easier
nnoremap <Leader>w :w<CR>
nnoremap <Leader>v <C-v>
"make Y copy to the end of the line
nnoremap Y y$
" searching should keep the cursor in the same place
"nnoremap n nzt
"nnoremap N Nzt
" undo break points..don't undo every damn thing from last insert
inoremap , ,<c-g>u
inoremap = =<c-g>u
inoremap , ,<c-g>u
inoremap . .<c-g>u
"duplicate (copy) blocks of text
nnoremap <Leader>cb Va}:t'><CR>

nnoremap <Leader>h <C-W>h
nnoremap <Leader>j <C-W>j
nnoremap <Leader>k <C-W>k
nnoremap <Leader>l <C-W>l

nnoremap <Leader>o <C-o>
nnoremap <Leader>i <C-i>

" keymap | edit
nnoremap <Leader>ew :e %:p:h

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
nmap <C-j> :lnext<CR>zt
nmap <C-k> :lprev<CR>zt

" keymap | focus
nnoremap <Leader>fn :NERDTreeTabsOpen<CR>:NERDTreeFocus<CR>
nnoremap <Leader>ff :files<CR>
nnoremap <Leader>fb :BuffergatorOpen<CR>
nnoremap <Leader>ft :TagbarOpenAutoClose<CR>
nnoremap <Leader>fT :TagbarOpen<CR>
nnoremap <Leader>fm :MaximizerToggle<CR>

" keymap | lists
nmap <Leader>cc :cclose<CR>:lclose<CR>
nnoremap <Leader>cn :NERDTreeTabsClose<CR>

" keymap | resize
nmap <Leader>, :10winc<<CR> " \< to move window size left on vsplit
nmap <Leader>. :10winc><CR> " \> to move window size right on vsplit
nmap <Leader>- :resize -15<CR>
nmap <Leader>= :resize +15<CR>

" keymap | go
autocmd FileType go nnoremap <buffer> <silent> <C-w><C-m> :<C-u>call go#def#Jump("split", 0)<CR>
autocmd FileType go nnoremap <buffer> <silent> <C-w><C-]> :<C-u>call go#def#Jump("split", 0)<CR>
autocmd FileType go nnoremap <buffer> <silent> <C-w>] :<C-u>call go#def#Jump("split", 0)<CR>
autocmd FileType go nnoremap <buffer> <silent> <C-t> :<C-U>call go#def#StackPop(v:count1)<cr>
autocmd FileType go nnoremap <Leader>gu :GoImplements<CR>
autocmd FileType go nnoremap <Leader>gd :GoDef<CR>
autocmd FileType go nnoremap <Leader>gp :GoDefPop<CR>
autocmd FileType go nnoremap <Leader>gy :GoDefType<CR>
autocmd FileType go nnoremap <Leader>gi :GoDoc<CR>
autocmd FileType go nnoremap <Leader>ga :GoAlternate!<CR>
autocmd FileType go nnoremap <Leader>gr :GoReferrers<CR>
autocmd FileType go nnoremap <Leader>gn :GoRename<CR>
autocmd FileType go nnoremap <Leader>gc :GoMetaLinter<CR>
autocmd FileType go nnoremap <Leader>gt :TestSuite<CR>
autocmd FileType go nnoremap <Leader>gf :TestNearest<CR>
autocmd FileType go nnoremap <Leader>gg :GoRun<CR>
autocmd FileType go nnoremap <Leader>gs :GoFillStruct<CR>
autocmd FileType go nnoremap <Leader>gv :GoVet<CR>
autocmd FileType go nnoremap <Leader>gV :GoMetaLinter<CR>
autocmd FileType go nnoremap <Leader>gh :GoCoverageToggle<CR>
autocmd FileType go nnoremap <Leader>gl :TestLast<CR>
autocmd FileType go nnoremap <Leader>dd :GoDebugStart<CR>
autocmd FileType go nnoremap <Leader>dt :GoDebugTest<CR>
autocmd FileType go nnoremap <Leader>df :GoDebugTestFunc<CR>
autocmd FileType go nnoremap <Leader>db :GoDebugBreakpoint<CR>
autocmd FileType go nnoremap <Leader>dc :GoDebugContinue<CR>
autocmd FileType go nnoremap <Leader>dr :GoDebugRestart<CR>
autocmd FileType go nnoremap <Leader>do :GoDebugStepOut<CR>
autocmd FileType go nnoremap <Leader>dn :GoDebugNext<CR>
autocmd FileType go nnoremap <Leader>ds :GoDebugStep<CR>
autocmd FileType go nnoremap <Leader>dp :GoDebugPrint 
autocmd FileType go nnoremap <Leader>dq :GoDebugStop<CR>
"autocmd FileType go nnoremap <Leader>gh :<C-u>call GOVIMHover()<CR>

" keymap | gitgutter
nnoremap <Leader>Hs :GitGutterStageHunk<CR>
nnoremap <Leader>Hn :GitGutterNextHunk<CR>
nnoremap <Leader>HN :GitGutterPrevHunk<CR>
nnoremap <Leader>Hp :GitGutterPreviewHunk<CR>
nnoremap <Leader>Hu :GitGutterUndoHunk<CR>

" keymap | commentary
nnoremap <F4> :Commentary<CR><Esc>
vnoremap <F4> :Commentary<CR><Esc>

" macros
let @i="oif err != nil {\<CR>return\<CR>}\<Esc>kA fmt.Errorf(\" :%w\", err)\<Esc>BBhi"
let @f="A // FIXME: (JMT) testing"
let @p="ifmt.Printf(\" -> DEBUG: %s %+v\\n\", ) // FIXME: (JMT) testing\<Esc>BBBBBi\""
let @d="BveyO// \<Esc>pA "

" tabs for go
autocmd FileType go setlocal noexpandtab

" plugins
call plug#begin('~/.vim/plugged')

Plug 'jeetsukumaran/vim-buffergator'
let g:buffergator_sort_regime = "mru"
let g:buffergator_show_full_directory_path = 0
let g:buffergator_vsplit_size = 120
let g:buffergator_viewport_split_policy = "R"
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
"Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'ray-x/lsp_signature.nvim'
Plug 'mhinz/neovim-remote'
Plug 'skywind3000/vim-terminal-help'
let g:terminal_key = "<c-h>"
let g:terminal_height = 30
let g:terminal_pos = "topleft"
let g:terminal_close = 1
let g:terminal_cwd = 0
" hide terminal in buffers list
let g:terminal_list = 0
Plug 'skywind3000/asyncrun.vim'
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced = 1
Plug 'szw/vim-maximizer'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0

"Plug 'puremourning/vimspector'"for debugging across languages. needs setup help.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_metalinter_command = 'staticcheck'
let g:go_debug_log_output = ''
let g:go_doc_popup_window = 1
"Plug 'myitcv/govim'
"call govim#config#Set("ExperimentalProgressPopups", 1)

Plug 'ervandew/ag'

"Plug 'nvim-lua/popup.nvim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzf-native.nvim'
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
"Plug 'elzr/vim-json'
"au! BufRead,BufNewFile *.json set filetype=json
"augroup json_autocmd
"  autocmd!
"  autocmd FileType json set autoindent
"  autocmd FileType json set formatoptions=tcq2l
"  autocmd FileType json set textwidth=78 shiftwidth=2
"  autocmd FileType json set softtabstop=2 tabstop=8
"  autocmd FileType json set expandtab
"  autocmd FileType json set foldmethod=syntax
"augroup END

Plug 'bling/vim-bufferline'
let g:bufferline_echo = 0 " dont let bufferline overwrite command line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"let g:airline_theme='term'
let g:airline_theme='xtermlight'
"let g:airline_theme='luna'
"let g:airline_theme='base16_heetch'
let g:airline_section_y = '%-0.15{getcwd()}'
"let g:airline_mode_map = {
"    \ '__' : '--',
"    \ 'n'  : 'N',
"    \ 'i'  : 'I',
"    \ 'R'  : 'R',
"    \ 'c'  : 'C',
"    \ 'v'  : 'V',
"    \ 'V'  : 'V-L',
"    \ '' : 'V-B',
"    \ 's'  : 'S',
"    \ 'S'  : 'S-L',
"    \ '' : 'S-B',
"    \ 't'  : 'T',
"    \ }

"Plug 'dense-analysis/ale'
Plug 'mbbill/undotree'
"Plug 'ervandew/supertab'

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
let g:NERDTreeWinSize=70
"let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_autofind = 1
"let g:nerdtree_tabs_focus_on_files = 1

Plug 'vim-test/vim-test'
Plug 'SirVer/ultisnips'

call plug#end()

" colorscheme
colorscheme gruvbox
" colorscheme everforest

" highlight extra whitespace
" keep this at the bottom
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
