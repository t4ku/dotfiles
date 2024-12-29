-- ~/.config/nvim/lua/plugins/plugins.lua
return {
  -- Git
  {
    'tpope/vim-fugitive',
    cmd = { "G", "Git", "GBrowse" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Fugitive status" },
      { "<leader>gb", "<cmd>GBrowse<cr>", desc = "Fugitive GBrowse" },
      -- { "gl", "<cmd>Gitv!<cr>", desc = "Gitv" },
    },
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
      }
  },
  -- File Explorer
  {
    'nvim-tree/nvim-tree.lua',
    version = "*",
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("nvim-tree").setup {
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      }
      -- keymaps
      vim.keymap.set('n', '<leader>nn', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
      vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>', { desc = 'Find current file in explorer' })
    end,
  },
  -- Other smaller plugins
  -- { 'tpope/vim-surround' },
  -- { 'tpope/vim-commentary' },
  -- { 'leafgarland/typescript-vim' },
  -- { 'peitalin/vim-jsx-typescript' },
  -- { 'majutsushi/tagbar' },
  -- ... more plugins ...
}
