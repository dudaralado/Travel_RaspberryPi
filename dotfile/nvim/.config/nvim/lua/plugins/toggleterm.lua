return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "horizontal", -- Ensures the terminal opens at the bottom
      size = 15,            -- Adjust the height of the terminal
      open_mapping = [[<C-t>]], -- Keybinding to toggle the terminal (change as needed)
      shade_terminals = true, -- Dim the background when in terminal mode
      persist_size = true,  -- Keep the terminal size the same across openings
    })
  end
}
