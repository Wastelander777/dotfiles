-- lua/configs/conform.lua

local formatters_by_ft = {
  lua = { "stylua" },
  python = { "black", "isort" },
  css = { "prettier" },
  html = { "prettier" },
  sh = { "shfmt" },
  yaml = { "yamlfmt" },
  terraform = { "terraform_fmt" },
  go = { "goimports" },
}

local format_on_save = {
  timeout_ms = 500,
  lsp_fallback = false,
}

return {
  formatters_by_ft = formatters_by_ft,
  format_on_save = format_on_save,
}
