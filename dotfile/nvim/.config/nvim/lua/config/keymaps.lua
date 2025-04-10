vim.keymap.set("n", "e", "<cmd>Neotree<CR>", {desc="Open Nvim Explorer"})
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
vim.keymap.set("n", "w", "<cmd>w!<CR>", {desc="Save file"})
vim.keymap.set("n", "q", "<cmd>q!<CR>", {desc="Quit"})

-- Keymaps for barbar plugins
vim.keymap.set("n", ",", "<cmd>BufferPrevious<CR>", {desc="Previous Buffer"})
vim.keymap.set("n", ".", "<cmd>BufferNext<CR>", {desc="Next Buffer"})
vim.keymap.set("n", "c", "<cmd>BufferClose<CR>", {desc="Close Buffer"})
vim.keymap.set("n", "<", "<cmd>BufferMovePrevious<CR>", {desc="Re-order Buffer to the left"})
vim.keymap.set("n", ">", "<cmd>BufferMoveNext<CR>", {desc="Re-order Buffer to the right"})

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
