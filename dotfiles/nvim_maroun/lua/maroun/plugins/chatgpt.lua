-- lazy.nvim
return {
  "robitx/gp.nvim",
  config = function()
    local conf = {
      -- For customization, refer to Install > Configuration in the Documentation/Readme
    }
    require("gp").setup(conf)

    -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
  end,
}
-- return {
--   "jackMort/ChatGPT.nvim",
--   dependencies = {
--     "MunifTanjim/nui.nvim",
--     "nvim-lua/plenary.nvim",
--     "folke/trouble.nvim",
--     "nvim-telescope/telescope.nvim"
--   },
--   event = "VeryLazy",
--   opts = {
--     chat = {
--       keymaps = {
--         close = "<C-c>",
--         yank_last = "<C-y>",
--         yank_last_code = "<C-k>",
--         scroll_up = "<C-u>",
--         scroll_down = "<C-d>",
--         new_session = "<C-n>",
--         cycle_windows = "<Tab>",
--         cycle_modes = "<C-f>",
--         next_message = "<C-j>",
--         prev_message = "<C-k>",
--         select_session = "<Space>",
--         rename_session = "r",
--         delete_session = "d",
--         draft_message = "<C-r>",
--         edit_message = "e",
--         delete_message = "d",
--         toggle_settings = "<C-o>",
--         toggle_sessions = "<C-p>",
--         toggle_help = "<C-h>",
--         toggle_message_role = "<C-r>",
--         toggle_system_role_open = "<C-s>",
--         stop_generating = "<C-x>",
--       },
--     }
--   },
--   config = function(_, opts)
--     require("chatgpt").setup(opts)
--   end,
-- }
