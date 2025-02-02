return {
  -- Mason plugin to manage tools
  "williamboman/mason.nvim",
  dependencies = {
    -- Plugin to configure LSP servers
    "neovim/nvim-lspconfig",
    -- Plugin to integrate Mason with LSPconfig
    "williamboman/mason-lspconfig.nvim",
    -- Plugin for formatters and linters using Mason
    "jose-elias-alvarez/null-ls.nvim",
    -- Plugin to use Mason with null-ls
    "jay-babu/mason-null-ls.nvim",
    -- Mason Tool installer for plugins
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {
    ensure_installed = {
      "ruff", -- Linter for Python
      "pyright", -- LSP for Python
      "isort", -- Python import sorter
    },
  },
  config = function()
    -- Setup Mason
    require("mason").setup()

    -- Setup Mason LSPconfig to ensure LSP servers are installed
    require("mason-lspconfig").setup {
      ensure_installed = { "pyright", "ruff", "yamlls" },
    }

    -- Setup Mason for null-ls to ensure formatters/linters are installed
    require("mason-tool-installer").setup {
      ensure_installed = { "ruff", "isort" },
    }
    require("null-ls").setup()

    -- Configure null-ls to integrate formatters and linters
    local null_ls = require "null-ls"
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.isort, -- isort for sorting imports
        null_ls.builtins.diagnostics.ruff, -- Ruff for linting
      },
    }
  end,
}
