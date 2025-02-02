local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  -- Configuración para formateo automático al guardar
  format_on_save = {
    -- Estas opciones se pasarán a conform.format()
    timeout_ms = 500,  -- Tiempo de espera para el formateo
    lsp_fallback = true,  -- Usa LSP como fallback si el formateador no está disponible
  },
}

return options

