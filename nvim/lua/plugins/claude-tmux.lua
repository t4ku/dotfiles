-- Claude Code tmux integration
-- Send file references to Claude Code running in tmux pane

return {
  name = "claude-tmux",
  dir = vim.fn.stdpath("config") .. "/lua/plugins/claude-tmux-dummy",
  lazy = false,
  enabled = true,
  cond = true,
  init = function()
    -- Helper function to send content to tmux pane
    local function send_to_tmux(content, target_pane)
      target_pane = target_pane or vim.g.claude_pane or '1'
      
      -- Check if tmux is running
      local tmux_check = vim.fn.system('tmux list-sessions 2>/dev/null')
      if vim.v.shell_error ~= 0 then
        vim.notify('Tmux is not running', vim.log.levels.ERROR)
        return false
      end
      
      -- Escape content properly for shell
      local escaped_content = vim.fn.shellescape(content)
      local cmd = string.format("tmux send-keys -t %s %s Enter", target_pane, escaped_content)
      
      -- Debug: show the command being run
      vim.notify('Running: ' .. cmd, vim.log.levels.INFO)
      
      local output = vim.fn.system(cmd)
      if vim.v.shell_error == 0 then
        vim.notify('Sent to Claude: ' .. content, vim.log.levels.INFO)
        return true
      else
        vim.notify('Failed to send to tmux pane ' .. target_pane .. '\nError: ' .. output, vim.log.levels.ERROR)
        return false
      end
    end

    -- Function to send file reference to Claude Code
    local function send_claude_reference()
      -- Ensure we're in normal mode
      local mode = vim.fn.mode()
      if mode == 'i' or mode == 'I' then
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes('<esc>', true, false, true), 
          'x', true
        )
      end
      
      local filepath = vim.fn.expand('%:p')
      local reference
      
      if mode == 'v' or mode == 'V' then
        -- Exit visual mode first to get proper marks
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes('<esc>', true, false, true), 
          'x', true
        )
        
        -- Small delay to ensure marks are set
        vim.defer_fn(function()
          local start_line = vim.fn.line("'<")
          local end_line = vim.fn.line("'>")
          reference = string.format("@%s#L%d-%d", filepath, start_line, end_line)
          send_to_tmux(reference, vim.g.claude_pane)
        end, 50)
      else
        -- Normal mode: send current line
        local line = vim.fn.line('.')
        reference = string.format("@%s#L%d", filepath, line)
        send_to_tmux(reference, vim.g.claude_pane)
      end
    end

    -- Function to send file reference without line numbers
    local function send_claude_file()
      local filepath = vim.fn.expand('%:p')
      local reference = string.format("@%s", filepath)
      send_to_tmux(reference, vim.g.claude_pane)
    end

    -- Function to send selected text with context
    local function send_claude_selection_context()
      local mode = vim.fn.mode()
      if mode ~= 'v' and mode ~= 'V' then
        vim.notify('This command works only in visual mode', vim.log.levels.WARN)
        return
      end
      
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<esc>', true, false, true), 
        'x', true
      )
      
      vim.defer_fn(function()
        local filepath = vim.fn.expand('%:p')
        local start_line = math.max(1, vim.fn.line("'<") - 5)
        local end_line = math.min(vim.fn.line('$'), vim.fn.line("'>") + 5)
        
        local reference = string.format("@%s#L%d-%d", filepath, start_line, end_line)
        local note = string.format(" (selected L%d-%d with context)", 
          vim.fn.line("'<"), vim.fn.line("'>"))
        
        send_to_tmux(reference .. note, vim.g.claude_pane)
      end, 50)
    end

    -- Function to set target tmux pane
    local function set_claude_pane()
      vim.ui.input({
        prompt = 'Claude pane (number or name): ',
        default = vim.g.claude_pane or '1',
      }, function(input)
        if input then
          vim.g.claude_pane = input
          vim.notify('Claude pane set to: ' .. input, vim.log.levels.INFO)
        end
      end)
    end

    -- Function to send all open buffers as context
    local function send_all_buffers()
      local references = {}
      
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_option(bufnr, 'buflisted') then
          local filepath = vim.api.nvim_buf_get_name(bufnr)
          if filepath ~= '' and not filepath:match('^term://') then
            table.insert(references, '@' .. filepath)
          end
        end
      end
      
      if #references > 0 then
        local message = "Context files: " .. table.concat(references, ' ')
        send_to_tmux(message, vim.g.claude_pane)
      else
        vim.notify('No files to send', vim.log.levels.WARN)
      end
    end

    -- Set up keymaps
    vim.keymap.set({'n', 'v'}, '<leader>cc', send_claude_reference, {
      desc = 'Send file:line reference to Claude Code',
      silent = false  -- Changed to false to see notifications
    })
    
    vim.keymap.set('n', '<leader>cf', send_claude_file, {
      desc = 'Send file reference to Claude Code (no line)',
      silent = true
    })
    
    vim.keymap.set('v', '<leader>cx', send_claude_selection_context, {
      desc = 'Send selection with context to Claude Code',
      silent = true
    })
    
    vim.keymap.set('n', '<leader>ct', set_claude_pane, {
      desc = 'Set Claude Code target tmux pane',
      silent = true
    })
    
    vim.keymap.set('n', '<leader>ca', send_all_buffers, {
      desc = 'Send all open buffers to Claude Code',
      silent = true
    })

    -- Initialize default pane
    vim.g.claude_pane = vim.g.claude_pane or '1'
    
    -- Mark as loaded
    vim.g.claude_tmux_loaded = true
  end,
}