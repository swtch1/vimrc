local vim = vim
local cmd = vim.cmd
local call = vim.call
local fn = vim.fn

-- install vim-plug if it's not installed
local plugFile = io.open('~/.nvim/autoload/plug.vim', 'w')
if plugFile~=nil then
    local http = require('socket.http')
    local body = http.request('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    plugFile:write(body)
    local autoCommand = { auto_install_plugs = {{"VimEnter", "*", "PlugInstall --sync | source $MYVIMRC"}}}
    require ('autocmd').nvim_create_augroups(autoCommand)
    io.close(plugFile)
end

-- Plugins
local Plug = fn['plug#']

call('plug#begin', '~/.nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vim-which-key'
-- Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'

call('plug#end')
