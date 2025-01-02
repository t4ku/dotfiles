-- in ~/.config/nvim/plugins/telescope.lua
return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'cljoly/telescope-repo.nvim',
    },
    config = function()
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
        { "<C-r>", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    }
}
