-- File: lua/plugins/python.lua
return {
  -- Tell Mason to grab Python binaries
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "black",
        "isort",
        "ruff",
      })
    end,
  },

  -- Tell Mason-lspconfig to ensure these LSPs
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "pyright", "ruff" })
    end,
  },

  -- Add Python linters / formatters to null-ls
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require "null-ls"
    end,
  },

  -- Extra Treesitter grammar (if you didn’t already add in init.lua)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, { "python" })
    end,
  },
}
