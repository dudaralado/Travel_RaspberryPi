vim.opt.expandtab = true -- Convert tabs to space
vim.opt.shiftwidth = 2 -- Amount to indent with 
vim.opt.tabstop = 2 -- How many spaces are shown per tab
vim.opt.softtabstop = 2 -- how many spaces are applied when pressing Tab
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorcolumn = true
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#313244" }) -- Macchiato theme example
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#313244" }) -- Macchiato theme example

