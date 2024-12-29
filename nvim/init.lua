-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Basic settings (we'll add more here later)
vim.o.number = true
vim.o.tabstop = 2
vim.o.expandtab = true

-- Set the clipboard option to include 'unnamedplus'
vim.opt.clipboard:append("unnamedplus")

require("config.lazy")
