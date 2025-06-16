require("nvchad.options")

-- Diagnostics --------------------------------------------------------------
vim.diagnostic.config({
  virtual_text     = false,
  virtual_lines    = { current_line = true },
  float            = { source = "always" },
  signs            = {
    -- map each severity to your custom icon
    text = {
      [vim.diagnostic.severity.ERROR] = "☠",
      [vim.diagnostic.severity.WARN]  = "☣",
      [vim.diagnostic.severity.INFO]  = "ℹ",
      [vim.diagnostic.severity.HINT]  = "⚐",
    },
  },
  underline        = true,
  update_in_insert = false,
})

-- keep the sign column always visible
vim.wo.signcolumn     = "yes"
-- enable relative line numbers by default
vim.wo.relativenumber = true

-- Extra tweaks -------------------------------------------------------------
vim.o.cursorlineopt = "both"

