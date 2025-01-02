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
      }
  },
}
