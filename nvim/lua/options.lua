require("nvchad.options")

vim.diagnostic.config({
  -- virtual text overrided at init.lua
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
-- Tweaks
vim.wo.signcolumn     = "yes"
vim.wo.relativenumber = true
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.cursorlineopt = "both"

