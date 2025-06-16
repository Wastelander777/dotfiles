-- File: lua/plugins/init.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "python", "yaml", "bash", "java" },
      highlight = { enable = true }
    }
  },

  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "stevearc/oil.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  -- { "folke/trouble.nvim", cmd = "Trouble", opts = {}, keys = { … } },
  { "echasnovski/mini.nvim", version = "*" },
  { "mfussenegger/nvim-jdtls" }, -- Java DAP helper 

  --------------------------------------------------------------------------
  -- Everything Mason / LSP / null-ls related is pulled in *once* below
  --------------------------------------------------------------------------
  { import = "plugins.mason" },
  { import = "plugins.python" },
  { import = "plugins.devops" },
}
