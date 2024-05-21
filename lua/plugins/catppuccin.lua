return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      local palettes = {
        latte = require("catppuccin.palettes").get_palette("latte"),
        frappe = require("catppuccin.palettes").get_palette("frappe"),
        macchiato = require("catppuccin.palettes").get_palette("macchiato"),
        mocha = require("catppuccin.palettes").get_palette("mocha"),
      }

      local flavour = os.getenv("TERM_IS_DARK") == "true" and "frappe" or "latte"

      ---@class CatppuccinOptions
      require("catppuccin").setup({
        flavour = flavour,
        transparent_background = os.getenv("TERM_IS_DARK") == "true",
        custom_highlights = function(colors)
          return {
            PackageInfoOutdatedVersion = { fg = colors.peach },
            CurSearch = { bg = palettes[flavour].yellow },
          }
        end,
        integrations = {
          barbecue = {
            dim_dirname = true,
            bold_basename = true,
            dim_context = false,
            alt_background = false,
          },
          cmp = true,
          dap = true,
          dap_ui = true,
          dashboard = true,
          fidget = true,
          gitsigns = true,
          harpoon = true,
          headlines = true,
          illuminate = true,
          lsp_trouble = true,
          markdown = true,
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          octo = true,
          symbols_outline = true,
          telescope = { enabled = true },
          treesitter = true,
          treesitter_context = false,
          which_key = true,
        },
      })

      vim.cmd("colorscheme catppuccin")
    end,
  },
}
