vim.g.mapleader = " "
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"

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

local lazy_cfg = require "configs.lazy"

require("lazy").setup({
  { "NvChad/NvChad", lazy = false, branch = "v2.5", import = "nvchad.plugins" },
  { import = "plugins" },
}, lazy_cfg)

require("oil").setup()

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

vim.cmd "syntax off"

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

require "options"

local misc = vim.api.nvim_create_augroup("misc_augroup", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = misc,
  pattern = "*",
  callback = function()
    pcall(vim.cmd.normal, 'g`"')
  end,
})

vim.schedule(function()
  require "mappings"
end)

vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}

vim.filetype.add {
  pattern = {
    ["docker%-compose%.ya?ml"] = "yaml.docker-compose",
    ["compose%.ya?ml"] = "yaml.docker-compose",
    [".*docker[_-]compose.*%.ya?ml"] = "yaml.docker-compose",
  },
}
