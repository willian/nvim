return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    local icons = require("config.icons")
    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = icons.mason.Installed,
          package_pending = icons.mason.Pending,
          package_uninstalled = icons.mason.Uninstalled,
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "cssls",
        "emmet_ls",
        "graphql",
        "html",
        "lua_ls",
        "prismals",
        "pyright",
        "rubocop",
        "ruby_lsp",
        "solargraph",
        "stimulus_ls",
        "svelte",
        "tailwindcss",
        "tsserver",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "black", -- python formatter
        "erb-lint", -- ERB formatter (Ruby)
        "eslint_d",
        "hadolint",
        "isort", -- python formatter
        "markdownlint",
        "prettier", -- prettier formatter
        "pylint",
        "rubocop",
        "stylua", -- lua formatter
      },
    })
  end,
}
