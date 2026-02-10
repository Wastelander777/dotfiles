-- ~/.config/nvim/lua/configs/lspconfig.lua

require("nvchad.configs.lspconfig").defaults()

local servers = {
  gopls = {},
  bashls = {},
  yamlls = {},
  dockerls = {},
  terraformls = {},
  postgres_lsp = {},
  helm_ls = {},
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "standard",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
          diagnosticSeverityOverrides = {
            reportUnusedImport = "warning",
            reportOptionalSubscript = "none",
            reportAny = "none",
            reportExplicitAny = "none",
          },
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
