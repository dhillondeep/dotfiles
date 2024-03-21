-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Resize window using <leader>r keys
vim.keymap.set("n", "<leader>rk", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<leader>rj", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<leader>rl", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader>rh", " cmd>vertical resize +2<cr>", { desc = "Increase window width" })
