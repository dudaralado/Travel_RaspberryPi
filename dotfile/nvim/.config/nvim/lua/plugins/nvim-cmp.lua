return {
  -- Completion Engine
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim', -- Adds VS Code-style icons
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load() -- Load VS Code-like snippets

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item(), -- Navigate through suggestions
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
          ['<C-Space>'] = cmp.mapping.complete(), -- Manually trigger completion
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' }, -- LSP-based autocompletion
          { name = 'luasnip' }, -- Snippets
          { name = 'buffer' }, -- Buffer completion
          { name = 'path' }, -- File path completion
        }),
        formatting = {
          format = require('lspkind').cmp_format({ with_text = true, menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            path = "[Path]",
          })}),
        },
      })
    end,
  },
}

