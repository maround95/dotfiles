-- Navigate nvim and tmux windows/panels with vim bindings
return {
  "GR3YH4TT3R93/zellij-nav.nvim",
  cond = vim.env.ZELLIJ ~= nil,
  lazy = false,
  init = function() -- Only needed if you want to override default keymaps otherwise just call opts = {}
    vim.g.zellij_nav_default_mappings = false -- Default: true
  end,
  opts = {},
  keys = {
    { "<m-h>", "<cmd>ZellijNavigateLeft<cr>" },
    { "<m-j>", "<cmd>ZellijNavigateDown<cr>" },
    { "<m-k>", "<cmd>ZellijNavigateUp<cr>" },
    { "<m-l>", "<cmd>ZellijNavigateRight<cr>" },
  },
}
