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

      -- if inlay hints are supported, enable it
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { 0 })
      end

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
        -- Python(pyright->basedpyright)
        basedpyright = {
          -- :LspInfo shows mason installed bin at /Users/username/.local/share/mason/bin/
          -- and it somehow detects the correct path to the bin
          -- c.f. https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/basedpyright.lua#L45
          -- cmd = {
          --   "mise",
          --   "exec",
          --   "node",
          --   "--",
          --   "pyright-langserver",
          --   "--stdio",
          -- },
          before_init = function(_, config)
            local workspace = config.root_dir
            -- config.settings.basedpyright.pythonPath = get_python_path(workspace)
            -- config.settings.basedpyright.venvPath = get_poetry_path(workspace)
            --
            -- This is a lot easier to `poetry shell` and then start nvim
            -- c.f https://stackoverflow.com/questions/74510279/pyright-cant-see-poetry-dependencies
            -- config.settings.basedpyright.venv = "xxx-backend-5vgmF_2I-py3.13"
            -- config.settings.basedpyright.venvPath = "/Users/t_okawa/Library/Caches/pypoetry/virtualenvs"
          end,
          disableOrganizeImports = true,  -- in favor of ruff
          settings = {
            basedpyright = {
              analysis = {
                -- pyright doesn't support inlay hints
                inlayHints = {
                  enabled = true,
                  variableTypes = true,
                  functionReturnTypes = true,
                  -- https://docs.basedpyright.com/latest/configuration/language-server-settings/
                  -- parameterTypes = true,
                  callArgumentNames = true,
                  genericTypes = true,
                },
                -- only use language features, and disable type checking
                -- c.f How can I disable Pyright diagnotic function? #3929
                -- https://github.com/microsoft/pyright/discussions/3929#discussioncomment-3620347
                --
                -- it's still not ignoring all the warnings/errors/hints, so maybe we need to filter using vim lsp hooks,
                -- like filtering out the hints that are not inlay hints
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                -- disable type checking in favor of mypy or ruff
                typeCheckingMode = "off",
                -- c.f typings.py file inside a project causes pyright to report that this is not a valid directory. #777
                -- https://github.com/microsoft/pyright/issues/777#issuecomment-651954306
                stubPath = "",
                extraPaths = {},
              },
            },
          },
        },
        -- ruff
        ruff = {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Enable formatting
            client.server_capabilities.documentFormattingProvider = true
            -- Add format command
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
              vim.lsp.buf.format({
                async = false,
              })
            end, { desc = "Format current buffer with LSP" })

            vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
              vim.lsp.buf.code_action({
                context = {
                  only = { "source.organizeImports" },
                  diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
                },
                apply = true,
              })
            end, { desc = "Organize imports with Ruff" })
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
        },
        terraformls = {
          capabilities = capabilities,
          -- add terragrunt support 
          filetypes = { "terraform", "hcl" },
          on_attach = function(client, bufnr)
            -- Enable formatting
            client.server_capabilities.documentFormattingProvider = true
            -- Add format command
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
              vim.lsp.buf.format({
                async = false,
              })
            end, { desc = "Format current buffer with LSP" })
          end,
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
