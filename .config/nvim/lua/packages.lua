local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'sainnhe/gruvbox-material',
    config = function()
      if vim.fn.has('termguicolors') == 1 then
          vim.o.termguicolors = true
      end
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.cmd([[ colorscheme gruvbox-material ]])
    end,
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
      'hrsh7th/cmp-nvim-lsp-signature-help',
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
    'simrat39/rust-tools.nvim',
    -- https://github.com/LunarVim/LunarVim/issues/2012 lol?
    -- don't use ft I guess....
    -- ft = { 'rust' },
    -- config = function()
    --   require('rust-tools').setup({})
    -- end,
  }

  use {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
      })
      require("lsp_lines").setup()
    end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
