return {
  "nooproblem/git-worktree.nvim",
  keys = {
    { "<leader>gws", function() require('telescope').extensions.git_worktree.git_worktrees() end, mode = "n", desc = "Git worktrees" },
  },
  config = function(_, opts)
    require("git-worktree").setup(opts)
  end,
}
