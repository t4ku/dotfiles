return {
  -- Git
  {
    'tpope/vim-fugitive',
    -- cmd = { "G", "Git", "GBrowse" },
    -- keys = {
    --   { "<leader>gs", "<cmd>Git<cr>", desc = "Fugitive status" },
    --   { "<leader>gb", "<cmd>GBrowse<cr>", desc = "Fugitive GBrowse" },
    --   -- { "gl", "<cmd>Gitv!<cr>", desc = "Gitv" },
    -- },
  },
  {
    'tpope/vim-rhubarb',
  },
  -- {
  --   'gbrlsnchs/vim-gitv',
  --   cmd = { 'Gitv' },
  -- },
  {
      "sindrets/diffview.nvim",
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
      cmd = {
          "DiffviewOpen",
          "DiffviewFileHistory",
      },
      keys = {
        { "<leader>df","<cmd>DiffviewOpen<cr>", desc = "Open Difview window" },
        { "<leader>dc","<cmd>DiffviewClose<cr>", desc = "Close Difview window" }
      },
      -- pass by opts
      -- opts = {
      --   keymaps = {
      --     file_panel = {
      --       { "n", "cc", "<Cmd>Git commit | wincmd J<CR>", { desc = "Commit staged changes" } },
      --     }
      --   }
      -- }
      -- pass by config block 
      config = function()
        require("diffview").setup({
          keymaps = {
            disable_defaults = false,  -- keep default mappings
            file_panel = {
              -- Adding our commit mapping while preserving defaults
              -- { "n", "cc", "<Cmd>Git commit | wincmd J<CR>", { desc = "Commit staged changes" } },
              { "n", "cc",
                function()
                  -- Open commit in a floating window
                  -- Open Git commit
                  vim.cmd('Git commit')

                  -- Get the current window and configure it as floating
                  local win = vim.api.nvim_get_current_win()
                  local buf = vim.api.nvim_get_current_buf()

                  -- Calculate center position
                  local width = math.floor(vim.o.columns * 0.8)
                  local height = math.floor(vim.o.lines * 0.8)
                  local row = math.floor((vim.o.lines - height) / 2)
                  local col = math.floor((vim.o.columns - width) / 2)

                  -- Set window configuration
                  vim.api.nvim_win_set_config(win, {
                    relative = 'editor',
                    width = width,
                    height = height,
                    row = row,
                    col = col,
                    style = 'minimal',
                    border = 'rounded'
                  })
                end,
                { desc = "Commit staged changes" }
              }
            }
          }
        })
      end,
  },
}
