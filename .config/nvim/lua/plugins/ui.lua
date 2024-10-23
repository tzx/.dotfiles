return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      return {
        options = {
          icons_enabled = false,
          globalstatus = true,
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_c = {
            {
              'filename',
              path = 1,
            },
            {
              function() return '%=' end,
            },
            {
              function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end
                return msg
              end,
              color = { fg = '#ffffff', gui = 'bold' },
            },
          },
        },
        winbar = {
          lualine_c = {
              {
                  "navic",
                  color_correction = nil,
                  navic_opts = nil
              }
          }
        },
        extensions = { "neo-tree" },
      }
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        disable = {
          buftypes = {},
          filetypes = { "TelescopePrompt", "neo-tree" },
        }
      })
    end,
  },

  {
    "stevearc/dressing.nvim",
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    tag = "v4.6.0",
    opts = {
      options = {
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        diagnostics = "nvim_lsp",
        indicator = {
          style = 'underline',
        },
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    branch = "v2.x",
    opts = {
      window = {
        mappings = {
          ["<space>"] = false, --needed because this conflicts with which-key
        },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },

}
