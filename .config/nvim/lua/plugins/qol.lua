return {
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = true,
  },
  {
    'linrongbin16/gitlinker.nvim',
    config = function()
      require('gitlinker').setup()
    end,
  },
}
