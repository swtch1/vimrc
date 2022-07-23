set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" lua
lua require("cmp")
lua require("lsp")
" lua require("plug")
" lua require("setting")
" lua require('plugins.config.lspinstall')

