return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
    keys = {
      { '<C-p>', "<cmd>FzfLua files<cr>", desc = "find files" },
      { '<leader>g', "<cmd>FzfLua live_grep<cr>", desc = "live grep" },
      { '<leader>b', "<cmd>FzfLua buffers<cr>", desc = "buffers" },
      { '<leader>B', "<cmd>FzfLua builtin<cr>", desc = "builtin" },
    },
  }
}
