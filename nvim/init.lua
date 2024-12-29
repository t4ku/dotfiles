-- Basic settings (we'll add more here later)
vim.o.number = true
vim.o.tabstop = 2
vim.o.expandtab = true

-- Set the clipboard option to include 'unnamedplus'
vim.opt.clipboard:append("unnamedplus")

-- Plugin manager setup (we'll use lazy.nvim)
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)
-- require("lazy").setup("plugins") -- assumes your plugins will be in a 'plugins' directory

-- Keymaps (we'll convert these)
vim.g.mapleader = ","
