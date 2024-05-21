return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    { "folke/neodev.nvim", opts = {} },
    "hrsh7th/cmp-nvim-lsp",
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local map = vim.keymap.set -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Lsp Info"
        map("n", "<leader>cli", "<cmd>LspInfo<cr>", opts)

        opts.desc = "Restart LSP"
        map("n", "<leader>clr", ":LspRestart<CR>", opts)

        opts.desc = "Goto Definition"
        map("n", "gd", function()
          require("telescope.builtin").lsp_definitions({ reuse_win = true })
        end, opts)

        opts.desc = "References"
        map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)

        opts.desc = "Goto Declaration"
        map("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Goto Implementation"
        map("n", "gI", function()
          require("telescope.builtin").lsp_implementations({ reuse_win = true })
        end, opts)

        opts.desc = "Goto T[y]pe Definition"
        map("n", "gy", function()
          require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end, opts)

        opts.desc = "Hover"
        map("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Signature Help"
        map("n", "gK", vim.lsp.buf.signature_help, opts)

        opts.desc = "Signature Help"
        map("i", "<c-k>", vim.lsp.buf.signature_help, opts)

        opts.desc = "Code Action"
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Run Codelens"
        map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, opts)

        opts.desc = "Refresh & Display Codelens"
        map("n", "<leader>cC", vim.lsp.codelens.refresh, opts)

        opts.desc = "Source Action"
        map("n", "<leader>cA", function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end, opts)

        -- opts.desc = "Next Reference"
        -- opts("n", "]]", function() LazyVim.lsp.words.jump(vim.v.count1) end, opts)
        --
        -- opts.desc = "Next Reference"
        -- opts("n", "[[", function() LazyVim.lsp.words.jump(-vim.v.count1) end, opts)
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["svelte"] = function()
        -- configure svelte server
        lspconfig["svelte"].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                -- Here use ctx.match instead of ctx.file
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        })
      end,
      ["graphql"] = function()
        -- configure graphql language server
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
      ["emmet_ls"] = function()
        -- configure emmet language server
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
      -- TypeScript
      ["tsserver"] = function()
        lspconfig["tsserver"].setup({
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
            {
              "<leader>cR",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.removeUnused.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Remove Unused Imports",
            },
          },
          settings = {
            typescript = {
              inlayHints = inlay_hints_settings,
            },
            javascript = {
              inlayHints = inlay_hints_settings,
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        })
      end,
    })
  end,
}
