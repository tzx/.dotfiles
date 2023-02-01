vim.opt.list = true
vim.cmd [[highlight! IndentBlanklineContextChar guifg=#C678DD gui=bold]]
vim.cmd [[highlight! IndentBlanklineContextSpaceChar guifg=#C678DD gui=bold]]
vim.cmd [[highlight! IndentBlanklineContextStart guibg=#000000 gui=bold,underline]]

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
