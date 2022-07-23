local vim = vim
local lsp_installer = require("nvim-lsp-installer")
local cmp_lsp = require('cmp_nvim_lsp')
local lsp_installer_servers = require'nvim-lsp-installer.servers'

-- Provide settings first!
lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end


    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', '<leader>gD', ':vsp<CR><Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>gS', ':sp<CR><Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>gp', '<C-T>', opts)
    buf_set_keymap('n', '<leader>gA', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>gi', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>gu', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>Wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>Wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>Wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<leader>gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<leader>a', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)


end


local requestedLSPServers = {
    gopls = {
        cmd = {"gopls", "serve"},
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              unusedvariable = true,
	      fieldalignment = true,
	      nilness = true,
	      unusedwrite = true,
              SA1000,
              SA1002,
              SA1011,
              SA1013,
              SA1014,
              SA1019,
              SA1020,
              SA1023,
              SA1025,
              SA1028,
              SA2000,
              SA2002,
              SA2003,
              SA3000,
              SA4001,
              SA4004,
              SA4005,
              SA4006,
              SA4008,
              SA4009,
              SA4010,
              SA4011,
              SA4012,
              SA4013,
              SA4014,
              SA4020,
              SA4022,
              SA4023,
              SA4024,
              SA4027,
              SA5000,
              SA5001,
              SA5003,
              SA5004,
              SA5005,
              SA5007,
              SA5008,
              SA5009,
              SA5010,
              SA5011,
              SA5012,
              SA6000,
              SA6001,
              SA6002,
              SA6005,
              SA9001,
              SA9002,
              SA9005,
              SA9006,
              S1017,
              ST1008,
	      ST1017,
            },
            staticcheck = true,
          },
        },
    },
    dockerls = {},
    bashls = {},
    bashls  = {},
    clangd  = {},
    dockerls  = {},
    jedi_language_server = {},
    jsonls  = {},
    -- pyright = {},
    rust_analyzer  = {},
    solargraph = {},
    sqlls  = {},
    sqls  = {},
    -- sumneko_lua = {},
    tflint = {},
    tsserver = {},
    yamlls  = {},
    zk = {},
}

for lsp, opts in pairs(requestedLSPServers) do
    local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local available, lsp_server = lsp_installer_servers.get_server(lsp)
    opts["on_attach"] = on_attach
    opts["capabilities"] = capabilities
    opts["flags"] = { debounce_text_changes = 150 }
    if available and not lsp_server:is_installed() then
        lsp_server:install()
    end
    lsp_server:on_ready(function()
        lsp_server:setup(opts)
    end)
end
