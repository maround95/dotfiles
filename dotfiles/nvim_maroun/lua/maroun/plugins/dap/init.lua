return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "przepompownia/nvim-dap-tab",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    -- require('dap.ext.vscode').load_launchjs()
    -- require("dap-tab").setup()

    local opts = {}
    opts.desc = "Toggle DAP UI"
    vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, opts)

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "-i", "dap", "-init-eval-command", "set sysroot /" },
    }

    dap.adapters['lldb-dap'] = {
      type = "executable",
      command = "lldb-dap",
      name = "lldb-dap",
    }

    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        -- CHANGE THIS to your path!
        command = 'codelldb',
        args = { "--port", "${port}" },

        -- On windows you may have to uncomment this:
        -- detached = false,
      }
    }

    dap.configurations.cpp = {
      {
        -- If you get an "Operation not permitted" error using this, try disabling YAMA:
        --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = "Attach to process",
        type = 'gdb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
        request = 'attach',
        target = 'ares:12345',
        -- pid = require('dap.utils').pick_process,
        args = {},
      },
      {
        -- If you get an "Operation not permitted" error using this, try disabling YAMA:
        --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = "lldb-dap: remote attach (ares)",
        type = 'lldb-dap', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
        request = 'attach',
        program = '/home/maroun/git/Hyprland/main/build/Hyprland',
        -- attachCommands = {
        --   "gdb-remote ares:1234",
        -- },
        gdb_remote_port = 1234,
        gdb_remote_hostname = "ares",
      },
      {
        -- If you get an "Operation not permitted" error using this, try disabling YAMA:
        --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = "codelldb: remote attach (ares)",
        type = 'codelldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
        request = 'launch',
        custom = true,
        processCreateCommands = {
        },
        initCommands = {
          "platform select remote-linux",
          "platform connect connect://ares:1234",
          "settings set target.inherit-env false",
          "platform process attach --name Hyprland",
        },
        args = {},
      },
    }

    dap.configurations.c = dap.configurations.cpp
  end
}
