-- Navigate nvim and tmux windows/panels with vim bindings
return {
  {
    "shihanng/zellij-nav.nvim",
    cond = vim.env.ZELLIJ ~= nil,
    lazy = false,
    init = function()
      vim.g.zellij_nav_default_mappings = false -- Default: true
    end,
    opts = {},
    config = function(_, opts)
      local nav = require('zellij-nav')
      nav.setup(opts)

      vim.keymap.set({'n', 'v', 'c'}, "<m-h>", function() nav.left("move-focus-or-tab") end, {silent=true, desc="Zellij navigate left"})
      vim.keymap.set({'n', 'v', 'c'}, "<m-j>", function() nav.down("move-focus") end, {silent=true, desc="Zellij navigate down"})
      vim.keymap.set({'n', 'v', 'c'}, "<m-k>", function() nav.up("move-focus") end, {silent=true, desc="Zellij navigate up"})
      vim.keymap.set({'n', 'v', 'c'}, "<m-l>", function() nav.right("move-focus-or-tab") end, {silent=true, desc="Zellij navigate right"})
    end,
  },

  {
    'christoomey/vim-tmux-navigator',
    cond = vim.env.TMUX ~= nil,
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
  },
}
