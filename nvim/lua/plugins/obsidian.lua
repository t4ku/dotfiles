return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see above for full list of optional dependencies ☝️
  },
  ---@module 'obsidian'
  ---@type obsidian.config.ClientOpts
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Code/syla/syla-daily",
      },
      -- {
      --   name = "work",
      --   path = "~/vaults/work",
      -- },
    },

    notes_subdir = "Inbox", -- subdirectory in your vault where your notes are stored
    new_notes_location = "notes_subdir", -- or "current" to place new notes in the current directory
    
    -- Custom note ID function for readable filenames
    note_id_func = function(title)
      -- Use title as filename (no ID prefix)
      if title ~= nil then
        -- Convert to kebab-case: "My Note Title" -> "my-note-title"
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- Fallback to timestamp if no title
        return tostring(os.time())
      end
    end,
    -- see below for full list of options 👇
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
    
    -- Custom command for adding frontmatter
    vim.api.nvim_create_user_command("ObsidianAddFrontmatter", function()
      local util = require("obsidian.util")
      
      -- Generate Zettel ID (timestamp-XXXX format)
      local id = util.zettel_id()
      
      -- Get current filename without extension for title
      local filename = vim.fn.expand("%:t:r")
      
      -- Create kebab-case version for alias
      local kebab_alias = filename:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      
      -- Insert frontmatter at top of buffer
      local frontmatter = {
        "---",
        "id: " .. id,
        'aliases: ["' .. kebab_alias .. '"]',
        "tags: []",
        "title: " .. filename,
        "date: " .. os.date("%Y-%m-%d"),
        "---",
        ""
      }
      
      vim.api.nvim_buf_set_lines(0, 0, 0, false, frontmatter)
      vim.cmd("write")
      print("Added frontmatter with ID: " .. id)
    end, { desc = "Add obsidian frontmatter to current file" })
    
    -- Optional keybinding (only for markdown files)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.keymap.set("n", "<leader>of", "<cmd>ObsidianAddFrontmatter<cr>", { buffer = true, desc = "Add obsidian frontmatter" })
      end,
    })
  end,
}
