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
-- Tab navigation
vim.keymap.set("n", "<Tab>", "gt", { desc = "Next tab" })
vim.keymap.set("n", "<S-Tab>", "gT", { desc = "Previous tab" })
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

-- Copy relative filepath to clipboard (with ./ prefix)
vim.keymap.set("n", "<Leader>yr", function()
  local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  local path_with_prefix = relative_path:match("^%./") and relative_path or "./" .. relative_path
  vim.fn.setreg("*", path_with_prefix)
  vim.notify("Copied relative path: " .. path_with_prefix)
end, { desc = "Copy relative file path to clipboard" })

-- Set the clipboard option to include 'unnamedplus'
vim.opt.clipboard:append("unnamedplus")

-- PKM
-- add timestamp entry to makrdown
vim.api.nvim_create_user_command('InsertTimestampTitle', function()
  -- Prompt user for a title
  local title = vim.fn.input('Title: ')
  if title == "" then
    title = "PKM"
  end
  local ts = os.date("(ts: %Y-%m-%d %H:%M)")
  local line = "### " .. title .. " " .. ts
  vim.api.nvim_put({line}, 'l', true, true)
end, {})
vim.keymap.set('n', '<leader>ti', '<cmd>InsertTimestampTitle<CR>')

-- Inbox Capture Commands
vim.api.nvim_create_user_command('InboxCapture', function()
  require('inbox_capture').create()
end, { desc = 'Create new inbox capture' })

vim.api.nvim_create_user_command('InboxQuick', function()
  require('inbox_capture').quick_capture()
end, { desc = 'Quick inbox capture' })

vim.api.nvim_create_user_command('InboxList', function()
  require('inbox_capture').list_today()
end, { desc = 'List today\'s inbox captures' })

vim.api.nvim_create_user_command('InboxProcess', function()
  require('inbox_capture').process_today()
end, { desc = 'Process today\'s inbox items' })

vim.api.nvim_create_user_command('InboxUnprocessed', function()
  require('inbox_capture').list_unprocessed()
end, { desc = 'List unprocessed inbox items' })

vim.api.nvim_create_user_command('InboxSearch', function()
  require('inbox_capture').search_inbox()
end, { desc = 'Search inbox with telescope' })

-- Inbox Capture Keybindings
vim.keymap.set('n', '<leader>oi', ':InboxCapture<CR>', { desc = 'Capture to inbox' })
vim.keymap.set('n', '<leader>oiq', ':InboxQuick<CR>', { desc = 'Quick capture to inbox' })
vim.keymap.set('n', '<leader>oil', ':InboxList<CR>', { desc = 'List today inbox' })
vim.keymap.set('n', '<leader>oip', ':InboxProcess<CR>', { desc = 'Process inbox' })
vim.keymap.set('n', '<leader>oiu', ':InboxUnprocessed<CR>', { desc = 'List unprocessed inbox' })
vim.keymap.set('n', '<leader>ois', ':InboxSearch<CR>', { desc = 'Search inbox' })

-- Visual mode capture
vim.keymap.set('v', '<leader>oic', function()
  require('inbox_capture').capture_selection()
end, { desc = 'Capture selection to inbox' })

require("config.lazy")
-- autocmd BufReadPost *.kt setlocal filetype=kotlin
-- above in lua
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.kt",
  callback = function()
    vim.bo.filetype = "kotlin"
  end,
})

