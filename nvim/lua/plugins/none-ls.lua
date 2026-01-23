-- lua/plugins/none-ls.lua
return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local nls = require("null-ls")

    return {
      sources = {
        -- Python
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort,

        -- Shell
        nls.builtins.formatting.shfmt,

        -- YAML
        nls.builtins.formatting.yamlfmt,

        -- Terraform
        nls.builtins.formatting.terraform_fmt,

        -- Go
        nls.builtins.formatting.goimports,

      },
    }
  end,
}

