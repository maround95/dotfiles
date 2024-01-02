return {
  "maround95/persisted.nvim",
  branch = "workaround_134_exit",
  opts = {
    save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
    silent = false, -- silent nvim message when sourcing session file
    use_git_branch = true, -- create session files based on the branch of a git enabled repository
    default_branch = "main", -- the branch to load if a session file is not found for the current branch
    autosave = true, -- automatically save session files when exiting Neovim
    should_autosave = nil, -- function to determine if a session should be autosaved
    autoload = false, -- automatically load the session for the cwd on Neovim startup
    on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
    follow_cwd = true, -- change session file name to match current working directory if it changes
    allowed_dirs = { "~/git", "~/.config", "~/.dotfiles" }, -- table of dirs that the plugin will auto-save and auto-load from
    ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
    telescope = {
      reset_prompt = true, -- Reset the Telescope prompt after an action?
    },
  },
  config = function(_, opts)
    require('persisted').setup(opts)

    local keymap = vim.keymap
    keymap.set("n", "<leader>wl", "<cmd>SessionLoadLast<CR>", { desc = "Load last session for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>wL", "<cmd>SessionLoad<CR>", { desc = "Load git branch session for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session" }) -- save workspace session for current working directory
  end
}