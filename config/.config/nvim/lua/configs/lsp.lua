---------------
-- LSP stuff --
---------------
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',               -- For installing LSP servers
    'williamboman/mason-lspconfig.nvim',     -- Integration with nvim-lspconfig
    'b0o/schemastore.nvim',                  -- YAML/JSON schemas
    'jose-elias-alvarez/typescript.nvim',    -- TypeScript utilities
    'folke/neodev.nvim',                     -- Lua signature help and completion
    'davidosomething/format-ts-errors.nvim', -- Prettier TypeScript errors
    'hrsh7th/cmp-nvim-lsp',                  -- Improved LSP capabilities
    'lvimuser/lsp-inlayhints.nvim',          -- Inlay hints
    { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  },
  event = { 'VeryLazy', 'BufWrite' },
  config = function()
    print("hello world")
    local api, lsp, diagnostic = vim.api, vim.lsp, vim.diagnostic
    local lspconfig = require('lspconfig')
    local telescope = require('telescope.builtin')
    local mason_path = require('mason-core.path')
    local typescript = require('typescript')
    local get_install_path  = require('utils').get_install_path

    local map = function(modes, lhs, rhs, opts)
      if type(opts) == 'string' then
        opts = { desc = opts }
      elseif not opts then
        opts = {}
      end
      opts = vim.tbl_extend('keep', opts, { buffer = true })
      return require('utils').map(modes, lhs, rhs, opts)
    end

    local function typescript_organize_imports()
      local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = "Organize imports"
      }
      vim.lsp.buf.execute_command(params)
    end

    -- TypeScript --
    local tsserver_config = {
      on_attach = function()
        local actions = typescript.actions

        local function spread(char)
          return function()
            require('utils').feedkeys('siw' .. char .. 'a...<Esc>2%i, ', 'm')
          end
        end

        local function rename_file()
          local workspace_path = lsp.buf.list_workspace_folders()[1]
          local file_path = vim.fn.expand('%:' .. workspace_path .. ':.')
          vim.ui.input({ prompt = 'Rename file', default = file_path },
            function(target)
              if target ~= nil then
                typescript.renameFile(file_path, target)
              end
            end
          )
        end

        map('n', '<leader>lo', '<cmd>TypescriptOrganizeAndFixImports<CR>', 'LSP Organize imports')
        map('n', '<leader>li', actions.addMissingImports, 'LSP add missing imports')
        map('n', '<leader>lf', actions.fixAll, 'LSP fix all errors')
        map('n', '<leader>lu', actions.removeUnused, 'LSP remove unused')
        map('n', '<leader>lr', rename_file, 'LSP rename file')
        map('n', '<leader>lc', function() require('tsc').run() end, 'Type check project')
        map('n', '<leader>ls', spread('{'), {
          remap = true,
          desc = 'Spread object under cursor'
        })
        map('n', '<leader>lS', spread('['), {
          remap = true,
          desc = 'Spread array under cursor'
        })
      end,
      commands = {
        TypescriptOrganizeAndFixImports = {
          typescript_organize_imports,
          description = "Organize imports",
        }
      },
      settings = {
        typescript = {
          inlayHints = {
            -- Enabled
            includeInlayParameterNameHints = 'all',
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            -- Disabled
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = false,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayFunctionLikeReturnTypeHints = false,
          }
        },
      },
      handlers = {
        ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
          if result.diagnostics == nil then
            return
          end

          -- Ignore some tsserver diagnostics
          local idx = 1
          -- TODO: change to using `map()` instead of `while`
          while idx <= #result.diagnostics do
            local entry = result.diagnostics[idx]

            local formatter = require('format-ts-errors')[entry.code]
            entry.message = formatter and formatter(entry.message) or entry.message

            if entry.code == 80001 then
              table.remove(result.diagnostics, idx)
            else
              idx = idx + 1
            end
          end

          lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
      },
    }

    -- Neovim Lua API completions/documentation
    require('neodev').setup({
      override = function(_, library)
        library.enabled = true
        library.plugins = true
      end,
    })

    ---------------------------
    -- Server configurations --
    ---------------------------
    local server_configs = {
      -- Lua --
      lua_ls = {
        on_init = function(client)
          local path = client.workspace_folders and client.workspace_folders[1].name
          -- if not has_file(path, { '.luarc.json', '.luarc.jsonc' }) then
          client.config.settings = vim.tbl_deep_extend(
            'force',
            client.config.settings,
            {
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
            }
          )

          client.notify('workspace/didChangeConfiguration', {
            settings = client.config.settings,
          })
          -- end
          return true
        end,
        on_attach = function()
          map('n', '<leader>lt', '<Plug>PlenaryTestFile', "Run file's plenary tests")
        end
      },
      -- YAML --
      yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              url = 'https://www.schemastore.org/api/json/catalog.json',
              enable = true
            },
            customTags = {
              -- AWS CloudFormation tags
              '!Equals sequence', '!FindInMap sequence', '!GetAtt', '!GetAZs',
              '!ImportValue', '!Join sequence', '!Ref', '!Select sequence',
              '!Split sequence', '!Sub', '!Or sequence'
            },
          }
        }
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
        filetypes = {'sh', 'zsh'}
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
      -- Bicep --
      bicep = {
        cmd = {
          mason_path.concat({ get_install_path('bicep-lsp'), 'bicep-lsp' })
        }
      },
      -- LTeX --
      ltex = {
        settings = {
          ltex = {
            language = 'auto',
            diagnosticSeverity = 'hint',
            sentenceCacheSize = 2000,
            additionalRules = {
              motherTongue = 'sv',
            },
          },
        },
        on_attach = function(_, buf)
          -- Temporary fix until https://github.com/jhofscheier/ltex-utils.nvim/issues/8 gets merged
          if not vim.env.LTEX_GLOBAL_STORAGE_PATH then
            vim.env.LTEX_GLOBAL_STORAGE_PATH = vim.fn.stdpath('data') .. '/ltex/'
          end

          require('ltex-utils').on_attach(buf)
        end
      },
      typst_lsp = {
        on_attach = function()
          map('n', '<leader>lw', '<cmd>TypstWatch<CR>', 'Watch file')
        end,
      },
      typos_lsp = {
        on_attach = function(client, _)
          -- Disable for markdown, use ltex instead
          local disabled_filetypes = vim.iter({ 'markdown', 'NvimTree' })
          if disabled_filetypes:find(vim.bo.filetype) ~= nil then
            -- Force-shutdown seems to be necessary for some reason
            vim.lsp.stop_client(client.id, true)
          end
        end,
        init_options = {
          diagnosticSeverity = 'hint'
        }
      }
    }

    local disable = function() end

    -- Special server configurations
    local special_server_configs = {
      tsserver = function()
        return typescript.setup({ server = tsserver_config })
      end,
      zk = disable, -- Disabled because zk-nvim already sets it up
      rust_analyzer = disable, -- Set up in rustaceanvim
      jdtls = disable, -- Set up in in java.lua
    }

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    --------------------
    -- Set up servers --
    --------------------
    local function setup(server_name)
      local special_server_setup = special_server_configs[server_name]
      if special_server_setup then
        special_server_setup()
        return
      end

      local opts = server_configs[server_name] or {}
      local opts_with_capabilities = vim.tbl_deep_extend('force', opts, {
        capabilities = capabilities,
      })
      lspconfig[server_name].setup(opts_with_capabilities)
    end

    -- Ensure that servers mentioned above get installed
    local ensure_installed = vim.list_extend(
      vim.tbl_keys(server_configs),
      vim.tbl_keys(special_server_configs)
    )

    require('mason-lspconfig').setup({
      handlers = { setup },
      ensure_installed = vim.list_extend(ensure_installed, {
        'vimls',
        'pylsp',
        'lemminx',
      })
    })

    ---------------------
    -- Handler configs --
    ---------------------
    if not require('utils').noice_is_loaded() then
      -- Add borders to hover/signature windows (noice.nvim has its own)
      lsp.handlers['textDocument/hover'] = lsp.with(
        lsp.handlers.hover,
        { border = 'single' }
      )

      lsp.handlers['textDocument/signatureHelp'] = lsp.with(
        lsp.handlers.signature_help,
        { border = 'single' }
      )
    end

    -------------
    -- Keymaps --
    -------------
    local ERROR = diagnostic.severity.ERROR
    local INFO = diagnostic.severity.INFO

    local error_opts = { severity = { min = ERROR }, float = { border = 'single' } }
    local info_opts = { severity = { max = INFO }, float = { border = 'single' } }
    local with_border = { float = { border = 'single' } }

    local function diagnostic_goto(direction, opts)
      return function()
        diagnostic['goto_' .. direction](opts)
      end
    end

    local function lsp_references()
      require('utils').clear_lsp_references()
      lsp.buf.document_highlight()
      telescope.lsp_references({ include_declaration = false })
    end

    local function attach_codelens(bufnr)
      api.nvim_create_augroup('Lsp', {})
      api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        group = 'Lsp',
        buffer = bufnr,
        callback = lsp.codelens.refresh,
      })
    end

    local function attach_keymaps()
      local nx = { 'n', 'x' }

      map('n', 'gd',         telescope.lsp_definitions,               'LSP definitions')
      map('n', 'gD',         telescope.lsp_type_definitions,          'LSP type definitions')
      map('n', 'gi',         telescope.lsp_implementations,           'LSP implementations')
      map('n', '<leader>ts', telescope.lsp_document_symbols,          'LSP document symbols')
      map('n', '<leader>tS', telescope.lsp_workspace_symbols,         'LSP workspace symbols')
      map('n', '<leader>tw', telescope.lsp_dynamic_workspace_symbols, 'LSP dynamic workspace symbols')
      map('n', 'gr',         lsp_references,                          'LSP references')

      map('n',        'gh',        lsp.buf.hover,          'LSP hover')
      map('n',        'gs',        lsp.buf.signature_help, 'LSP signature help')
      map({'i', 's'}, '<M-s>',     lsp.buf.signature_help, 'LSP signature help')
      map(nx,         '<leader>r', lsp.buf.rename,         'LSP rename')
      map(nx,         '<leader>A', lsp.codelens.run,       'LSP code lens')

      map(nx,  ']e',        diagnostic_goto('next', error_opts), 'Go to next error')
      map(nx,  '[e',        diagnostic_goto('prev', error_opts), 'Go to previous error')
      map(nx,  '[h',        diagnostic_goto('prev', info_opts), 'Go to previous info')
      map(nx,  ']h',        diagnostic_goto('next', info_opts), 'Go to next info')
      map(nx,  ']d',        diagnostic_goto('next', with_border), 'Go to next diagnostic')
      map(nx,  '[d',        diagnostic_goto('prev', with_border), 'Go to previous diagnostic')
      map('n', '<leader>e', function() diagnostic.open_float({ border = 'single' }) end, 'Diagnostic open float')

      map('n', '<C-w>gd', '<C-w>vgd', { desc = 'LSP definition in window split',      remap = true })
      map('n', '<C-w>gi', '<C-w>vgi', { desc = 'LSP implementation in window split',  remap = true })
      map('n', '<C-w>gD', '<C-w>vgD', { desc = 'LSP type definition in window split', remap = true })

      map('n', '<leader>ls', '<cmd>LspStart<CR>', { desc = 'Start LSP server' })
      map('n', '<leader>lq', '<cmd>LspStop<CR>',  { desc = 'Stop LSP server' })

      -- print('keymaps attached')
    end

    -- File types to not format on write
    local format_on_write_blacklist = {}

    ---------------------------
    -- Default LSP on_attach --
    ---------------------------
    local augroup = api.nvim_create_augroup('LSP', { clear = true })
    api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      desc = 'Default LSP on_attach',
      callback = function(event)
        local bufnr = event.buf
        local client = lsp.get_client_by_id(event.data.client_id)
        local filetype = api.nvim_get_option_value('filetype', { buf = bufnr })

        if not client then return end

        -- Keymaps
        attach_keymaps()

        -- Autoformatting
        if not vim.tbl_contains(format_on_write_blacklist, filetype) then
          require('utils.formatting').format_on_write(client, bufnr)
        end

        -- Code lens
        if client.server_capabilities.codeLensProvider then
          attach_codelens(bufnr)
        end

        -- Inlay hints
        if event.data and event.data.client_id then
          local inlay_hints = require('lsp-inlayhints')

          inlay_hints.on_attach(client, bufnr)

          map('n', '<leader>lh', inlay_hints.toggle, 'Toggle LSP inlay hints')
        end
      end
    })
  end
}
