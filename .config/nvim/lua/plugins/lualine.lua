require('lualine').setup {
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
}
