return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    keys = {
      { '<C-p>', "<cmd>Telescope find_files<cr>", desc = "find files" },
      { '<leader>g', "<cmd>Telescope live_grep<cr>", desc = "live grep" },
      { '<leader>b', "<cmd>Telescope buffers<cr>", desc = "buffers" },
    },
  }
}
