return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1500
  end,
  config = function()
    local wk = require("which-key");

    wk.add({
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git hunks" },
      { "<leader>s", group = "Splits" },
      { "<leader>t", group = "Toggle" },
      { "<leader>u", group = "Undotree" },
      { "<leader>w", group = "Session" },
      { "<leader>x", group = "Diagnostics" },
    });
  end
}
