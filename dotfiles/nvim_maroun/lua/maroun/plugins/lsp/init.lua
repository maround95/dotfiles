local mason_lspconfig_opts = {
  automatic_installation = false,
};

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local lspconfig = require('lspconfig')

    mason.setup({})
    mason_lspconfig.setup(mason_lspconfig_opts)

    local default_on_attach = function(_, bufnr)
      local builtin = require("telescope.builtin")

      vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
      vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = bufnr, desc = "LSP: Go to definition" })
      vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = bufnr, desc = "LSP: Show references" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to declaration" })
      -- vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP: Go to type definition" })
      vim.keymap.set("n", "<C-K>", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })

      vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename symbol" })
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code actions" })
      vim.keymap.set("n", "<space>cf", vim.lsp.buf.format, { buffer = bufnr, desc = "LSP: Format buffer" })
    end

    lspconfig.lua_ls.setup({
      on_attach = default_on_attach
      -- settings = {
      --   Lua = {
      --     completion = {
      --       callSnippet = "Replace",
      --     },
      --     -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      --     -- diagnostics = { disable = { 'missing-fields' } },
      --   }
      -- },
    })

    lspconfig.clangd.setup({
      on_attach = default_on_attach
    })

    lspconfig.neocmake.setup({
      on_attach = default_on_attach
    })

    lspconfig.nixd.setup({
      on_attach = default_on_attach,
      cmd = { "nixd" },
      settings = {
        nixd = {
          nixpkgs = {
            expr = "import <nixpkgs> { }",
          },
          formatting = {
            command = { "nixfmt" },
          },
          options = {
            nixos = {
              expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.ares.options',
            },
            home_manager = {
              expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.maroun@ares.options',
            },
          },
          diagnostic = {
            suppress = {
              "sema-extra-with",
              "sema-escaping-with",
              "var-bind-to-this",
            }
          },
        },
      },
    })
  end,
}
