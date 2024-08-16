return {
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "abecodes/tabout.nvim",  event = "InsertEnter", config = true },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = { "VeryLazy" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-emoji",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "abecodes/tabout.nvim",
      "windwp/nvim-autopairs",
      "rcarriga/cmp-dap",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local handlers = require('nvim-autopairs.completion.handlers')

      -- If you want insert `(` after select function or method item
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done({
          filetypes = {
            -- "*" is a alias to all filetypes
            ["*"] = {
              ["("] = {
                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method,
                },
                handler = handlers["*"]
              }
            },
            -- lua = {
            --   ["("] = {
            --     kind = {
            --       cmp.lsp.CompletionItemKind.Function,
            --       cmp.lsp.CompletionItemKind.Method
            --     },
            --     ---@param char string
            --     ---@param item table item completion
            --     ---@param bufnr number buffer number
            --     ---@param rules table
            --     ---@param commit_character table<string>
            --     handler = function(char, item, bufnr, rules, commit_character)
            --       -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
            --     end
            --   }
            -- },
            -- -- Disable for tex
            -- tex = false
          }
        })
      )

      require("luasnip.loaders.from_vscode").lazy_load()

      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local kind_icons = {
        Text = "󰉿",
        Method = " ",
        Function = "󰊕 ",
        Constructor = " ",
        Field = " ",
        Variable = " ",
        Class = "󰠱 ",
        Interface = " ",
        Module = " ",
        Property = "󰜢 ",
        Unit = "󰑭 ",
        Value = " ",
        Enum = " ",
        Keyword = "󰌋 ",
        Snippet = " ",
        Color = "󰏘 ",
        File = "󰈙 ",
        Reference = " ",
        Folder = "󰉋 ",
        EnumMember = " ",
        Constant = "󰏿 ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = "  ",
        Misc = " ",
      }

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        enabled = function()
          return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt" or require("cmp_dap").is_dap_buffer()
        end,
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          -- ["<S-CR>"] = cmp.mapping.confirm({
          --   behavior = cmp.ConfirmBehavior.Replace,
          --   select = true,
          -- }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          expandable_indicator = true,
          fields = { "kind", "abbr", "menu" }, --order they will be displayed => Icon | Abbreviation | Menu
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              emoji = "[Emoji]",
            })[entry.source.name]
            return vim_item
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip", max_item_count = 10 },
          { name = "buffer",  max_item_count = 5, keyword_length = 3 },
          { name = "emoji" },
          { name = "path" },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        -- performance = {
        --   max_view_entries = 10,
        --   trigger_debounce_time = 500,
        --   throttle = 0,
        --   fetching_timeout = 200,
        -- },
        -- Ghost Text
        -- experimental = {
        --   ghost_text = {
        --     hl_group = "CmpGhostText",
        --   },
        -- },
      });

      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = "menu,menuone,noselect,noinsert",
        },
        mapping = cmp.mapping.preset.cmdline({
          ['<C-j>'] = {
            c = function()
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            end,
          },
          ['<C-k>'] = {
            c = function()
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            end,
          },
        }),
        sources = {
          { name = 'buffer' }
        }
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        preselect = cmp.PreselectMode.Item,
        completion = {
          completeopt = "menu,menuone",
          -- completeopt = "menu,menuone,noselect,noinsert",
        },
        mapping = cmp.mapping.preset.cmdline({
          ['<C-j>'] = {
            c = function()
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            end,
          },
          ['<C-k>'] = {
            c = function()
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            end,
          },
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<C-n>'] = { c = cmp.mapping.confirm({ select = true }) },
        }),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })

      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = "menu,menuone,noselect,noinsert",
        },
        -- mapping = cmp.mapping.preset.cmdline({
        --   ['<C-j>'] = {
        --     c = function()
        --       cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        --     end,
        --   },
        --   ['<C-k>'] = {
        --     c = function()
        --       cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        --     end,
        --   },
        -- }),
        sources = {
          { name = "dap" },
        },
      })
    end,
  } }
