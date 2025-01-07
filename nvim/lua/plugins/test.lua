return {
  {
    "vim-test/vim-test",
    dependencies = {
      "jgdavey/tslime.vim",
    },
    keys = {
      -- vim-test mappings
      { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test nearest" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test file" },
      { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test suite" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
      { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Test visit" },
    },
    cmd = { "TestNearest", "TestFile", "TestLast" },
    config = function()
      -- Use tslime strategy for running tests
      vim.g['test#strategy'] = "tslime"
      -- Configure tslime to always use current session/window
      vim.g.tslime_always_current_session = 1
      vim.g.tslime_always_current_window = 1
      -- Preserve screen and hide command echo
      vim.g['test#preserve_screen'] = 1
      vim.g['test#echo_command'] = 0

      -- Helper to get current test configuration key
      local function get_test_config_key()
        local ft = vim.bo.filetype
        if ft == 'ruby' then
          return 'test#ruby#rspec#executable'
        elseif ft == 'python' then
          return 'test#python#pytest#executable'
        elseif ft == 'javascript' or ft == 'typescript' or ft == 'javascriptreact' or ft == 'typescriptreact' then
          return 'test#javascript#jest#executable'
        end
        return nil
      end
      -- Command to set test executable
      -- TestExecutable docker-compose exec api pytest
      vim.api.nvim_create_user_command('TestExecutable', function(opts)
        local config_key = get_test_config_key()
        if not config_key then
          vim.notify('Unsupported file type: ' .. vim.bo.filetype, vim.log.levels.ERROR)
          return
        end

        if opts.args and opts.args ~= '' then
          vim.g[config_key] = opts.args
          vim.notify('Test executable set to: ' .. opts.args)
        else
          -- Show current executable if no args provided
          local current = vim.g[config_key]
          if current then
            vim.notify('Current test executable: ' .. current)
          else
            vim.notify('No test executable set')
          end
        end
      end, {
        nargs = '?',
        complete = function()
          return {
            'docker-compose exec web bundle exec rspec',
            'docker-compose exec api pytest',
            'npm test',
            'bundle exec rspec',
            'python -m pytest',
          }
        end
      })

      -- Reset both tslime and test executable settings
      vim.api.nvim_create_user_command('TestReset', function()
        -- Reset tslime
        vim.cmd('unlet! g:tslime')
        -- Reset test executable
        local config_key = get_test_config_key()
        if config_key and vim.g[config_key] then
          vim.g[config_key] = nil
        end
        vim.notify('Test configuration reset')
      end, {})
      -- Key mapping to reset config
      vim.keymap.set('n', '<Leader>tr', ':TestReset<CR>',
        { desc = 'Reset test configuration' })
    end,
  },
}
