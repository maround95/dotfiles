return {
  'rose-pine/neovim',
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
}
