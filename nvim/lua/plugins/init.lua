-- File: lua/plugins/init.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "python", "yaml", "bash", "java", "go" },
      highlight = { enable = true },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "mfussenegger/nvim-jdtls",
  }, -- Java DAP helper

  --------------------------------------------------------------------------
  -- Everything Mason / LSP / null-ls related is pulled in *once* below
  --------------------------------------------------------------------------
  {
    import = "plugins.mason",
  },
  {
    import = "plugins.python",
  },
  {
    import = "plugins.devops",
  },
  {
    import = "plugins.go",
  },

}

