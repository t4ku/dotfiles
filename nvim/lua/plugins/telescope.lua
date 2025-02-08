-- in ~/.config/nvim/plugins/telescope.lua
return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'cljoly/telescope-repo.nvim',
    },
    config = function()
        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local conf = require('telescope.config').values

        -- Define the keymap search function
        local function keymap_finder()
            local modes = {'n', 'i', 'v', 'x', 's', 'o', '!', 'c', 't'}
            local all_maps = {}

            for _, mode in ipairs(modes) do
                local mode_maps = vim.api.nvim_get_keymap(mode)
                for _, map in ipairs(mode_maps) do
                    if map.desc or map.rhs then
                        table.insert(all_maps, {
                            mode = mode,
                            lhs = map.lhs,
                            rhs = map.rhs,
                            desc = map.desc or map.rhs,
                        })
                    end
                end
            end

            local function format_keymap(map)
                local mode_labels = {
                    n = "NORMAL", i = "INSERT", v = "VISUAL",
                    x = "VISUAL", s = "SELECT", o = "OP-PENDING",
                    ['!'] = "INS/CMD", c = "COMMAND", t = "TERMINAL"
                }
                return string.format("%-8s %-20s %s", 
                    mode_labels[map.mode] or map.mode,
                    map.lhs:gsub("<", "\\<"):gsub(">", "\\>"),
                    map.desc or "")
            end

            pickers.new({}, {
                prompt_title = "Key Mappings",
                finder = finders.new_table({
                    results = all_maps,
                    entry_maker = function(entry)
                        return {
                            value = entry,
                            display = format_keymap(entry),
                            ordinal = format_keymap(entry),
                        }
                    end,
                }),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        -- Register the command
        vim.api.nvim_create_user_command('Maps', keymap_finder, {})

        require('telescope').setup {
            defaults = {
                -- Your telescope settings
            },
            pickers = {
                find_files = {
                    hidden = false,
                },
                oldfiles = {
                    mappings = {
                        n = {
                            ["cd"] = function(prompt_bufnr)
                                local selection = require("telescope.actions.state").get_selected_entry()
                                local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                                require("telescope.actions").close(prompt_bufnr)
                                vim.cmd(string.format("tcd %s", dir))
                            end
                        }
                    }
                }
            },
            extensions = {
                -- Your telescope extensions
            }
        }
    end,
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Old Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
        { "<leader>fr", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>fm", "<cmd>Maps<cr>", desc = "Search Key Mappings" },
    }
}
