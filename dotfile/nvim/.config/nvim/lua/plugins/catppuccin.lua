return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- Set the flavor here
    })
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
