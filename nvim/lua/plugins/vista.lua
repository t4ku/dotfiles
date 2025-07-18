return {
  'liuchengxu/vista.vim',
  cmd = 'Vista',
  lazy = true,
  init = function()
    -- Disable all Vista autocommands by default
    vim.g.vista_disable_statusline = 1
    vim.g.vista_echo_cursor = 0
    vim.g.vista_update_on_text_changed = 0
    vim.g.vista_blink = {0, 0}
    
    -- Disable Vista completely for markdown files
    vim.api.nvim_create_autocmd({"BufEnter", "FileType"}, {
      pattern = {"*.md", "*.markdown", "markdown"},
      callback = function()
        vim.b.vista_skip = 1
        -- Clear any existing Vista autocommands for this buffer
        pcall(function()
          vim.cmd('silent! autocmd! vista BufEnter <buffer>')
        end)
      end,
    })
  end,
  keys = {
    { '<leader>vv', '<cmd>Vista!!<cr>', desc = 'Toggle Vista' },
    { '<leader>vf', '<cmd>Vista finder<cr>', desc = 'Vista Finder' },
    { '<leader>vt', '<cmd>Vista toc<cr>', desc = 'Vista TOC (Markdown)', ft = 'markdown' },
  },
  config = function()
    -- Set default executive to nvim_lsp
    vim.g.vista_default_executive = 'nvim_lsp'
    
    -- Use specific executives for different file types
    vim.g.vista_executive_for = {
      markdown = 'toc',
      text = 'ctags',
    }
    
    -- Disable automatic features that might trigger LSP
    vim.g.vista_disable_statusline = 1
    vim.g.vista_echo_cursor = 0
    vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
    vim.g.vista_fzf_preview = { 'right:50%' }
    vim.g.vista_sidebar_width = 40
    vim.g.vista_cursor_delay = 400
    vim.g.vista_close_on_jump = 0
    vim.g.vista_stay_on_open = 1
    vim.g.vista_blink = { 2, 100 }
    
    -- Markdown TOC specific settings
    vim.g.vista_markdown_executive = 'toc'
    vim.g.vista_toc_position = 'vertical topleft'
    vim.g.vista_ignore_kinds = { 'Variable' }
    
    -- Disable auto-update to prevent LSP errors
    vim.g.vista_update_on_text_changed = 0
    vim.g.vista_update_on_text_changed_delay = 500
  end,
}