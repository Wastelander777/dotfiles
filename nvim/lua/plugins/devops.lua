-- File: lua/plugins/devops.lua
return {
  --------------------------------------------------------------------
  -- 1️⃣  Binaries managed by Mason (formatters, linters, DAP, etc.)
  --------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        -- Bash
        "shellcheck",
        "shfmt",
        -- YAML
        "yamllint",
        "yamlfmt",
        -- Docker
        "hadolint",
        -- Terraform
        "terraform_fmt",
        "tflint",
      })
    end,
  },

  --------------------------------------------------------------------
  -- 2️⃣  Language servers via mason-lspconfig
  --------------------------------------------------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "bashls",
        "yamlls",
        "dockerls",
        "docker_compose_language_service",
        "terraformls",
        "helm_ls", -- Kubernetes/Helm charts
      })
    end,
  },

  --------------------------------------------------------------------
  -- 3️⃣  Null-ls sources
  --------------------------------------------------------------------
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
    end,
  },

  --------------------------------------------------------------------
  -- 4️⃣  Treesitter grammars
  --------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "bash",
        "yaml",
        "terraform",
        "dockerfile",
        "json",
        "hcl",
      })
    end,
  },
}
