-- Navigate nvim and tmux windows/panels with vim bindings
return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<m-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<m-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<m-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<m-l>", "<cmd>TmuxNavigateRight<cr>" },
  },
  init = function()
    -- Disable default mappings.
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
