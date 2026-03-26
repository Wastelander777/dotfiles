-- lua/plugins/mason.lua
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {},
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Linters
        "golangci-lint",
        "shellcheck",
        "yamllint",
        "hadolint",
        "tflint",
        "ruff",
        "sqlfluff",

        -- Formatters
        "stylua",
        "shfmt",
        "yamlfmt",
        "goimports",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "gopls",
        "bashls",
        "yamlls",
        "dockerls",
        "terraformls",
        "helm_ls",
        "basedpyright",
      },
      automatic_installation = true,
    },
  },
}
