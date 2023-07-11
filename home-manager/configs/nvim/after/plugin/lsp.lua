  local cmp = require'cmp'


  cmp.setup({
    snippet = {
      expand = function(args)
   --     vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      --{ name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })


  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


  -- Setup required lsp servers
  require("mason").setup()
  require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "hls", "jdtls"}
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  require("lspconfig").hls.setup{capabilities = capabilities}
  require("lspconfig").pyright.setup{capabilities = capabilities}

  require("lspconfig").lua_ls.setup{
      settings = {
      Lua = {
          diagnostics = {
              globals = {'vim'},
          }
      }
  },capabilities = capabilities}

  require("lspconfig").rust_analyzer.setup{capabilities = capabilities}
  require("lspconfig").jdtls.setup{capabilities = capabilities}
  require("lspconfig").tsserver.setup{capabilities = capabilities}
  require("lspconfig").gopls.setup{capabilities = capabilities}
  require("lspconfig").nil_ls.setup{capabilities = capabilities}


