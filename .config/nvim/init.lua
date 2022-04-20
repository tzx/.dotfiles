vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.undofile = true
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.inccommand = 'split'
vim.o.laststatus = 3
vim.g.mapleader = ' '

if vim.fn.has('termguicolors') == 1 then
    vim.o.termguicolors = true
end

vim.g.gruvbox_material_background = "hard"
vim.o.background = "dark"
-- vim.cmd([[ colorscheme gruvbox-material ]])

require('packages')
