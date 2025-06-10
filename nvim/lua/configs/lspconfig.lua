-- File: lua/configs/lspconfig.lua  (loaded from plugins/mason.lua)

------------------------------------------------------------------
-- 0.  Boilerplate: pull in NvChad helpers
------------------------------------------------------------------
local nvlsp = require "nvchad.configs.lspconfig"
local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local caps = nvlsp.capabilities

------------------------------------------------------------------
-- 1.  Register extra servers *once* (Ruff in this example)
------------------------------------------------------------------
local lspconfig = require "lspconfig"
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

------------------------------------------------------------------
-- 2.  List the servers you really want the generic setup for
------------------------------------------------------------------
local default_servers = {
  "lemminx",
  "jdtls",
}

for _, name in ipairs(default_servers) do
  lspconfig[name].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = caps,
  }
end

------------------------------------------------------------------
-- 3.  Special-case servers (do **not** repeat them in the list)
------------------------------------------------------------------
-- YAML – add schemas, for example
lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = caps,
  settings = {
    yaml = {
      keyOrdering = false,
      schemas = {
        kubernetes = "/*.k8s.yaml",
      },
    },
  },
}

-- Terraform – no extra settings, but kept separate so you can tweak later
lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = caps,
}

------------------------------------------------------------------
-- 4.  Null-LS
------------------------------------------------------------------
local nls      = require "null-ls"
local augroup  = vim.api.nvim_create_augroup("LspFormatting", {})

nls.setup {
  sources = {
    nls.builtins.formatting.black,
    nls.builtins.formatting.isort,
    nls.builtins.formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
}

