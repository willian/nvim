return {
  "echasnovski/mini.indentscope",
  version = false, -- wait till new 0.7.0 release to put it back on semver
  event = "VeryLazy",
  opts = {
    symbol = "│",
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
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
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
