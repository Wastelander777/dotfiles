-- File: lua/plugins/devops.lua
return {
  --------------------------------------------------------------------
  -- 1️⃣  Binaries managed by Mason (formatters, linters, DAP, etc.)
  --------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        -- Bash
        "shellcheck",
        "shfmt",
        -- YAML
        "yamllint",
        "yamlfmt",
        -- Docker
        "hadolint",
        -- Terraform
        "terraform-fmt",
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
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
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
      vim.list_extend(opts.sources, {
        -- Bash
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.formatting.shfmt,
        -- YAML
        nls.builtins.diagnostics.yamllint,
        nls.builtins.formatting.yamlfmt,
        -- Docker
        nls.builtins.diagnostics.hadolint,
        -- Terraform
        nls.builtins.formatting.terraform_fmt,
        nls.builtins.diagnostics.tflint,
      })
    end,
  },

  --------------------------------------------------------------------
  -- 4️⃣  Treesitter grammars
  --------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
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
