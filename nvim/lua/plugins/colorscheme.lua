return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Default dark
        background = { -- Consistent borders
          light = "latte",
          dark = "mocha",
        },
        -- prevent low contrast background
        transparent_background = true,
        integrations = {
          telescope = true,
          nvimtree = true,
          mason = true,
        },
        no_italic = true, -- Optional: for cleaner look
        no_bold = false,  -- Keep bold for high contrast
        custom_highlights = {
          -- Add any specific highlighting adjustments here
        }
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
