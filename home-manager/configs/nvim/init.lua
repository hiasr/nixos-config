-- General setup
-- Fix colors
vim.opt.termguicolors = true

-- Show live matching
vim.showmatch = true

-- Make matching caseinsensitive
vim.opt.ignorecase = true

-- Hide --INSERT--
vim.noshowmode = true

-- Fix tab stuff
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

-- Relative numbers except on current line
vim.opt.relativenumber = true
vim.opt.number = true

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Necessary for nvim-cmp
vim.opt.completeopt = { "menu", "menuone", "noselect" }


-- Setup Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Install if not installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("lazy").setup("plugins")

require('config')

