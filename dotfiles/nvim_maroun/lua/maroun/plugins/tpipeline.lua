return {
  "vimpostor/vim-tpipeline",
  -- dir = "~/git/vim-tpipeline",
  enabled = false,
  init = function()
    -- vim.g.tpipeline_autoembed = 0
    -- vim.g.tpipeline_refreshcmd = 'zellij pipe --name zjstatus zjstatus::rerun::command_maroun'
    -- vim.g.tpipeline_refreshcmd = 'id'

    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "TpipelineSize",
    --   once = false,
    --   callback = function()
    --     -- vim.g.tpipeline_size = str2nr(systemlist("sh -c 'echo \"\"; tmux display-message -p \"#{window_width}\"'")[-1])
    --     -- vim.api.nvim_exec_autocmds("ColorScheme", {pattern = "*"})
    --     -- vim.notify("Update/Sync/Something is complete!")
    --     local size = tonumber(vim.fn.systemlist('zellij pipe --name zjstatus zjstatus::maroun::hi')[1])
    --     print(size)
    --     vim.g.tpipeline_size = size
    --   end,
    -- })
  end
}
