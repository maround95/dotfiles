return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false,   -- This plugin is already lazy
  init = function()
    local server_config = require('rustaceanvim.config.server')
    local capabilities = server_config.create_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = false

    vim.g.rustaceanvim = {
      server = {
        capabilities = capabilities,
      }
    }
  end
}
