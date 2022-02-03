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
set splitright
set timeoutlen=350 ttimeoutlen=0 " ms to wait before waiting for extra keys
set shortmess-=S " show count when searching
set shortmess+=c
set scrolloff=5
set visualbell
set history=10000
set wildignorecase
set number relativenumber
set hidden " allow navigating away from unsaved buffers
set completeopt=menuone,menu,longest,preview
set wildmenu
set wildmode=longest,list,full
set mouse=a

" allow backspace to delete indentation and inserted text
set backspace=indent,eol,start

" remap leader
let mapleader = "\<Space>"

" remember my buffers
exec 'set viminfo=%,' . &viminfo

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

" better window naming
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))

" syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on

" nvim terminal
tnoremap <Esc> <C-\><C-n>

" plugins
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
let g:startify_bookmarks = [ {'v': '~/.vimrc'}, {'z': '~/.zshrc'} ]
let g:startify_enable_special = 0
let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'files',     'header': ['   MRU']            },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]

Plug 'liuchengxu/vim-which-key'
nnoremap <silent> <Leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <Leader> :WhichKeyVisual '<Space>'<CR>

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_buffers_jump = 1
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

Plug 'majutsushi/tagbar'
let g:tagbar_width=120
let g:tagbar_position='topleft vertical'

Plug 'yuttie/comfortable-motion.vim'

Plug 'haya14busa/incsearch.vim'
let g:incsearch#auto_nohlsearch = 1

Plug 'tpope/vim-commentary'
nnoremap <Leader>/ :Commentary<CR><Esc>
vnoremap <Leader>/ :Commentary<CR><Esc>

Plug 'machakann/vim-highlightedyank' "highlight what you yank

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_metalinter_command = 'staticcheck'
let g:go_debug_log_output = ''
let g:go_doc_popup_window = 1
let g:go_term_enabled=0
let g:go_term_reuse = 1
let g:go_term_close_on_exit = 0
let g:go_term_mode="split"
let g:go_metalinter_autosave=0
let g:go_code_completion_icase = 1
let g:go_gopls_use_placeholders = "gopls"
let g:go_auto_type_info=0 " auto show signature
"let g:go_auto_sameids = 1
"let g:go_list_height = 25

" Plug 'mattesgroeger/vim-bookmarks' " why doesn't it like ... work?
" let g:bookmark_save_per_working_dir = 1
" let g:bookmark_no_default_key_mappings = 1
" let g:bookmark_highlight_lines = 1
" let g:bookmark_show_warning = 0
" let g:bookmark_show_toggle_warning = 0
" let g:bookmark_disable_ctrlp = 1

Plug 'andrewradev/simple_bookmarks.vim'
let g:simple_bookmarks_signs = 1
nnoremap <Leader>ma :Bookmark 
nnoremap <Leader>md :CopenBookmarks<CR> :DelBookmark 
nnoremap <Leader>mm :CopenBookmarks<CR> 

Plug 'nvim-lua/plenary.nvim'

" Plug 'ThePrimeagen/harpoon'
" nmap <Leader>ma :lua require("harpoon.mark").add_file()<CR>
" nmap <Leader>mm :lua require("harpoon.ui").toggle_quick_menu()<CR>

Plug 'phaazon/hop.nvim'

Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim' "use :GBrowse to open files in gitlab

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='xtermlight'
"let g:airline_theme='term'
"let g:airline_theme='luna'
"let g:airline_theme='base16_heetch'
"let g:airline_statusline_ontop=1

Plug 'dense-analysis/ale'
Plug 'mbbill/undotree'

Plug 'scrooloose/nerdtree'
let g:NERDTreeWinSize=70
let NERDTreeQuitOnOpen=1

Plug 'vim-test/vim-test'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<F5>'
" let g:UltiSnipsJumpForwardTrigger='<c-j>'
" let g:UltiSnipsJumpBackwardTrigger='<c-k>'

Plug 'puremourning/vimspector'

Plug 'jeetsukumaran/vim-buffergator'
let g:buffergator_suppress_keymaps = 1
let g:buffergator_sort_regime = "mru"
let g:buffergator_show_full_directory_path = 0
let g:buffergator_vsplit_size = 120
let g:buffergator_viewport_split_policy = "R"

Plug 'neoclide/coc.nvim'
" fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

Plug 'skywind3000/vim-terminal-help'
let g:terminal_key = "<c-h>"
let g:terminal_height = 40
let g:terminal_pos = "topleft"
let g:terminal_close = 1
let g:terminal_cwd = 0
let g:terminal_list = 0 " hide terminal in buffers list
Plug 'skywind3000/asyncrun.vim'
" Plug 'mhinz/neovim-remote'

Plug 'szw/vim-maximizer'

Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0

"Plug 'nvim-lua/popup.nvim'

"Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzf-native.nvim'

" Plug 'tpope/vim-dadbod'
" let g:ts = 'postgresql://localhost:5432/external-timescale?user=speedscale&password=079d9b7096130966a090'
"Plug 'kristijanhusak/vim-dadbod-completion'

" colorscheme
" Plug 'ray-x/aurora'
set termguicolors
" colorscheme aurora
" source ~/.vim/plugged/aurora/colors/aurora.vim
" Plug 'drewtempelmeyer/palenight.vim'
" source ~/.vim/plugged/palenight.vim/colors/palenight.vim
" colorscheme palenight
source ~/.vim/plugged/gruvbox/colors/gruvbox.vim
" colorscheme gruvbox

call plug#end()

" keymap | general
" make saving easier
nnoremap <Leader>w :w<CR>
" this piece of trash needs to die
map Q <Nop>
" don't add c operations to register
nnoremap c "0c

inoremap <C-@> <C-x><C-o>
nnoremap <Leader>o :only<CR>:noh<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <Leader>p :Files<CR>
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
nnoremap <Leader><Esc> <C-W><C-P>

" keymap | edit
nnoremap <Leader>ew :e %:p:h
nnoremap <Leader>es :sp %:p:h
nnoremap <Leader>ev :vsp %:p:h

" keymap | buffers
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bb :e#<CR>
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bD :bd!<CR>
nnoremap <Leader><Space> :e#<CR>" switch to last buffer

" keymap | tabs
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tf :tabfind
nnoremap <Leader>th :tabprev<CR>
nnoremap <Leader>tl :tabnext<CR>
nnoremap <Leader>tq :tabclose<CR>

" " keymap | location list
" disabled to use for CocNext
" nmap <C-j> :cnext<CR>zt
" nmap <C-k> :cprev<CR>zt

" keymap | focus
nnoremap <Leader>fn :NERDTreeFind<CR>
" only open windows
nnoremap <Leader>fw :Windows<CR>
" all buffers
nnoremap <Leader>ff :BuffergatorOpen<CR>
nnoremap <Leader>ft :TagbarOpenAutoClose<CR>
nnoremap <Leader>fT :TagbarOpen<CR>
nnoremap <Leader>fm :MaximizerToggle!<CR>
nnoremap <Leader>fr :Startify<CR>
nnoremap <Leader>fa :Ag 
" yank current word and paste into Ag
nnoremap <Leader>fA yiw:Ag <C-r>"<CR>
nnoremap <Leader>fF :Ag FIXME: \(JMT\)<CR>

" keymap | run
nnoremap <Leader>rt :AsyncRun -mode=term -thelp 
nnoremap <Leader>rr :AsyncRun -mode=term -thelp<Up><CR>
nnoremap <Leader>rj V:!jq<CR>
vnoremap <Leader>rj :!jq<CR>

" keymap | resize
nmap <Leader>, :10winc<<CR>
nmap <Leader>< :35winc<<CR>
nmap <Leader>. :10winc><CR>
nmap <Leader>> :35winc><CR>
nmap <Leader>- :resize -15<CR>
nmap <Leader>+ :resize +15<CR>

" keymap | incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)

" keymap | navigation
nnoremap <silent><nowait> <Leader>a  :<C-u>CocList diagnostics<cr>
" find symbols in the current document
nnoremap <silent><nowait> <space>s  :<C-u>CocList outline<cr>
" find symbols in the workspace
nnoremap <silent><nowait> <Leader>S  :<C-u>CocList -I symbols<cr>
nmap <Leader>gu <Plug>(coc-implementation)
autocmd FileType go nnoremap <Leader>gd :GoDef<CR>
nmap <Leader>gd <Plug>(coc-definition)
nmap <Leader>gy <Plug>(coc-type-definition)
nmap <Leader>gY :vsp<CR><Plug>(coc-type-definition)
" nmap <Leader>gR <Plug>(coc-references)
nmap <Leader>gr <Plug>(coc-references-used)
nmap <Leader>gR :call CocAction('jumpReferences')<CR>
nmap <C-k> :CocPrev<CR>
nmap <C-j> :CocNext<CR>
nmap <Leader>gn <Plug>(coc-rename)
autocmd FileType go nnoremap <Leader>gD :vsp<CR>:GoDef<CR>
autocmd FileType go nnoremap <Leader>gS :sp<CR>:GoDef<CR>
autocmd FileType go nnoremap <Leader>gp :GoDefPop<CR>
autocmd FileType go nnoremap <Leader>gi :GoDoc<CR>
nmap <Leader>gi :call CocActionAsync('doHover')<CR>
autocmd FileType go nnoremap <Leader>gI :GoSameIds<CR>
autocmd FileType go nnoremap <Leader>gII :GoSameIdsClear<CR>
autocmd FileType go nnoremap <Leader>ga :GoAlternate!<CR>
autocmd FileType go nnoremap <Leader>gc :GoMetaLinter<CR>
autocmd FileType go nnoremap <Leader>gt :TestSuite<CR>
autocmd FileType go nnoremap <Leader>gf :TestNearest<CR>
autocmd FileType go nnoremap <Leader>gg :GoRun<CR>
autocmd FileType go nnoremap <Leader>gs :GoFillStruct<CR>
autocmd FileType go nnoremap <Leader>gv :GoVet<CR>
autocmd FileType go nnoremap <Leader>gV :GoMetaLinter<CR>
autocmd FileType go nnoremap <Leader>gh :GoCoverageToggle<CR>
autocmd FileType go nnoremap <Leader>gl :TestLast<CR>
nnoremap <Leader>dd :call vimspector#Launch()<CR>
autocmd FileType go nnoremap <Leader>dt :GoDebugTest<CR>
autocmd FileType go nnoremap <Leader>df :GoDebugTestFunc<CR>
nnoremap <Leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>d<space> :call vimspector#Continue()<CR>
nnoremap <Leader>do :call vimspector#StepOut()<CR>
nnoremap <Leader>dn :call vimspector#StepOver()<CR>
nnoremap <Leader>di :call vimspector#StepInto()<CR>
nnoremap <Leader>dh :call vimspector#RunToCursor()<CR>
autocmd FileType go nnoremap <Leader>dp :GoDebugPrint 
nnoremap <Leader>dq :call vimspector#Reset()<CR>
nnoremap <Leader>dr :call vimspector#Restart()<CR>

" keymap | git changes
nnoremap <Leader>cs :GitGutterStageHunk<CR>
nnoremap <Leader>cc :GitGutterNextHunk<CR>
nnoremap <Leader>cd :Gvdiffsplit<CR>
nnoremap <Leader>co :Gvsplit<CR>
nnoremap <Leader>cu :GitGutterUndoHunk<CR>
" see current file changes master
nnoremap <Leader>cm :Gdiffsplit origin/master<CR>

" keymap | coc
nnoremap <Leader>cr :CocListResume<CR>
nnoremap <Leader>cn :CocNext<CR>
nnoremap <Leader>cN :CocPrev<CR>

" macros
let @i="oif err != nil {\<CR>return\<CR>}\<Esc>kA fmt.Errorf(\": %w\", err)\<Esc>BBhhi"
let @f="A // FIXME: (JMT) testing"
let @p="ifmt.Printf(\" -> JMTDEBUG: %s: %+v\\n\", ) // FIXME: (JMT) testing\<Esc>BBBBBi\""
let @d="lBveyO// \<Esc>pA "

" tabs for go
autocmd FileType go setlocal noexpandtab

" highlight extra whitespace
" keep this at the bottom
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

nmap <Leader>dI <Plug>VimspectorBalloonEval
xmap <Leader>dI <Plug>VimspectorBalloonEval
nmap <Leader>dc <Plug>VimspectorToggleConditionalBreakpoint


