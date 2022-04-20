local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'sainnhe/gruvbox-material',
    config = function() vim.cmd([[ colorscheme gruvbox-material ]]) end,
  }

  use { 
    'nvim-telescope/telescope.nvim', 
    requires = { 'nvim-lua/plenary.nvim' },
    config = [[ require('plugins.telescope') ]]
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = [[ require('plugins.treesitter') ]],
  }

  use {
    'neovim/nvim-lspconfig', 
    config = [[ require('plugins.lspconfig') ]]
  }

  use { 
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = [[ require('plugins.cmp') ]]
  }

  use {
    'folke/which-key.nvim',
    config = function() require('which-key').setup() end, 
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = [[ require('plugins.lualine') ]],
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = [[ require('plugins.indent-blankline') ]]
  }

  use {
    'whonore/Coqtail',
    ft = { 'coq' },
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
