return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    config = function(_, _)
      if vim.fn.has('termguicolors') == 1 then
          vim.o.termguicolors = true
      end
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.cmd([[ colorscheme gruvbox-material ]])
    end,
  }
}
