-- lua/plugins/mason.lua
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        -- Linters
        "golangci-lint",
        "shellcheck",
        "yamllint",
        "hadolint",
        "tflint",

        -- Formatters
        "stylua",
        "shfmt",
        "yamlfmt",
        "terraform_fmt",
      },
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
        "ruff",
      },
      automatic_installation = true,
    },
  },
}
