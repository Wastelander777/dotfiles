-- Install 'mini.nvim' if not already present
local path_package = vim.fn.stdpath "data" .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.nvim"

if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    -- Uncomment next line to use the 'stable' branch of mini.nvim
    -- '--branch', 'stable',
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd "packadd mini.nvim | helptags ALL"
end

-- Set global variables for cache path and leader key
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " " -- Use space as the leader key

-- Bootstrap 'lazy.nvim' and load plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- Load 'lazy.nvim' configuration
local lazy_config = require "configs.lazy"

-- Setup 'lazy.nvim' with plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false, -- Load NvChad immediately
    branch = "v2.5", -- Specify branch version
    import = "nvchad.plugins", -- Import NvChad plugin settings
  },
  { import = "plugins" }, -- Import additional plugins defined in 'plugins.lua'
}, lazy_config)

-- Load the theme settings
dofile(vim.g.base46_cache .. "defaults") -- Load theme defaults
dofile(vim.g.base46_cache .. "statusline") -- Load statusline configuration

-- Load Neovim options and autocommands
require "options"
require "nvchad.autocmds"

-- Schedule mappings after other components have loaded
vim.schedule(function()
  require "mappings"
end)

-- Restore cursor to last edited position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position it was edited earlier",
  group = misc_augroup,
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

-- Setup 'nvim-treesitter' with automatic parser installation
require("nvim-treesitter.configs").setup {
  -- List of parsers to ensure are always installed
  ensure_installed = {
    "c",
    "python",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "yaml",
    "terraform",
  },
  sync_install = true, -- Install parsers synchronously
  auto_install = true, -- Automatically install missing parsers
  sync_root_with_cwd = true, -- Automatically refresh directory
}

-- Setup additional plugins
require("oil").setup() -- File explorer plugin
-- require("mini.align").setup()   -- Text alignment plugin
-- require('mini.ai').setup()    -- Advanced text objects (commented out for now)
require("mini.animate").setup() -- Smooth scrolling and window transitions
require("mini.basics").setup() -- Basic settings like better mappings

require'lspconfig'.terraformls.setup{}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})
