-- ~/.config/nvim/init.lua
---------------------------------------------------------------
-- 0. Globals
---------------------------------------------------------------
vim.g.mapleader = " "
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"

---------------------------------------------------------------
-- 1. Bootstrap lazy.nvim (only if it isn’t already downloaded)
---------------------------------------------------------------
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------------
-- 2. Lazy-specific config (separate to keep init.lua tiny)
---------------------------------------------------------------
local lazy_cfg = require "configs.lazy" -- your existing file

---------------------------------------------------------------
-- 3. Start Lazy and load all specs
---------------------------------------------------------------
require("lazy").setup({
  -- Load NvChad’s core plugins first
  { "NvChad/NvChad", lazy = false, branch = "v2.5", import = "nvchad.plugins" },
  -- Everything under lua/plugins/**.lua
  { import = "plugins" },
}, lazy_cfg)

require("oil").setup()
require("mini.animate").setup()
-- require("mini.basics").setup()
---------------------------------------------------------------
-- 4. Load NvChad’s theme & statusline after base46 cache exists
---------------------------------------------------------------
dofile(vim.g.base46_cache .. "defaults") -- colours
dofile(vim.g.base46_cache .. "statusline") -- lualine wrapper

---------------------------------------------------------------
-- 5. Options, user autocmds, keymaps
---------------------------------------------------------------
require "options" -- your vim.opt settings

-- User autocmds that don’t belong in a plugin spec
local misc = vim.api.nvim_create_augroup("misc_augroup", { clear = true })

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = misc,
  pattern = "*",
  callback = function()
    pcall(vim.cmd.normal, 'g`"')
  end,
})

-- Load mappings *after* plugins so they can map plugin keys
vim.schedule(function()
  require "mappings"
end)

-- Recognize docker compose files
vim.filetype.add({
  pattern = {
    -- top-level files: docker-compose.yml / compose.yaml
    ["docker%-compose%.ya?ml"] = "yaml.docker-compose",
    ["compose%.ya?ml"]         = "yaml.docker-compose",

    -- any path that *contains* docker-compose somewhere
    [".*docker[_-]compose.*%.ya?ml"] = "yaml.docker-compose",
  },
})
