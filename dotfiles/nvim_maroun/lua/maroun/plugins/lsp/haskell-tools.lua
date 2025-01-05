return {
  'mrcjkb/haskell-tools.nvim',
  version = '^4', -- Recommended
  lazy = false,   -- This plugin is already lazy
  init = function()
    vim.g.haskell_tools = {
      hls = {
        on_attach = function(client, bufnr)
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

          -- ~/.config/nvim/after/ftplugin/haskell.lua
          local ht = require('haskell-tools')
          local opts = { noremap = true, silent = true, buffer = bufnr, }
          -- haskell-language-server relies heavily on codeLenses,
          -- so auto-refresh (see advanced configuration) is enabled by default
          vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
          -- Hoogle search for the type signature of the definition under the cursor
          vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
          -- Evaluate all code snippets
          vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
          -- Toggle a GHCi repl for the current package
          vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
          -- Toggle a GHCi repl for the current buffer
          vim.keymap.set('n', '<leader>rf', function()
            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
          end, opts)
          vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
        end
      }
    }
  end
}
