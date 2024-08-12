local opt = vim.opt

-- Search
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- Indent
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true -- :h smartindent
opt.expandtab = true  -- expand tab to spaces
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.tabstop = 2       -- 2 spaces for tabs

-- UI
opt.laststatus = 3 -- Global statusbar
opt.listchars = { tab = "▸ ", eol = "↵" }
opt.list = true -- Invisible characters
opt.number = true         -- shows absolute line number on cursor line (when relative number is on)
opt.relativenumber = true -- show relative line numbers
opt.scrolloff = 3 -- Context lines
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift
opt.splitbelow = true -- split horizontal window to the bottom
opt.splitright = true -- split vertical window to the right
opt.termguicolors = true
opt.termsync = false -- https://github.com/zellij-org/zellij/issues/3208
opt.visualbell = true -- Blink cursor on error instead of beeping
opt.winminwidth = 2 -- Minimum window width
opt.wrap = false -- disable line wrapping

-- Undo
opt.undofile = true -- persistent undo file
opt.undodir = vim.fn.stdpath('data') .. "/undodir/"
opt.undolevels = 10000

vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- Disable comments on next line
