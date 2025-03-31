--return {
--  "nvim-tree/nvim-tree.lua",
--  version = "*",
--  lazy = false,
--  dependencies = {
--    "nvim-tree/nvim-web-devicons",
--  },
--  config = function()
--    require("nvim-tree").setup({})
--    vim.keymap.set("n", "<C-q>", ":q!<CR>", { desc = "Close window or file" })
--     -- Function to open nvim-tree automatically on startup
--    local function open_nvim_tree()
--      -- Check if there's no file opened (i.e., only NvimTree should open)
--      if vim.fn.argc() == 0 then
--        require("nvim-tree.api").tree.open()
--      end
--    end
--
--    -- Run the function after Neovim starts
--    vim.api.nvim_create_autocmd("VimEnter", {
--      callback = open_nvim_tree
--    })
--  end
--}
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        adaptive_size = true, -- Enables auto-resizing based on content
      },
    })

    vim.keymap.set("n", "<C-q>", ":q!<CR>", { desc = "Close window or file" })

    -- Function to open nvim-tree automatically on startup
    local function open_nvim_tree()
      -- Check if there's no file opened (i.e., only NvimTree should open)
      if vim.fn.argc() == 0 then
        require("nvim-tree.api").tree.open()
      end
    end

    -- Run the function after Neovim starts
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = open_nvim_tree
    })
  end
}
