return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = false,
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 3000 })
      end,
      mode = "",
      desc = "Format",
    },
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  opts = function()
    local formatter_setup = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_fallback = true, -- not recommended to change
      }
    end

    return {
      formatters_by_ft = {
        -- Miscellaneous
        ["fish"] = { "fish_indent" },
        ["lua"] = { "stylua" },
        ["python"] = { "isort", "black" },
        ["sh"] = { "shfmt" },

        -- prettier
        ["css"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
        ["html"] = { "prettier" },
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["less"] = { "prettier" },
        ["liquid"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["svelte"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["yaml"] = { "prettier" },
      },
      format = formatter_setup,
      format_on_save = formatter_setup,
    }
  end,
}
