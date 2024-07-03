return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {

        -- Lua
        -- null_ls.builtins.formatting.stylua

        -- Nix
        null_ls.builtins.formatting.nixpkgs_fmt

      },
    })
  end,
}
