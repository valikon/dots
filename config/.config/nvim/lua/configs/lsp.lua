--------------------
-- nvim-lspconfig --
--------------------

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'saghen/blink.cmp',
    'williamboman/mason.nvim',           -- For installing LSP servers
    'williamboman/mason-lspconfig.nvim', -- Integration with nvim-lspconfig
    'b0o/schemastore.nvim',              -- YAML/JSON schemas
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    require("lspconfig").lua_ls.setup { capabilities = capabilities }
    require('lspconfig').terraformls.setup { capabilities = capabilities }

    local api, lsp = vim.api, vim.lsp
    local lspconfig = require('lspconfig')
    local utils = require('utils')
    local map = utils.local_map(0)

    ---------------------------
    -- Server configurations --
    ---------------------------
    local server_configs = {
      -- Lua --
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
              autoRequire = true,
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = 'space',
                indent_size = '2',
                max_line_length = '100',
                trailing_table_separator = 'smart',
              },
            },
            diagnostics = {
              globals = { 'vim', 'it', 'describe', 'before_each', 'are' },
            },
            hint = {
              enable = true,
              arrayIndex = 'Disable',
            },
            workspace = {
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          }
        },
        on_attach = function()
          map('n', '<leader>lt', '<Plug>PlenaryTestFile', "Run file's plenary tests")
        end
      },
      -- YAML --
      yamlls = {
        -- Lazy-load schemastore when needed
        on_new_config = function(config)
          config.settings.yaml.schemas = vim.tbl_deep_extend(
            'force',
            config.settings.yaml.schemas or {},
            require('schemastore').yaml.schemas()
          )
        end,
        settings = {
          redhat = {
            telemetry = { enabled = false },
          },
          yaml = {
            schemaStore = {
              -- Disable built-in schemaStore to use schemas from SchemaStore.nvim
              enable = false,
              url = '',
            },
            customTags = {
              -- AWS CloudFormation tags
              '!Equals sequence', '!FindInMap sequence', '!GetAtt', '!GetAZs',
              '!ImportValue', '!Join sequence', '!Ref', '!Select sequence',
              '!Split sequence', '!Sub', '!Or sequence'
            },
          }
        },
      },
      -- Eslint --
      eslint = {
        on_attach = function(_, bufnr)
          api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll',
          })
        end,
      },
      -- Bash/Zsh --
      bashls = {
        settings = {
          bashIde = {
            shfmt = {
              spaceRedirects = true, -- Allow space after `>` symbols
            },
          },
        },
      },
      -- Json --
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      -- Python --
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              -- Disable formatting diagnostics (that's what formatters are for)
              pylint = { enabled = false },
              pycodestyle = { enabled = false },
            }
          }
        },
      },
    }

    local disable = function() end

    -- Special server configurations
    local special_server_configs = {
      ts_ls = disable,         -- Setup in typescript.lua
      rust_analyzer = disable, -- Setup in rustaceanvim.lua
      -- gopls = disable,         -- Setup in go.lua
      -- elixirls = disable,      -- Setup in elixir.lua
    }

    --------------------
    -- Set up servers --
    --------------------
    local function setup(server_name)
      local special_server_setup = special_server_configs[server_name]
      if special_server_setup then
        special_server_setup()
        return
      end

      -- Enable folding (required by ufo.nvim)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      local opts = server_configs[server_name] or {}
      lspconfig[server_name].setup(opts)
    end

    -- Ensure that servers mentioned above get installed
    local ensure_installed = vim.list_extend(
      vim.tbl_keys(server_configs),
      vim.tbl_keys(special_server_configs)
    )

    ---@diagnostic disable-next-line: missing-fields
    require('mason-lspconfig').setup({
      handlers = { setup },
      ensure_installed = ensure_installed
    })

    ---------------------
    -- Handler configs --
    ---------------------
    if not utils.noice_is_loaded() then
      -- Add borders to hover/signature windows (noice.nvim has its own)
      lsp.handlers['textDocument/hover'] = lsp.with(
        lsp.handlers.hover,
        {
          border = 'single',
          -- Disable "no information available" popup which is really annoying
          -- when using multiple servers
          silent = true,
        }
      )

      lsp.handlers['textDocument/signatureHelp'] = lsp.with(
        lsp.handlers.signature_help,
        { border = 'single' }
      )
    end

    -------------
    -- Keymaps --
    -------------
    local function map_vsplit(lhs, fn, description)
      vim.keymap.set('n', lhs, function()
        require('telescope.builtin')[fn]({ jump_type = 'vsplit' })
      end, { desc = description })
    end

    local function attach_keymaps()
      local telescope = require('telescope.builtin')
      local nx = { 'n', 'x' }
      local is = { 'i', 's' }

      map('n', 'gd', telescope.lsp_definitions, 'LSP definitions')
      map('n', 'gD', telescope.lsp_type_definitions, 'LSP type definitions')
      map('n', 'gi', telescope.lsp_implementations, 'LSP implementations')
      map('n', '<leader>ts', telescope.lsp_document_symbols, 'LSP document symbols')
      map('n', '<leader>tS', telescope.lsp_workspace_symbols, 'LSP workspace symbols')
      map('n', '<leader>tw', telescope.lsp_dynamic_workspace_symbols, 'LSP dynamic workspace symbols')
      map('n', 'gr', telescope.lsp_references, 'LSP references')

      map('n', 'gh', lsp.buf.hover, 'LSP hover')
      map('n', 'gs', lsp.buf.signature_help, 'LSP signature help')
      map(is, '<M-s>', lsp.buf.signature_help, 'LSP signature help')
      map(nx, '<leader>r', lsp.buf.rename, 'LSP rename')

      map('n', '<leader>e', function() vim.diagnostic.open_float({ border = 'single' }) end, 'Diagnostic open float')

      map_vsplit('<C-w>gd', 'lsp_definitions')
      map_vsplit('<C-w>gi', 'lsp_implementations')
      map_vsplit('<C-w>gD', 'lsp_type_definitions')
      map('n', '<leader>lq', '<cmd>LspStop<CR>', { desc = 'Stop LSP server' })
    end

    ---------------------------
    -- Default LSP on_attach --
    ---------------------------
    local augroup = api.nvim_create_augroup('LSP', { clear = true })

    api.nvim_create_autocmd("LspAttach", {
      group = augroup,
      desc = 'Default LSP on_attach',
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        -- Keymaps
        attach_keymaps()

        -- Inlay hints
        lsp.inlay_hint.enable()

        map('n', '<leader>lh', function()
          lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
        end, 'Toggle LSP inlay hints')

        -- This has to be called from LspAttach event for some reason, not sure why
        vim.diagnostic.config({
          signs = false,
          virtual_text = {
            spacing = 4,
            prefix = function(diagnostic, _, _)
              local icon = require('configs.diagnostics').get_icon(diagnostic.severity)
              return ' ' .. icon
            end,
          }
        })
      end
    })
  end
}
