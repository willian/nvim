return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "NvimTree",
        "Trouble",
        "alpha",
        "dashboard",
        "help",
        "lazy",
        "lazyterm",
        "mason",
        "neo-tree",
        "notify",
        "toggleterm",
        "trouble",
      },
    },
  },
}
