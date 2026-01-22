-- lua/plugins/lint.lua
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      go = { "golangcilint" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
      dockerfile = { "hadolint" },
      terraform = { "tflint" },
    }

    vim.api.nvim_create_autocmd(
      { "BufWritePost", "InsertLeave" },
      {
        callback = function()
          lint.try_lint()
        end,
      }
    )
  end,
}

