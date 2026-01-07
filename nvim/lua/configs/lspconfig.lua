-- File: lua/configs/lspconfig.lua  (loaded from plugins/mason.lua)

local nvlsp = require "nvchad.configs.lspconfig"
local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local caps = nvlsp.capabilities
local configs = require "lspconfig.configs"
local util = require "lspconfig.util"

if not configs.ruff_lsp then
  configs.ruff_lsp = {
    default_config = {
      cmd = { "ruff" },
      filetypes = { "python" },
      root_dir = util.root_pattern("pyproject.toml", "ruff.toml", ".git"),
      single_file_support = true,
    },
    docs = { description = "Ruff Python language server" },
  }
end

local default_servers = {
  "lemminx",
  "jdtls",
  "ruff",
}

for _, name in ipairs(default_servers) do
  vim.lsp.config(name, {
    on_init = on_init,
    capabilities = caps,
    flags = { debounce_text_changes = 300 },
  })
end

vim.lsp.enable(default_servers)
