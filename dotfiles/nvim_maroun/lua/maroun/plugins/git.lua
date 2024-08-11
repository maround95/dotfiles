return {
  {
    "tpope/vim-fugitive",
    config = false
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", mode = "n", desc = "Neogit" },
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", mode = "n", desc = "Open Diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", mode = "n", desc = "Open Diffview current file history" },
    },
    opts = {
      mappings = {
        finder = {
          ["<c-k>"] = "Previous",
          ["<c-j>"] = "Next",
        }
      }
    },
    config = function(_, opts)
      require('neogit').setup(opts)

      require('diffview').setup({
      })

      -- Diffview exit with q, workaround because using the keymaps option is buggy.
      -- vim.api.nvim_create_autocmd('User', {
      --   pattern = 'DiffviewViewOpened',
      --   group = vim.api.nvim_create_augroup('DiffviewQuit', { clear = true }),
      --   callback = function()
      --     vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<Cmd>DiffviewClose<CR>', { noremap = true, silent = true })
      --   end,
      -- })
    end
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    keys = {
      { "<leader>gws", function() require('telescope').extensions.git_worktree.git_worktrees() end, mode = "n", desc = "Git worktrees" },
    },
    opts = {}
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'Next hunk' })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'Previous hunk' })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { desc = 'Stage hunk' })
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { desc = 'Reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git Reset Buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = 'Git blame line' })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle current line blame' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'Diff buffer against git index' })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff buffer against HEAD' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'Toggle deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
      end
    }
  }
}
