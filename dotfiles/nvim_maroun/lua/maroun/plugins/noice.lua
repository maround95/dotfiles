return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    tag = 'v4.4.7', -- Flickering cursor on v4.5.0
    -- enabled = false,
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true,          -- enables the Noice messages UI
        view = "notify",         -- default view for messages
        view_error = "notify",   -- view for errors
        view_warn = "notify",    -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      notify = {
        -- Notifications are too intrusive
        enabled = true,
        view = 'messages',
      },
      -- cmdline = {
      --   enabled = true,
      -- },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1500,
    },
  }
}
