local nvim_lsp = require 'lspconfig'

-- vim.diagnostic.config({ update_in_insert  = true })

-- vim.lsp.set_log_level('trace')

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<cr>", opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', '<cmd>Lspsaga signature_help', opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>Lspsaga lsp_finder<cr>', opts)
  vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
  vim.keymap.set('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', opts)
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function() vim.lsp.buf.format { async = true } end, {})
end

local function make_config(override)
  return vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  }, override or {})
end

local servers = { 
  'pylsp',
  'rust_analyzer',
  'tsserver',
  'clangd',
}

nvim_lsp["pylsp"].setup(make_config())

require("rust-tools").setup({
  server = make_config()
  }
)
-- nvim_lsp["rust_analyzer"].setup(make_config())

nvim_lsp["tsserver"].setup(make_config({
  settings = {
    completions = { completeFunctionCalls = true },
  }
}))

nvim_lsp["clangd"].setup(make_config())
