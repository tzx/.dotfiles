local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
  }
})
