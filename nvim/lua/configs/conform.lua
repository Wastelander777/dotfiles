-- Formatter configuration per filetype
local formatters_by_ft = {
  lua     = { "stylua"            }, -- Lua
  python  = { "black", "isort"   }, -- Python
  css     = { "prettier"         }, -- CSS
  html    = { "prettier"         }, -- HTML
  sh      = { "shfmt"            }, -- Shell scripts
  yaml    = { "yamlfmt", "yamllint" }, -- YAML
  Dockerfile = { "hadolint"      }, -- Dockerfiles
  terraform   = { "terraform_fmt", "tflint" }, -- Terraform
}

-- Auto-format on save
local format_on_save = {
  timeout_ms   = 500,   -- max wait for formatting
  lsp_fallback = true,  -- fall back to LSP if external tool missing
}

return {
  formatters_by_ft    = formatters_by_ft,
  format_on_save      = format_on_save,
}
