-- Mason, LSP + null-ls glue
return {
  ---------------------------------------------------------------------------
  -- 1. Core Mason bits (always loaded)
  ---------------------------------------------------------------------------
  { "williamboman/mason.nvim", lazy = false, config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = { handlers = {} }, -- ← critical line
  },

  -- Optional helper that installs binaries on NVim start-up
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    opts = {
      ensure_installed = {}, -- language-specific specs extend this
      run_on_start = true, -- fetch missing tools automatically
    },
  },

  ---------------------------------------------------------------------------
  -- 2. Bridge Mason ↔︎ null-ls  (makes sure formatters/linters are present)
  ---------------------------------------------------------------------------
  {
    "jay-babu/mason-null-ls.nvim",
    lazy = false,
    dependencies = { "nvimtools/none-ls.nvim", "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "black",
        "isort",
        "mypy",
        "shfmt",
        "yamllint",
        "yamlfmt",
        "hadolint",
        "terraform_fmt", -- alias recognised by mason-null-ls
      },
      automatic_installation = true,
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
    lazy = false,
    config = function()
      require "configs.lspconfig"
    end,
  },
}
