-- File: init.lua

-- 1. Bootstrap mini.nvim if not installed
local path_package = vim.fn.stdpath "data" .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.nvim"

if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`..." | redraw'
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    -- '--branch', 'stable',  -- Uncomment if you want the stable branch
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd "packadd mini.nvim | helptags ALL"
end

-- 2. Global variables
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- Set indentation options for all files
vim.opt.autoindent = true
-- vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 3. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- 4. Load lazy config
local lazy_config = require "configs.lazy"

-- 5. Setup lazy.nvim (loading all plugin specs)
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" }, -- imports your lua/plugins/*.lua specs
}, lazy_config)

-- 6. Load theme + UI config from NvChad
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- 7. Load general Neovim options / NVChad autocommands
require "options"
require "nvchad.autocmds"

-----------------------------------------------------------------------
-- AUTOCMDs
-----------------------------------------------------------------------
-- Format Terraform on save (again, recommended to do in your LSP config)
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Group for miscellaneous autocmds
local misc_augroup = vim.api.nvim_create_augroup("misc_augroup", { clear = true })

-- Restore cursor to last position
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position it was edited earlier",
  group = misc_augroup,
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

-----------------------------------------------------------------------
-- TREESITTER SETUP
-----------------------------------------------------------------------
-- If you're not configuring nvim-treesitter in a plugin spec, do it here:
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "python",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "yaml",
    "java",
    "xml",
    "bash",
  },
  sync_install = true,
  auto_install = true,
  sync_root_with_cwd = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

-----------------------------------------------------------------------
-- OTHER PLUGINS
-----------------------------------------------------------------------
-- For example, if `oil.nvim` or mini plugins aren’t configured in plugin specs:
require("oil").setup()
require("mini.animate").setup()
require("mini.basics").setup()

-----------------------------------------------------------------------
-- KEY MAPPINGS
-----------------------------------------------------------------------
-- If you prefer to load key mappings after everything else:
vim.schedule(function()
  require "mappings" -- your custom mappings
end)
