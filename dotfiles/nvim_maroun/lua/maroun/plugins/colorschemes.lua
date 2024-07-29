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
