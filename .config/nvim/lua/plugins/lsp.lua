-- From kickstart
local setup_auto_completion = function()
  -- Switch for controlling whether you want autoformatting.
  --  Use :KickstartFormatToggle to toggle autoformatting on or off
  local format_is_enabled = true
  vim.api.nvim_create_user_command('AutoFormatToggle', function()
    format_is_enabled = not format_is_enabled
    print('Setting autoformatting to: ' .. tostring(format_is_enabled))
  end, {})

  -- Create an augroup that is used for managing our formatting autocmds.
  --      We need one augroup per client to make sure that multiple clients
  --      can attach to the same buffer without interfering with each other.
  local _augroups = {}
  local get_augroup = function(client)
    if not _augroups[client.id] then
      local group_name = 'kickstart-lsp-format-' .. client.name
      local id = vim.api.nvim_create_augroup(group_name, { clear = true })
      _augroups[client.id] = id
    end

    return _augroups[client.id]
  end

  -- Whenever an LSP attaches to a buffer, we will run this function.
  --
  -- See `:help LspAttach` for more information about this autocmd event.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
    -- This is where we attach the autoformatting for reasonable clients
    callback = function(args)
      local client_id = args.data.client_id
      local client = vim.lsp.get_client_by_id(client_id)
      local bufnr = args.buf

      -- Only attach to clients that support document formatting
      if not client.server_capabilities.documentFormattingProvider then
        return
      end

      -- Tsserver usually works poorly. Sorry you work with bad languages
      -- You can remove this line if you know what you're doing :)
      if client.name == 'tsserver' then
        return
      end

      -- Create an autocmd that will run *before* we save the buffer.
      --  Run the formatting command for the LSP that has just attached.
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = get_augroup(client),
        buffer = bufnr,
        callback = function()
          if not format_is_enabled then
            return
          end

          vim.lsp.buf.format {
            async = false,
            filter = function(c)
              return c.id == client.id
            end,
          }
        end,
      })
    end,
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "SmiteshP/nvim-navic",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      diagnostics = {
        underline = true,
        signs = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
          vim.inspect(vim.lsp.buf.list_workspace_folders())
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
        vim.keymap.set('n', '<leader>sl', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, opts)
        vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']e', vim.diagnostic.goto_next, opts)
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function() vim.lsp.buf.format { async = true } end, {})
      end,
      servers = {
        'tsserver',
        'clangd',
        'zls',
        'gopls',
      },
    },
    config = function(plugin, opts)
      vim.diagnostic.config(opts.diagnostics)
      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      setup_auto_completion()
      for _, server in ipairs(servers) do
        local server_opts = {}
        server_opts.capabilities = capabilities
        server_opts.on_attach = opts.on_attach
        require("lspconfig")[server].setup(server_opts)
      end

      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup {
        capabilities = capabilities,
        on_attach = opts.on_attach,
        root_dir = lspconfig.util.root_pattern('pyproject.toml', 'pyrightconfig.json', '.git'),
      }


      -- TODO: SPECIFIC SERVER CONFIGS IN OPTS
      require("lspconfig").elixirls.setup {
        capabilities = capabilities,
        on_attach = opts.on_attach,
        cmd = { "elixir-ls" },
      }
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    dependencies = { 
    },
    version = '^4', -- Recommended
    lazy = false,
    ft = { 'rust' },
    config = function(_, _) 
      setup_auto_completion()

      vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
      },
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
          -- you can also put keymaps in here
          -- TODO: I don't really care about nice config, just copy paste
          local opts = { buffer = bufnr }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wl', function()
            vim.inspect(vim.lsp.buf.list_workspace_folders())
          end, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>ca', function() vim.cmd.RustLsp('codeAction') end, opts)
          vim.keymap.set('v', '<leader>ca', function() vim.cmd.RustLsp('codeAction') end, opts)
          vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
          vim.keymap.set('n', '<leader>sl', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, opts)
          vim.api.nvim_buf_create_user_command(bufnr, "Format", function() vim.lsp.buf.format { async = true } end, {})
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
              local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
              }
              vim.diagnostic.open_float(nil, opts)
            end
          })
        end,
        settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
          },
        },
      },
      -- DAP configuration
      dap = {
      },
    }
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    --event = "VeryLazy",
    opts = {},
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },

  {
    "SmiteshP/nvim-navic",
    opts = {
      lsp = {
        auto_attach = true,
      },
    },
    dependencies = { 
      "neovim/nvim-lspconfig",
    },
  },
}
