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
      if title ~= nil and title ~= "" then
        -- Check if this is a markdown link pattern [[filename]]
        local link_content = title:match("%[%[(.-)%]%]")
        if link_content then
          -- Extract just the filename part (before any |alias)
          local filename = link_content:match("^([^|]+)")
          if filename then
            return filename
          end
        end
        
        -- Replace spaces with hyphens, keep Unicode characters
        local formatted = title:gsub(" ", "-")
        -- Remove only truly problematic characters for filenames
        formatted = formatted:gsub("[<>:\"/\\|?*]", "")
        -- Ensure we don't return an empty string
        if formatted ~= "" then
          return formatted
        end
      end
      -- Fallback to timestamp if no title or empty after formatting
      return tostring(os.time())
    end,
    
    -- Template configuration for inbox capture
    templates = {
      subdir = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {
        -- Service type (chatwork, slack, email, teams, web, misc)
        SERVICE = function()
          return vim.fn.input("Service (chatwork/slack/email/teams/web/misc): ", "misc")
        end,
        
        -- Channel or source within the service
        CHANNEL = function()
          return vim.fn.input("Channel/Source: ", "general")
        end,
        
        -- Participants in the conversation
        PARTICIPANTS = function()
          return vim.fn.input("Participants (comma-separated): ", "")
        end,
        
        -- Title for the capture
        TITLE = function()
          return vim.fn.input("Title: ", "")
        end,
        
        -- File naming components
        YYYYMMDD = function()
          return os.date("%Y%m%d")
        end,
        
        HHMM = function()
          return os.date("%H%M")
        end,
        
        -- Full timestamp for frontmatter
        TIMESTAMP = function()
          return os.date("%Y-%m-%d %H:%M:%S")
        end,
        
        -- Current date
        DATE = function()
          return os.date("%Y-%m-%d")
        end,
        
        -- Current time
        TIME = function()
          return os.date("%H:%M")
        end,
        
        -- Content placeholder (will be filled manually)
        CONTENT = function()
          return "<!-- Paste content here -->"
        end,
        
        -- Processing status
        PROCESSED = function()
          return "false"
        end,
        
        -- Priority level
        PRIORITY = function()
          return vim.fn.input("Priority (high/medium/low): ", "medium")
        end,
        
        -- Project association
        PROJECT = function()
          return vim.fn.input("Project (optional): ", "")
        end,
      },
    },
    
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
    -- shortcut for call :ObisidanBacklinks command in markdown files
     vim.api.nvim_create_autocmd("FileType", {
       pattern = "markdown",
       callback = function()
         vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { buffer = true, desc = "Show backlinks" })
       end,
     })
  end,
}
