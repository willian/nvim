return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local lint = require("lint")

    local M = {}

    function M.debounce(ms, fn)
      local timer = vim.uv.new_timer()
      return function(...)
        local argv = { ... }
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    function M.lint()
      lint.try_lint()
    end

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      eruby = { "erb_lint" },
      dockerfile = { "hadolint" },
      markdown = { "markdownlint" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = M.debounce(100, M.lint),
    })

    vim.keymap.set("n", "<leader>clf", M.lint, { desc = "Trigger linting for current file" })
  end,
}
