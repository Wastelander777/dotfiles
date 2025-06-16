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

-- lua/options.lua  (or at the end of init.lua)
vim.diagnostic.config({
  virtual_text = {                -- inline text under the code
    source = "always",            -- always show “[source]”
  },
  float = {                       -- popup opened with `K` / open_float()
    source = "always",            -- always show “[source]”
  },
  signs = true,                   -- gutter icons keep their colours
})


-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
