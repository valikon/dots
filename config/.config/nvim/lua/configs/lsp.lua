--------------------
-- nvim-lspconfig --
--------------------

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'saghen/blink.cmp',
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/lub/library", words = { "vim%.uv" } },
        },
      },
    }
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    require("lspconfig").lua_ls.setup { capabilities = capabilities }
    require('lspconfig').terraformls.setup { capabilities = capabilities }

    local telescope = require('telescope.builtin')
    local api, lsp = vim.api, vim.lsp
    local utils = require('utils')
    local map = utils.local_map(0)

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
        telescope[fn]({ jump_type = 'vsplit' })
      end, { desc = description })
    end

    local function attach_keymaps()
      local nx = { 'n', 'x' }

      map('n', 'gd', telescope.lsp_definitions, 'LSP definitions')
      map('n', 'gD', telescope.lsp_type_definitions, 'LSP type definitions')
      map('n', 'gi', telescope.lsp_implementations, 'LSP implementations')
      map('n', '<leader>ts', telescope.lsp_document_symbols, 'LSP document symbols')
      map('n', '<leader>tS', telescope.lsp_workspace_symbols, 'LSP workspace symbols')
      map('n', '<leader>tw', telescope.lsp_dynamic_workspace_symbols, 'LSP dynamic workspace symbols')
      map('n', 'gr', telescope.lsp_references, 'LSP references')

      map('n', 'gh', lsp.buf.hover, 'LSP hover')
      map('n', 'gs', lsp.buf.signature_help, 'LSP signature help')
      map({ 'i', 's' }, '<M-s>', lsp.buf.signature_help, 'LSP signature help')
      map(nx, '<leader>r', lsp.buf.rename, 'LSP rename')

      map_vsplit('<C-w>gd', 'lsp_definitions')
      map_vsplit('<C-w>gi', 'lsp_implementations')
      map_vsplit('<C-w>gD', 'lsp_type_definitions')
      map('n', '<leader>lq', '<cmd>LspStop<CR>', { desc = 'Stop LSP server' })
    end

    ---------------------------
    -- Default LSP on_attach --
    ---------------------------
    local augroup = api.nvim_create_augroup('lsp', { clear = true })

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
      end
    })
  end
}
