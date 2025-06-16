-- lua/options.lua ----------------------------------------------------------
-- Pull in NvChad’s defaults first
require("nvchad.options")

-- Diagnostics --------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = false, virtual_lines = { current_line = true },
  float = {              -- opened with K or vim.diagnostic.open_float()
    source = "always",
  },
  signs            = false,   -- keep coloured gutter icons
  underline        = true,   -- red / yellow underlines
  update_in_insert = false,  -- don’t spam while typing
})

-- Extra tweaks -------------------------------------------------------------
-- Uncomment to highlight the whole line & number of the cursor position
vim.o.cursorlineopt = "both"

