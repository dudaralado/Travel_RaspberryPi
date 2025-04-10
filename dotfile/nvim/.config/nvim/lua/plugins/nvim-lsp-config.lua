-- return {
--   -- LSP Configurations
--   {
--     'neovim/nvim-lspconfig', -- Core LSP config
--     config = function()
--       local lspconfig = require('lspconfig')
-- 
--       -- Setup LSP servers
--       local servers = {
--         'bashls',
--         'cssls',
--         'html',
--         'biome',
--         'jsonls',
--         'lua_ls',
--         'grammarly',
--         'terraformls',
--         'yamlls',
--         'pyright',
--       }
-- 
--       for _, server in ipairs(servers) do
--         lspconfig[server].setup({})
--       end
-- 
--       -- Keybindings for LSP
--       vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
--       vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Definitions" })
--       vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { desc = "Code Actions" })
--     end
--   },
-- 
--   -- Mason for easy LSP installation
--   {
--     'williamboman/mason.nvim',
--     config = function()
--       require('mason').setup()
--     end
--   },
-- 
--   -- Mason LSP Config for ease of integration
--   {
--     'williamboman/mason-lspconfig.nvim',
--     config = function()
--       require('mason-lspconfig').setup({
--        ensure_installed = {
--          'bashls',
--          'cssls',
--          'html',
--          'biome',
--          'jsonls',
--          'lua_ls',
--          'grammarly',
--          'terraformls',
--          'yamlls',
--          'pyright',
--        }
--      })
--    end
--  }
--}

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
        'pyright',
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({})
      end

      -- Custom yamlls configuration
            lspconfig.yamlls.setup({
        settings = {
          yaml = {
            schemas = {
              -- Link to the Kubernetes JSON schema for v1.32.3
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.32.3/all.json"] = {"/*.yaml", "/*.yml"},
--              ["https://gitlab.wikimedia.org/repos/sre/kubernetes-json-schema/-/blob/main/v1.31.2-standalone-strict/all.json"] = {"/*.yaml", "/*.yml"},
            },
          },
        },
      })

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
  },
}

