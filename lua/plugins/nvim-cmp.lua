return {
  "hrsh7th/nvim-cmp",
  version = false,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-nvim-lsp", -- source for LSP
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
  },
  config = function()
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local luasnip = require("luasnip")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { "~/.local/share/nvim/lazy/friendly-snippets", "./my-snippets" },
    })

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
        -- completeopt = "menu,menuone,noinsert",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- mapping = cmp.mapping.preset.insert({
      --   ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      --   ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      --   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
      --   ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      --   ["<C-e>"] = cmp.mapping.abort(), -- close completion window
      --   ["<CR>"] = cmp.mapping.confirm({ select = false }),
      -- }),
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "copilot", priotity = 100 },
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),

      formatting = {
        format = function(entry, item)
          local icons = require("config.icons").kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end

          return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end,
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
    })
  end,
}
