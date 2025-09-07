return {
  {
    'jremmen/vim-ripgrep',
    config = function()
      -- Use ripgrep's smart case by default
      vim.g.rg_command = 'rg --vimgrep --smart-case'
      -- Derive root directory (useful for monorepos and projects)
      vim.g.rg_derive_root = true
      -- Highlight matches in results
      vim.g.rg_highlight = true
      
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      
      -- Basic search - opens prompt for pattern
      -- keymap('n', '<leader>r', ':Rg<space>', { noremap = true })
      
      -- Search word under cursor
      keymap('n', '<leader>R', ':Rg <C-r><C-w><CR>', opts)
      
      -- Quickfix navigation
      -- keymap('n', ']q', ':cnext<CR>zz', opts)
      -- keymap('n', '[q', ':cprev<CR>zz', opts)
      -- keymap('n', ']Q', ':clast<CR>zz', opts)
      -- keymap('n', '[Q', ':cfirst<CR>zz', opts)
      
      -- Quickfix window management
      -- keymap('n', '<leader>qo', ':copen<CR>', opts)
      -- keymap('n', '<leader>qc', ':cclose<CR>', opts)
      -- 
      -- Common search patterns as commands
      vim.api.nvim_create_user_command('Todo', 'Rg "TODO|FIXME|XXX|NOTE|HACK"', {})
      -- vim.api.nvim_create_user_command('Debug', 'Rg "debugger|console.log|print|puts|pp|p "', {})
    end
  }
}
