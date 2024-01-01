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

vim.o.list = true
vim.opt.listchars:append({ eol = '↲' })

vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')
vim.keymap.set({'n', 'v'}, '<leader>d', '"_d')
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")

--require('packages')
require('config.lazy')
