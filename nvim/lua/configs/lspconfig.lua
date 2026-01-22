-- ~/.config/nvim/lua/configs/lspconfig.lua

local defaults = require("nvchad.configs.lspconfig")

local servers = {
  gopls = {},
  bashls = {},
  yamlls = {},
  dockerls = {},
  terraformls = {},
  ruff = {},
}

for name, config in pairs(servers) do
  vim.lsp.config(name, vim.tbl_extend("force", {
    on_attach = defaults.on_attach,
    on_init = defaults.on_init,
    capabilities = defaults.capabilities,
  }, config))
end

vim.lsp.enable(vim.tbl_keys(servers))

