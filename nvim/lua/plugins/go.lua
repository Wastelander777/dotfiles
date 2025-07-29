-- File: lua/plugins/go.lua
return {
  -- Tell Mason to grab Go binaries
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "golangci-lint",
      })
    end,
  },

  -- Tell Mason-lspconfig to ensure the Go LSP
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "gopls",
      })
    end,
  },

  -- Add Go formatter and linter to null-ls via none-ls.nvim
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.sources = vim.list_extend(opts.sources or {}, {
        -- Go imports formatter
        nls.builtins.formatting.goimports,
        -- Go linter
        nls.builtins.diagnostics.golangci_lint.with({ extra_args = { "--fast" } }),
      })
    end,
  },

  -- Ensure Go grammar in Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
        "go",
      })
    end,
  },
}

