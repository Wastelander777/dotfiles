-- File: lua/plugins/init.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "python", "yaml", "bash", "java", "go", "html", "sql" },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
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
    opts = {}, -- default options; customize if needed
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
    lazy = true,
  }, -- Java DAP helper

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },

  {
    "kawre/leetcode.nvim",
    lazy = true,
    cmd = "Leet",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed for formatting
    dependencies = {
      "nvim-telescope/telescope.nvim", -- picker
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "python3",
      picker = { provider = "telescope" },
      -- configuration goes here
      plugins = {
        non_standalone = true,
      },
    },
  },

  {
    import = "plugins.mason",
  },
  {
    import = "plugins.none-ls",
  },
  {
    import = "plugins.lint",
  },
}
