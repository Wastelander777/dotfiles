require "nvchad.options"
-- Enable inline diagnostics globally
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",   -- or "■", "▶", "", to match your taste
    spacing = 2,
  },
  signs = true,       -- keep the sign-column icons
  underline = true,   -- red/yellow underlines
  update_in_insert = false,
})

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
