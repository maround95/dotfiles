return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "macchiato"
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd("colorscheme catppuccin")

      -- Comments are too bright. https://catppuccin.com/palette
      vim.api.nvim_set_hl(0, "Comment", { fg = "#494d64" })
    end
  },
  {
    'rose-pine/neovim',
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      variant = "moon",
      dark_variant = "moon",
      disable_italics = true
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
      vim.cmd("colorscheme rose-pine")
    end
  },
}
