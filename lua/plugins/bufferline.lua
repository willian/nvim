return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle Pin" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete Other Buffers" },
    { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- version = "*",
  opts = {
    options = {
      -- stylua: ignore
      -- close_command = function(n) require("mini.bufremove").delete(n, false) end,
      -- stylua: ignore
      -- right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local icons = require("config.icons").diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
