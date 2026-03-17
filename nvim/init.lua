vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- config
require("oil").setup()
require "options"
require "configs.lspconfig"
require("nvim-treesitter").install {
  "go",
  "python",
  "bash",
  "sql",
  "lua",
  "yaml",
  "html",
  "json",
}

vim.schedule(function()
  require "mappings"
end)
vim.diagnostic.config({virtual_text = false})
-- filetypes
vim.filetype.add {
  pattern = {
    ["docker%-compose%.ya?ml"] = "yaml.docker-compose",
    ["compose%.ya?ml"] = "yaml.docker-compose",
    [".*docker[_-]compose.*%.ya?ml"] = "yaml.docker-compose",
  },
}
