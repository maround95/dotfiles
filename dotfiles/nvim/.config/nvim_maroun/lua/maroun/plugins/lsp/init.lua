local mason_lspconfig_opts = {
  automatic_installation = { exclude = { "rust_analyzer" } },
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

    lspconfig.lua_ls.setup({})
    lspconfig.clangd.setup({})
    lspconfig.pyright.setup({})
    lspconfig.ruff_lsp.setup({})
    lspconfig.nil_ls.setup({})

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function()
        local builtin = require "telescope.builtin"

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0, desc = "LSP: Go to definition" })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0, desc = "LSP: Show references" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "LSP: Go to declaration" })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "LSP: Go to type definition" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 , desc = "LSP: Hover" })

        vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0, desc = "LSP: Rename symbol" })
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "LSP: Code actions" })
        vim.keymap.set("n", "<space>cf", vim.lsp.buf.format, { buffer = 0, desc = "LSP: Format buffer" })
      end,
    })
  end,
}
