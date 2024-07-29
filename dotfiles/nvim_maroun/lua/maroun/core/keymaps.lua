-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<Backspace>", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>p", [["+p]])
keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- Navigation even if we're outside of tmux/zellij
keymap.set("n", "<m-h>", "<c-w>h")
keymap.set("n", "<m-j>", "<c-w>j")
keymap.set("n", "<m-k>", "<c-w>k")
keymap.set("n", "<m-l>", "<c-w>l")

-- Diff Operations
keymap.set("n", "<leader>dg", "<cmd>diffget<CR>")
keymap.set("n", "<leader>dp", "<cmd>diffput<CR>")
