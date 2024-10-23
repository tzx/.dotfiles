return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
        dim_inactive = {
          enabled = true,
        }
      },
      color_overrides = {
        mocha = {
          base = "#262626",
          mantle = "#262626",
          crust = "#262626",
        }
      }
    },
  },
  -- Keeping this commented, because I still like it :)
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function(_, _)
      -- vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "original"
    end,
  }
}
