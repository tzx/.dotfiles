vim.pack.add({
  "https://github.com/sainnhe/gruvbox-material",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-mini/mini.statusline",
  "https://github.com/nvim-mini/mini.tabline",
  "https://github.com/nvim-mini/mini.indentscope",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/linrongbin16/gitlinker.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/neovim/nvim-lspconfig",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.0") },
})


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

vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "original"
vim.cmd.colorscheme "gruvbox-material"


require("mini.statusline").setup({})
require("mini.tabline").setup({})
require("mini.indentscope").setup({})
require("fidget").setup({})

local fzf = require("fzf-lua")
vim.keymap.set("n", "<C-p>", fzf.files)
vim.keymap.set("n", "<leader>g", fzf.live_grep)
vim.keymap.set("n", "<leader>b", fzf.buffers)
vim.keymap.set("n", "<leader>B", fzf.builtin)

require("which-key").setup({})
require("gitsigns").setup({
  current_line_blame = true,
})
require("gitlinker").setup({})

require("nvim-treesitter").setup({
  highlight = {
    enable = true,
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        af = "@function.outer",
        ["if"] = "@function.inner",
        ac = "@class.outer",
        ic = "@class.inner",
      },
    },
  },
})

require('blink.cmp').setup({})

-- LSP
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>sl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", opts)
  vim.keymap.set("n", "<leader>so", "<cmd>FzfLua lsp_document_symbols<cr>", opts)
  vim.keymap.set("n", "<leader>h", function()
    vim.lsp.inlay_hint.enable(
      not vim.lsp.inlay_hint.is_enabled()
    )
  end, opts)
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
    vim.lsp.buf.format({ async = true })
  end, {})
end

local lspconfig = require("lspconfig")

local gopackagesdriver_path = "../tools/gopackagesdriver.sh"
local gopls_settings = {
  directoryFilters = {
    "-.bazel",
    "-bazel-bin",
    "-bazel-out",
    "-bazel-testlogs",
    "-bazel-com_github_askscio_scio",
  },
}
if vim.fn.filereadable(gopackagesdriver_path) == 1 then
  gopls_settings.env = {
    GOPACKAGESDRIVER = gopackagesdriver_path,
  }
end
vim.lsp.config("gopls", {
  on_attach = on_attach,
  settings = {
    gopls = gopls_settings,
  },
})
vim.lsp.enable("gopls")

vim.lsp.config("basedpyright", {
  on_attach = on_attach,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    -- TIL: https://help.interfaceware.com/v6/lua-magic-characters; I need %
    if fname:find("bazel%-out") then
      return
    end
    local root = vim.fs.root(fname, {
      "pyproject.toml",
      "pyrightconfig.json",
      ".git",
    })
    if root then
      on_dir(root)
    end
  end,
})
vim.lsp.enable("basedpyright")
