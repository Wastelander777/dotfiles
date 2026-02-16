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
        "isort",

        -- Formatters
        "stylua",
        "shfmt",
        "yamlfmt",
        "terraform_fmt",
        "goimports",
      },
      automatic_installation = true,
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
        "postgres_lsp",
        "basedpyright",
      },
      automatic_installation = true,
    },
  },
}
