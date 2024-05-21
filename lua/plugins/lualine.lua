return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = require("config.icons")
    local ui = require("util.ui")

    local copilot_colors = {
      [""] = ui.fg("Special"),
      ["Normal"] = ui.fg("Special"),
      ["Warning"] = ui.fg("DiagnosticError"),
      ["InProgress"] = ui.fg("DiagnosticWarn"),
    }

    vim.o.laststatus = vim.g.lualine_laststatus

    return {
      options = {
        theme = "auto",
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },

        lualine_c = {
          vim.uv.cwd(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1 },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          {
            function()
              local icon = require("config.icons").kinds.Copilot
              local status = require("copilot.api").status.data
              return icon .. (status.message or "")
            end,
            cond = function()
              if not package.loaded["copilot"] then
                return
              end
              local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
              if not ok then
                return false
              end
              return ok and #clients > 0
            end,
            color = function()
              if not package.loaded["copilot"] then
                return
              end
              local status = require("copilot.api").status.data
              return copilot_colors[status.status] or copilot_colors[""]
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "nvim-tree", "lazy" },
    }
  end,
}
