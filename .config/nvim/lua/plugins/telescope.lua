vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>g', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
