return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = false,
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
      },
      extensions = { "neo-tree" },
    },
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
    tag = "v3.1.0",
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

  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "MunifTanjim/nui.nvim", lazy = true },

}
