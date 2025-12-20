--------------------
-- nvim-lspconfig --
--------------------

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- 'saghen/blink.cmp',
    'williamboman/mason.nvim',           -- For installing LSP servers
    'williamboman/mason-lspconfig.nvim', -- Integration with nvim-lspconfig
    'b0o/schemastore.nvim',              -- YAML/JSON schemas
  },
  config = function()
    -- local capabilities = require('blink.cmp').get_lsp_capabilities()
    -- require("lspconfig").lua_ls.setup { capabilities = capabilities }
    -- require('lspconfig').terraformls.setup { capabilities = capabilities }

    local api, lsp = vim.api, vim.lsp
    -- local lspconfig = require('lspconfig')
    local utils = require('utils')
    local map = utils.local_map(0)

    local eslint_on_attach = vim.lsp.config.eslint.on_attach

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
        on_attach = function(client, bufnr)
          if not eslint_on_attach then return end

          eslint_on_attach(client, bufnr)

          api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll',
          })
        end,
      },
      -- Bash --
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

    -- These have their own plugins that enable them
    local special_server_configs = { 'ts_ls', 'rust_analyzer' }

    --------------------
    -- Configure servers --
    --------------------
    for server_name, config in pairs(server_configs) do
      -- Enable folding (required by ufo.nvim)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
      config.capabilities = vim.tbl_deep_extend(
        'keep',
        config.capabilities or {},
        capabilities
      )

      vim.lsp.config(server_name, config)
    end

    -- Ensure that servers mentioned above get installed
    local ensure_installed = vim.list_extend(
      vim.tbl_keys(server_configs),
      vim.tbl_keys(special_server_configs)
    )

    require('mason-lspconfig').setup({
      ensure_installed = not ensure_installed or {},
      automatic_enable = {
        exclude = special_server_configs,
      }
    })

    -------------
    -- Keymaps --
    -------------
    local function lsp_references()
      utils.clear_lsp_references()

      local method = 'textDocument/documentHighlight'
      if #vim.lsp.get_clients({ method = method }) > 0 then
        lsp.buf.document_hightlight()
      end

      require('telescope.builtin').lsp_references({ include_declaration = false })
    end

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
      map('n', 'gr', lsp_references, 'LSP references')

      map('n', 'gh', lsp.buf.hover, 'LSP hover')
      map('n', 'gs', lsp.buf.signature_help, 'LSP signature help')
      map(is, '<M-s>', lsp.buf.signature_help, 'LSP signature help')
      map(nx, '<leader>r', lsp.buf.rename, 'LSP rename')

      map('n', '<leader>e', function() vim.diagnostic.open_float({ border = 'single' }) end, 'Diagnostic open float')

      map_vsplit('<C-w>gd', 'lsp_definitions')
      map_vsplit('<C-w>gi', 'lsp_implementations')
      map_vsplit('<C-w>gD', 'lsp_type_definitions')
      map('n', '<leader>lq', '<cmd>LspStop<CR>', { desc = 'Stop LSP server' })
      map('n', '<leader>lr', ':LspRestart<CR>', { desc = 'Restart LSP server' })
    end

    ---------------------------
    -- Default LSP on_attach --
    ---------------------------
    local augroup = api.nvim_create_augroup('LSP', { clear = true })

    api.nvim_create_autocmd("LspAttach", {
      group = augroup,
      desc = 'Default LSP on_attach',
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
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
