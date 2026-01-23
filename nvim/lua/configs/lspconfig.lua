-- ~/.config/nvim/lua/configs/lspconfig.lua

require("nvchad.configs.lspconfig").defaults()

local servers = {
  gopls = {},
  bashls = {},
  yamlls = {},
  dockerls = {},
  terraformls = {},
  pyright = {},
  ruff = {},
  postres_lsp = {},
  helm_ls = {},
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
