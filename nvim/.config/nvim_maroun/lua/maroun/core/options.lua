local opt = vim.opt

opt.autoindent = true -- copy indent from current line when starting new one
opt.expandtab = true  -- expand tab to spaces
opt.grepprg = "rg --vimgrep" -- replace vimgrep with rg
opt.ignorecase = true -- ignore case when searching
opt.list = true -- Invisible characters
opt.listchars = { tab = "▸ ", eol = "↵" }
opt.number = true         -- shows absolute line number on cursor line (when relative number is on)
opt.relativenumber = true -- show relative line numbers
opt.scrolloff = 3 -- Context lines
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive
opt.splitbelow = true -- split horizontal window to the bottom
opt.splitright = true -- split vertical window to the right
opt.tabstop = 2       -- 2 spaces for tabs
opt.termguicolors = true
opt.undofile = true -- persistent undo file
opt.undodir = vim.fn.stdpath('data') .. "/undodir/"
opt.undolevels = 10000
opt.visualbell = true -- Blink cursor on error instead of beeping
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- disable line wrapping

vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- Disable continuous comments
