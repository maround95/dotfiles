-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap
local opt = {}

opt.desc = "Clear search highlights"
keymap.set("n", "<Backspace>", "<cmd>nohl<CR>", opt)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Folds
-- keymap.set("n", "za", "zazj")

-- System clipboard
keymap.set({"n", "v"}, "<leader>p", [["+p]])
keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- Navigation even if we're outside of tmux/zellij
keymap.set("n", "<m-h>", "<c-w>h")
keymap.set("n", "<m-j>", "<c-w>j")
keymap.set("n", "<m-k>", "<c-w>k")
keymap.set("n", "<m-l>", "<c-w>l")

-- Diff Operations
keymap.set("n", "<leader>dg", "<cmd>diffget<CR>]c")
keymap.set("n", "<leader>dp", "<cmd>diffput<CR>]c")

-- Buffers
opt.desc = "Next buffer"
keymap.set("n", "]b", "<cmd>bnext<CR>", opt)

opt.desc = "Previous buffer"
keymap.set("n", "[b", "<cmd>bprevious<CR>", opt)

opt.desc = "Close current buffer"
keymap.set("n", "<leader>C", "<cmd>bdelete<CR>", opt)
