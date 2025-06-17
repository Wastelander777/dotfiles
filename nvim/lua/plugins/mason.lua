-- Mason, LSP + null-ls glue
return {
  ---------------------------------------------------------------------------
  -- 1. Core Mason bits (always loaded)
  ---------------------------------------------------------------------------
  { "williamboman/mason.nvim", lazy = false, config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    event  = { "BufReadPre", "BufNewFile" },
    opts = {
      handlers = {},             
      automatic_installation = true,
      automatic_setup = true,
    },
  },

  ---------------------------------------------------------------------------
  -- 2. Bridge Mason ↔︎ null-ls  (makes sure formatters/linters are present)
  ---------------------------------------------------------------------------
  {
    "jay-babu/mason-null-ls.nvim",
    lazy = true,
    event  = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvimtools/none-ls.nvim", "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "black",
        "isort",
        "shfmt",
        "yamllint",
        "yamlfmt",
        "hadolint",
        "terraform_fmt",
        "shellcheck",
        "hadolint",
        "tflint",

      },
      automatic_installation = true,   
      automatic_setup        = true,     
      handlers               = {},      
    },
  },

  ---------------------------------------------------------------------------
  -- 3. null-ls itself  (other specs extend `opts.sources`)
  ---------------------------------------------------------------------------
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.sources = opts.sources or {}
      return opts
    end,
  },

  ---------------------------------------------------------------------------
  -- 4. LSPConfig – **must** be eager so servers register before BufRead
  ---------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event  = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },
}
