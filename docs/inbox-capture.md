# PKM Inbox Capture System

## Overview

The inbox capture system provides a quick and organized way to capture information from various sources (Chatwork, Slack, email, Teams, web articles, etc.) into your PKM repository.

## Features

- **Service-based capture**: Organize captures by service type (chatwork, slack, email, teams, web, misc)
- **Channel tracking**: Track the source/channel within each service
- **Participant tracking**: Record who was involved in conversations
- **Processing status**: Mark items as processed/unprocessed
- **Priority levels**: Assign priorities (high, medium, low)
- **Project association**: Link captures to specific projects
- **Template system**: Use templates for consistent formatting
- **Quick capture**: Ultra-fast capture with minimal prompts

## Commands

| Command | Description |
|---------|-------------|
| `:InboxCapture` | Create new inbox capture with prompts |
| `:InboxQuick` | Quick capture with minimal prompts |
| `:InboxList` | List today's inbox captures |
| `:InboxProcess` | Mark today's items as processed |
| `:InboxUnprocessed` | List all unprocessed items |
| `:InboxSearch` | Search inbox with telescope |

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>oi` | Normal | Capture to inbox |
| `<leader>oiq` | Normal | Quick capture |
| `<leader>oil` | Normal | List today's inbox |
| `<leader>oip` | Normal | Process inbox items |
| `<leader>oiu` | Normal | List unprocessed |
| `<leader>ois` | Normal | Search inbox |
| `<leader>oic` | Visual | Capture selection |

## File Naming Convention

Files are automatically named using the pattern:
```
{service}-{channel}-{YYYYMMDD}-{HHMM}.md
```

Examples:
- `chatwork-syla-paint-20250108-1430.md`
- `slack-engineering-20250108-1500.md`
- `email-client-20250108-1600.md`
- `quick-20250108-1100.md`

## Workflow

### 1. Quick Capture
```vim
" Press <leader>oi or run
:InboxCapture
" Enter service (chatwork/slack/email/teams/web/misc)
" Enter channel/source
" Enter other metadata as prompted
" Paste your content
```

### 2. Ultra-Quick Capture
```vim
" Press <leader>oiq or run
:InboxQuick
" Just paste content - no prompts!
```

### 3. Capture from Selection
```vim
" Select text in visual mode
" Press <leader>oic
" Creates capture with selected text
```

### 4. Review Today's Captures
```vim
" Press <leader>oil or run
:InboxList
" Shows all captures from today
```

### 5. Process Captures
```vim
" Press <leader>oip or run
:InboxProcess
" Marks today's captures as processed
```

### 6. Find Unprocessed Items
```vim
" Press <leader>oiu or run
:InboxUnprocessed
" Lists all unprocessed captures
```

### 7. Search Inbox
```vim
" Press <leader>ois or run
:InboxSearch
" Opens telescope to search inbox
```

## Template Variables

When using templates, these variables are available:

| Variable | Description | Example |
|----------|-------------|---------|
| `{{SERVICE}}` | Service type | chatwork, slack, email |
| `{{CHANNEL}}` | Channel/source | general, syla-paint |
| `{{PARTICIPANTS}}` | People involved | John, Jane |
| `{{TITLE}}` | Capture title | Meeting Notes |
| `{{TIMESTAMP}}` | Full timestamp | 2025-01-08 14:30:00 |
| `{{DATE}}` | Current date | 2025-01-08 |
| `{{TIME}}` | Current time | 14:30 |
| `{{YYYYMMDD}}` | Date for filename | 20250108 |
| `{{HHMM}}` | Time for filename | 1430 |
| `{{PROCESSED}}` | Processing status | false |
| `{{PRIORITY}}` | Priority level | medium |
| `{{PROJECT}}` | Associated project | syla-paint |
| `{{CONTENT}}` | Content placeholder | (paste here) |

## Directory Structure

```
~/Code/syla/syla-daily/
├── Inbox/                    # All captures go here
│   ├── chatwork-*.md
│   ├── slack-*.md
│   ├── email-*.md
│   └── ...
└── Templates/                # Template files
    ├── inbox-capture.md      # Main capture template
    └── quick-capture.md      # Quick capture template
```

## Tips

1. **Use consistent channel names** for easier searching and organization
2. **Process inbox daily** during your planning or review session
3. **Link processed items** to your daily journal or project notes
4. **Use quick capture** (`<leader>oiq`) for urgent items
5. **Visual selection capture** (`<leader>oic`) is great for code snippets
6. **Search function** (`<leader>ois`) helps find old captures quickly

## Integration with Daily Journal

After processing inbox items, reference them in your daily journal:

```markdown
## Inbox Review
- [[Inbox/chatwork-syla-paint-20250108-1430|Paint project discussion]]
- [[Inbox/slack-engineering-20250108-1500|Tech debt discussion]]
```

## Customization

You can customize the templates by editing:
- `~/Code/syla/syla-daily/Templates/inbox-capture.md`
- `~/Code/syla/syla-daily/Templates/quick-capture.md`

Add your own template variables in `obsidian.lua`:
```lua
templates = {
  substitutions = {
    MY_CUSTOM_VAR = function()
      return vim.fn.input("Custom value: ", "")
    end,
  },
},
```