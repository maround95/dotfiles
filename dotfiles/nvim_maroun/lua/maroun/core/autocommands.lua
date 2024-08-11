-- Help files
vim.api.nvim_create_autocmd('FileType', {
  pattern = "help",
  group = vim.api.nvim_create_augroup('MyHelpQuit', { clear = true }),
  callback = function()
    -- Normal: close with Esc
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>quit<cr>', { noremap = true, silent = true })
  end,
})

-- Command window `q:`
vim.api.nvim_create_autocmd('CmdwinEnter', {
  group = vim.api.nvim_create_augroup('MyCmdwinQuit', { clear = true }),
  callback = function()
    -- Normal: close with Esc
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<C-c><Esc>', { noremap = true, silent = true })
  end,
})
