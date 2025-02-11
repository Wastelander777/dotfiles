-- File: lua/plugins/init.lua

return {
  -- 1. Conform for formatting (optional if you're also using null-ls)
  {
    "stevearc/conform.nvim",
    -- event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- 2. LSPConfig (plus your custom config in `configs.lspconfig`)
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- 3. Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- recommended so that parsers update automatically
    opts = {
      -- Tree-sitter languages to install
      ensure_installed = {
        "lua",
        "python",
        "yaml",
        "java",
        "bash",
        -- etc. Add more languages you need for syntax highlighting
      },
      highlight = { enable = true },
    },
  },

  -- 4. Mason + null-ls + mason-lspconfig + mason-tool-installer
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      -- Setup Mason
      require("mason").setup()

      -- Setup Mason LSPconfig
      require("mason-lspconfig").setup {
        -- List LSP servers you want to ensure are installed
        ensure_installed = {
          "pyright",
          "yamlls",
          "jdtls",
          "lemminx",
          "lua_ls",
          "ruff",
          "terraformls",
          "lemminx",
          "bashls",
          "flake8",
          -- for Python: "ruff_lsp" if you prefer ruff-lsp
        },
      }

      -- Setup Mason tool installer for DAP, Linters, Formatters, etc.
      require("mason-tool-installer").setup {
        ensure_installed = {
          -- Python tooling
          "debugpy", -- for debugging
          "mypy", -- type checker
          "ruff", -- python linter
          "flake8",
          "black",
          "isort",
          -- etc.
        },
      }

      -- Setup null-ls for diagnostics/formatting
      local null_ls = require "null-ls"
      null_ls.setup {
        sources = {
          -- Standard Lua
          null_ls.builtins.formatting.stylua,

          -- Example JS/TS
          null_ls.builtins.diagnostics.eslint,

          -- Python tools
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.diagnostics.flake8,
        },
      }
    end,
  },

  -- 5. Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- or opts = {} if you want to pass specific options
  },

  -- 6. Oil file explorer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- if you want icons
    opts = {
      -- Put oil-specific config here, if desired
    },
  },

  -- 7. mini.nvim (unify into one spec if you want the stable or the latest version)
  {
    "echasnovski/mini.nvim",
    version = "*", -- or version = false for the latest dev version
    -- opts = { ... } if you need config
  },

  -- 8. Trouble
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {}, -- default
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions/refs (Trouble)",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- 9. nvim-java
  { "nvim-java/nvim-java" },
}
