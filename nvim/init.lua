-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Basic settings (we'll add more here later)
vim.o.number = true
vim.o.tabstop = 2
vim.o.expandtab = true
-- equivalent of `filetype plugin indent on`
vim.cmd("filetype plugin indent on")

vim.o.termguicolors = true


-- alias
-- Expand current directory in command mode
-- Similar to cnoremap <Leader>e <c-r>=expand("%:h")<cr>
vim.keymap.set("c", "<Leader>e", function()
  local dir = vim.fn.expand("%:h")
  vim.api.nvim_feedkeys(vim.fn.expand(dir), "n", true)
end, { desc = "Expand current file directory" })

-- Copy filepath to clipboard
-- Similar to noremap <Leader>yp :let @*=expand('%:p')<CR>
vim.keymap.set("n", "<Leader>yp", function()
  local full_path = vim.fn.expand("%:p")
  vim.fn.setreg("*", full_path)
  vim.notify("Copied full path: " .. full_path)
end, { desc = "Copy full file path to clipboard" })

-- Copy filename to clipboard
-- Similar to noremap <Leader>yf :let @*=expand('%:t')<CR>
vim.keymap.set("n", "<Leader>yf", function()
  local filename = vim.fn.expand("%:t")
  vim.fn.setreg("*", filename)
  vim.notify("Copied filename: " .. filename)
end, { desc = "Copy filename to clipboard" })

-- Set the clipboard option to include 'unnamedplus'
vim.opt.clipboard:append("unnamedplus")

require("config.lazy")
