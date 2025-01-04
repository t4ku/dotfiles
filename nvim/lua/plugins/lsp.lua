return {
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP Support
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Autocompletion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- Additional utilities
      "folke/neodev.nvim", -- for Lua development
    },
    config = function()
      -- Setup neodev first (important for Lua development)
      require("neodev").setup()

      -- Mason setup (package manager for LSP servers)
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",        -- Lua
        },
        automatic_installation = false,
      })

      -- Setup completion
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })

      -- Setup LSP servers
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      -- Utility functions for Python environment detection
      local function get_poetry_path(workspace)
        -- Check if poetry.lock exists
        if vim.fn.filereadable(workspace .. "/poetry.lock") == 1 then
          -- Get poetry environment path
          local poetry_env = vim.fn.trim(vim.fn.system('cd ' .. workspace .. ' && poetry env info -p'))
          if vim.v.shell_error == 0 and vim.fn.isdirectory(poetry_env) == 1 then
            return poetry_env .. '/bin/python'
          end
        end
        return nil
      end

      local function get_python_path(workspace)
        -- Try Poetry first
        local poetry_python = get_poetry_path(workspace)
        if poetry_python then
          return poetry_python
        end

        -- Then try virtualenv
        local venv_python = workspace .. "/.venv/bin/python"
        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end

        -- Then try pyenv
        local pyenv_python = vim.fn.trim(vim.fn.system('cd ' .. workspace .. ' && pyenv which python'))
        if vim.fn.executable(pyenv_python) == 1 then
          return pyenv_python
        end

        -- Fallback to system Python
        return vim.fn.exepath('python3') or vim.fn.exepath('python')
      end


      -- LSP server configurations
      -- :MasonInstall <server> to install LSP servers
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        -- TypeScript/JavaScript(nodenv)
        ts_ls = {
          cmd = {
            "mise",
            "exec",
            "node",
            "--",
            "typescript-language-server",
            "--stdio",
          },
          root_dir = require("lspconfig.util").root_pattern("package.json","tsconfig.json","jsconfig.json"),
          single_file_support = false
        },
        -- Python(poetry/virtualenv/pyenv)
        pyright = {
          cmd = {
            "mise",
            "exec",
            "node",
            "--",
            "pyright-langserver",
            "--stdio",
          },
          before_init = function(_, config)
            local workspace = config.root_dir
            config.settings.python.pythonPath = get_python_path(workspace)
          end,
          settings = {
            python = {
              analysis = {
                -- Support for Poetry/pyproject.toml dependencies
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                -- Enable type checking
                typeCheckingMode = "basic",
                -- Respect pyproject.toml configurations
                stubPath = "typings",
                extraPaths = {},
              },
              -- Auto detect pyproject.toml for project structure
              venvPath = "",
            },
          },
          root_dir = require("lspconfig.util").root_pattern(
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            ".git"
          ),
        },
        -- ruff
        ruff = {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Enable formatting
            client.server_capabilities.documentFormattingProvider = true
            -- Add format command
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
              vim.lsp.buf.format({ async = true })
            end, { desc = "Format current buffer with LSP" })
          end,
          -- Use the same root pattern as Pyright to find pyproject.toml
          root_dir = require("lspconfig.util").root_pattern(
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            ".git"
          ),
        }
      }

      -- LSP keybindings (applied to all LSP buffers)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        end,
      })

      -- Setup all LSP servers
      for server, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
    end,
  },
}
