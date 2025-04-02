return {
  -- LSP Configurations
  {
    'neovim/nvim-lspconfig', -- Core LSP config
    config = function()
      local lspconfig = require('lspconfig')

      -- Setup LSP servers
      local servers = {
        'bashls',
        'cssls',
        'html',
        'biome',
        'jsonls',
        'lua_ls',
        'grammarly',
        'terraformls',
        'yamlls',
        'pyright',
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({})
      end

      -- Keybindings for LSP
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Definitions" })
      vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { desc = "Code Actions" })
    end
  },

  -- Mason for easy LSP installation
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },

  -- Mason LSP Config for ease of integration
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'cssls',
          'html',
          'biome',
          'jsonls',
          'lua_ls',
          'grammarly',
          'terraformls',
          'yamlls',
          'pyright',
        }
      })
    end
  }
}


