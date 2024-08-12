return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufAdd", "BufReadPost", "BufNewFile" },
    main = "ibl",
    config = true,
    opts = {
      indent = { char = "╎" },
      scope = { enabled = false },
    },
  },
  {
    "Darazaki/indent-o-matic",
    cmd = "IndentOMatic",
    event = { "BufAdd", "BufReadPost", "BufNewFile" },
    opts = {},
    config = function(_, opts)
      require("indent-o-matic").setup(opts)
    end
  }
}
