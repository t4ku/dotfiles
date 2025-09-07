local M = {}

-- Create a new inbox capture
function M.create()
  -- Get service type
  local service = vim.fn.input("Service (chatwork/slack/email/teams/web/misc): ", "misc")
  if service == "" then
    service = "misc"
  end
  
  local channel = vim.fn.input("Channel/Source: ", "general")
  if channel == "" then
    channel = "general"
  end
  
  local timestamp = os.date("%Y%m%d-%H%M")
  
  -- Generate filename
  local filename = string.format("Inbox/%s-%s-%s.md", service, channel, timestamp)
  
  -- First create the note with ObsidianNew
  local success = pcall(vim.cmd, string.format("ObsidianNew %s", filename))
  
  if not success then
    -- Fallback to regular file creation
    local full_path = vim.fn.expand("~/Code/syla/syla-daily/" .. filename)
    vim.cmd(string.format("e %s", full_path))
  end
  
  -- Now apply the template content manually
  local template_path = vim.fn.expand("~/Code/syla/syla-daily/Templates/inbox-capture.md")
  if vim.fn.filereadable(template_path) == 1 then
    -- Collect all inputs first
    local title = vim.fn.input("Title: ", "")
    local participants = vim.fn.input("Participants (comma-separated): ", "")
    
    -- Read template
    local template_lines = vim.fn.readfile(template_path)
    
    -- Replace template variables
    local processed_lines = {}
    for _, line in ipairs(template_lines) do
      line = line:gsub("{{SERVICE}}", service)
      line = line:gsub("{{CHANNEL}}", channel)
      line = line:gsub("{{YYYYMMDD}}", os.date("%Y%m%d"))
      line = line:gsub("{{HHMM}}", os.date("%H%M"))
      line = line:gsub("{{DATE}}", os.date("%Y-%m-%d"))
      line = line:gsub("{{TIME}}", os.date("%H:%M"))
      line = line:gsub("{{TIMESTAMP}}", os.date("%Y-%m-%d %H:%M:%S"))
      line = line:gsub("{{TITLE}}", title)
      line = line:gsub("{{PARTICIPANTS}}", participants)
      line = line:gsub("{{CONTENT}}", "<!-- Paste content here -->")
      table.insert(processed_lines, line)
    end
    
    -- Set buffer content
    vim.api.nvim_buf_set_lines(0, 0, -1, false, processed_lines)
  else
    -- Create without template, just basic frontmatter
    local frontmatter = {
      "---",
      string.format("service: %s", service),
      string.format("channel: %s", channel),
      string.format("timestamp: %s", os.date("%Y-%m-%d %H:%M:%S")),
      "processed: false",
      "priority: medium",
      "tags: [inbox]",
      "---",
      "",
      "## Content",
      "",
      "<!-- Paste content here -->",
      "",
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, frontmatter)
  end
  
  print(string.format("Created inbox capture: %s", filename))
end

-- Quick capture with minimal prompts
function M.quick_capture()
  local timestamp = os.date("%Y%m%d-%H%M")
  local filename = string.format("Inbox/quick-%s.md", timestamp)
  
  -- Check if we have a quick-capture template
  local has_template = vim.fn.filereadable(vim.fn.expand("~/Code/syla/syla-daily/Templates/quick-capture.md")) == 1
  
  if has_template then
    vim.cmd(string.format("ObsidianNewFromTemplate quick-capture %s", filename))
  else
    vim.cmd(string.format("ObsidianNew %s", filename))
    -- Add minimal frontmatter
    local frontmatter = {
      "---",
      "service: misc",
      "channel: quick",
      string.format("timestamp: %s", os.date("%Y-%m-%d %H:%M:%S")),
      "processed: false",
      "tags: [inbox, quick]",
      "---",
      "",
      "## Content",
      "",
      "<!-- Paste content here -->",
      "",
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, frontmatter)
  end
  
  print(string.format("Created quick capture: %s", filename))
end

-- List today's inbox items
function M.list_today()
  local today = os.date("%Y%m%d")
  local inbox_dir = vim.fn.expand("~/Code/syla/syla-daily/Inbox")
  
  -- Ensure inbox directory exists
  if vim.fn.isdirectory(inbox_dir) == 0 then
    print("Inbox directory not found. Creating it...")
    vim.fn.mkdir(inbox_dir, "p")
    return
  end
  
  -- Find today's captures using glob
  local pattern = string.format("%s/*-%s-*.md", inbox_dir, today)
  local files = vim.fn.glob(pattern, false, true)
  
  if #files == 0 then
    print("No inbox captures for today")
  else
    print(string.format("Today's inbox captures (%d items):", #files))
    for _, file in ipairs(files) do
      local filename = vim.fn.fnamemodify(file, ":t")
      -- Try to extract service and channel from filename
      local service, channel = filename:match("^([^-]+)-([^-]+)-")
      if service and channel then
        print(string.format("  - [%s/%s] %s", service, channel, filename))
      else
        print(string.format("  - %s", filename))
      end
    end
  end
end

-- Process today's items (mark as processed)
function M.process_today()
  local today = os.date("%Y%m%d")
  local inbox_dir = vim.fn.expand("~/Code/syla/syla-daily/Inbox")
  
  -- Find today's captures
  local pattern = string.format("%s/*-%s-*.md", inbox_dir, today)
  local files = vim.fn.glob(pattern, false, true)
  
  if #files == 0 then
    print("No inbox captures to process for today")
    return
  end
  
  local processed_count = 0
  
  for _, file in ipairs(files) do
    -- Read file content
    local lines = vim.fn.readfile(file)
    local in_frontmatter = false
    local frontmatter_end = 0
    local has_processed = false
    
    -- Find frontmatter and check if already processed
    for i, line in ipairs(lines) do
      if line == "---" then
        if not in_frontmatter then
          in_frontmatter = true
        else
          frontmatter_end = i
          break
        end
      elseif in_frontmatter and line:match("^processed:%s*true") then
        has_processed = true
      end
    end
    
    -- If not already processed and has frontmatter, update it
    if not has_processed and frontmatter_end > 0 then
      for i = 2, frontmatter_end - 1 do
        if lines[i]:match("^processed:") then
          lines[i] = "processed: true"
          processed_count = processed_count + 1
          break
        end
      end
      
      -- Write the updated content back
      vim.fn.writefile(lines, file)
    end
  end
  
  print(string.format("Processed %d inbox items for today", processed_count))
end

-- List unprocessed items
function M.list_unprocessed()
  local inbox_dir = vim.fn.expand("~/Code/syla/syla-daily/Inbox")
  
  if vim.fn.isdirectory(inbox_dir) == 0 then
    print("Inbox directory not found")
    return
  end
  
  local pattern = string.format("%s/*.md", inbox_dir)
  local files = vim.fn.glob(pattern, false, true)
  local unprocessed = {}
  
  for _, file in ipairs(files) do
    local lines = vim.fn.readfile(file)
    local is_unprocessed = false
    
    for _, line in ipairs(lines) do
      if line:match("^processed:%s*false") then
        is_unprocessed = true
        break
      end
    end
    
    if is_unprocessed then
      table.insert(unprocessed, vim.fn.fnamemodify(file, ":t"))
    end
  end
  
  if #unprocessed == 0 then
    print("All inbox items are processed!")
  else
    print(string.format("Unprocessed inbox items (%d):", #unprocessed))
    for _, filename in ipairs(unprocessed) do
      print(string.format("  - %s", filename))
    end
  end
end

-- Open inbox directory in telescope
function M.search_inbox()
  local inbox_dir = vim.fn.expand("~/Code/syla/syla-daily/Inbox")
  
  -- Check if telescope is available
  local ok, telescope = pcall(require, "telescope.builtin")
  if not ok then
    print("Telescope not found. Opening inbox directory...")
    vim.cmd(string.format("e %s", inbox_dir))
    return
  end
  
  -- Use telescope to search inbox files
  telescope.find_files({
    cwd = inbox_dir,
    prompt_title = "Inbox Captures",
    find_command = { "rg", "--files", "--hidden", "-g", "*.md" },
  })
end

-- Create inbox capture from selection
function M.capture_selection()
  -- Get visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  
  if #lines == 0 then
    print("No selection to capture")
    return
  end
  
  -- Create quick capture
  local timestamp = os.date("%Y%m%d-%H%M")
  local filename = string.format("Inbox/selection-%s.md", timestamp)
  
  vim.cmd(string.format("ObsidianNew %s", filename))
  
  -- Add frontmatter and selected content
  local content = {
    "---",
    "service: selection",
    "channel: vim",
    string.format("timestamp: %s", os.date("%Y-%m-%d %H:%M:%S")),
    "processed: false",
    "tags: [inbox, selection]",
    string.format("source: %s", vim.fn.expand("%:p")),
    "---",
    "",
    "## Selected Content",
    "",
  }
  
  -- Add the selected lines
  for _, line in ipairs(lines) do
    table.insert(content, line)
  end
  
  vim.api.nvim_buf_set_lines(0, 0, 0, false, content)
  print(string.format("Created capture from selection: %s", filename))
end

return M