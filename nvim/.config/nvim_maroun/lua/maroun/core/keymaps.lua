-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<Backspace>", "<cmd>nohl<CR>", { desc = "Clear search highlights" })
