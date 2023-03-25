return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "glepnir/lspsaga.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "simrat39/rust-tools.nvim",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      on_attach = function(_, bufnr)
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
        vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function() vim.lsp.buf.format { async = true } end, {})
      end,
      servers = {
        'pylsp',
        'tsserver',
        'clangd',
      },
    },
    config = function(plugin, opts)
      vim.diagnostic.config(opts.diagnostics)
      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      for _, server in ipairs(servers) do
        local server_opts = {}
        server_opts.capabilities = capabilities
        server_opts.on_attach = opts.on_attach
        require("lspconfig")[server].setup(server_opts)
      end
      -- TODO: SPECIFIC SERVER CONFIGS IN OPTS
      require("lspconfig").elixirls.setup {
        capabilities = capabilities,
        on_attach = opts.on_attach,
        cmd = { "elixir-ls" },
      }
      require("rust-tools").setup {
        server = {
          on_attach = opts.on_attach,
        },
      }
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"}
    }
  },
}
