-- ~/.config/nvim/lua/plugins/plugins.lua
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
  -- nvim/lua/plugins/lualine.lua
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#default-configuration
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  }
    
  -- Other smaller plugins
  -- { 'tpope/vim-surround' },
  -- { 'tpope/vim-commentary' },
  -- { 'leafgarland/typescript-vim' },
  -- { 'peitalin/vim-jsx-typescript' },
  -- { 'majutsushi/tagbar' },
  -- ... more plugins ...
}
