return {
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    opts = {
      use_wallust = true,

      transparent_background = true,
      custom_highlights = function(c)
        return {
          -- Comments are too bright.
          Comment = { fg = "#494949" },
          -- Folds highlight is too distracting.
          Folded = { fg = c.color1 },
        }
      end,
      plugins = {
        gitsigns = true,
        dap_ui = true,
      },
    },
    config = function(_, opts)
      require('neopywal').setup(opts)
      local C = require('neopywal').get_colors()

      local has_feline, feline = pcall(require, "feline")
      if not has_feline then
        return
      end

      local has_neopywal, neopywal_feline = pcall(require, "neopywal.theme.plugins.feline")
      if not has_neopywal then
        return
      end

      neopywal_feline.setup()

      feline.setup({
        components = neopywal_feline.get(),
      })

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          package.loaded["feline"] = nil
          package.loaded["neopywal.theme.plugins.feline"] = nil
          require("feline").setup({
            components = require("neopywal.theme.plugins.feline").get(),
          })
        end,
      })

      vim.cmd("colorscheme neopywal")

      -- Comments are too bright.
      vim.api.nvim_set_hl(0, "Comment", { fg = "#494949" })

      -- Folds highlight is too distracting.
      vim.api.nvim_set_hl(0, "Folded", { fg = C.color1 })
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
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

      -- Folds highlight is too distracting.
      vim.api.nvim_set_hl(0, "Folded", { fg = "#24273a" })
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
