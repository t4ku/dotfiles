return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- List of parser names or "all"
        ensure_installed = {
          "terraform",    -- For .tf files
          "hcl",         -- For .hcl and Terragrunt files
          -- other parsers you might want
          "lua",
          "vim",
          "vimdoc",
          "query",
        },
        -- List of parsers to ignore installing
        ignore_install = {},

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- Modules configuration
        modules = {},

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = false,
        },
      })

      -- Set filetype detection for Terragrunt files
      vim.filetype.add({
        pattern = {
          ["terragrunt.hcl"] = "hcl",
          [".terragrunt-version"] = "hcl",
        },
      })
    end,
  },
}
