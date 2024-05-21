return {
  "smjonas/inc-rename.nvim",
  config = function()
    require("inc_rename").setup({
      input_buffer_type = "dressing",
    })

    vim.keymap.set("n", "<leader>cr", function()
      local inc_rename = require("inc_rename")

      return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
    end, { expr = true, desc = "Rename" })
  end,
}
