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
  }
  -- Keeping this commented, because I still like it :)
  -- { 
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   config = function(_, _)
  --     if vim.fn.has('termguicolors') == 1 then
  --         vim.o.termguicolors = true
  --     end
  --     vim.o.background = "dark"
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
  --     vim.cmd([[ colorscheme gruvbox-material ]])
  --   end,
  -- }
}
