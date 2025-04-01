return {
  -- LSP Configurations
  {
    'neovim/nvim-lspconfig', -- Core LSP config
    config = function()
      require('lspconfig')
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
					'harper_ls',
					'biome',
					'jsonls',
					'lua_ls',
					'grammarly',
					'terraformls',
					'yamlls',
					'pyright', 
				}  -- Example: install Lua, Python, and TypeScript servers
      })
    end
  }
}

