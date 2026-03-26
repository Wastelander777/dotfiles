-- lua/plugins/none-ls.lua
return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local nls = require("null-ls")

    return {
      sources = {
        -- Shell
        nls.builtins.formatting.shfmt,

        -- YAML
        nls.builtins.formatting.yamlfmt,

        -- Go
        nls.builtins.formatting.goimports,

        -- SQL
        nls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),

      },
    }
  end,
}

