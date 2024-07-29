return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    -- Set <leader>1-5 to select harpoon'ed buffer, but hide them from which-key
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)

    -- Protected call in case we don't have which-key
    local status, wk = pcall(require, "which-key")
    if status then
      wk.register({
        ["<leader>1"] = "which_key_ignore",
        ["<leader>2"] = "which_key_ignore",
        ["<leader>3"] = "which_key_ignore",
        ["<leader>4"] = "which_key_ignore",
        ["<leader>5"] = "which_key_ignore",
      })
    end

  end
}
