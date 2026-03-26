-- lua/configs/conform.lua

local formatters_by_ft = {
  lua = { "stylua" },
  python = { "ruff" },
  css = { "prettier" },
  html = { "prettier" },
  sh = { "shfmt" },
  yaml = { "yamlfmt" },
  go = { "goimports" },
  sql = { "sqlfluff" },
  pgsql = { "sqlfluff" },
}

local format_on_save = {
  timeout_ms = 500,
  lsp_fallback = false,
}

return {
  formatters_by_ft = formatters_by_ft,
  format_on_save = format_on_save,
}
