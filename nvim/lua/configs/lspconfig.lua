-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
require("lspconfig").yamlls.setup {}
require("lspconfig").terraformls.setup {}
require("lspconfig").jdtls.setup {}
local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "pyright", "lua_ls", "ruff", "yamlls", "terraformls", "jdtls", "lemminx","bashls"}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup {
  sources = {
    require("null-ls").builtins.formatting.black,
    require("null-ls").builtins.formatting.isort,
    require("null-ls").builtins.formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = true }
        end,
      })
    end
  end,
}

-- Import the necessary modules
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- Files to detect the root directory
local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
}

-- Command to organize imports using Pyright
local function organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }

  local clients = vim.lsp.get_active_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  }
  for _, client in ipairs(clients) do
    client.request("workspace/executeCommand", params, nil, 0)
  end
end

-- Command to set Python path in Pyright
local function set_python_path(path)
  local clients = vim.lsp.get_active_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  }
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    end
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

-- Register Pyright as the LSP server for Python
lspconfig.pyright.setup {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = function(fname)
    return util.root_pattern(unpack(root_files))(fname)
  end,
  single_file_support = true,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
  commands = {
    PyrightOrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
    PyrightSetPythonPath = {
      set_python_path,
      description = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
    },
  },
}

local util = require "lspconfig.util"

local root_files = {
  "pyproject.toml",
  "ruff.toml",
}

return {
  default_config = {
    cmd = { "ruff" },
    filetypes = { "python" },
    root_dir = util.root_pattern(unpack(root_files)) or util.find_git_ancestor(),
    single_file_support = true,
    settings = {},
  },
  docs = {
    description = [[
  ]],
    root_dir = [[root_pattern("pyproject.toml", "ruff.toml", ".git")]],
  },
}

