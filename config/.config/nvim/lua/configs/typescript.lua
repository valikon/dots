----------------------
-- TypeScript Tools --
----------------------

return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  ft = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
  opts = {
    on_attach = function(client, bufnr)
      -- Disable formatting (use prettier instead, see `conform.lua`)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      local map = require('utils').local_map(bufnr)

      local organize_imports = '<cmd>TSToolsRemoveUnusedImports<CR><cmd>TSToolsOrganizeImports<CR>'

      map('n', '<leader>lo', organize_imports, 'LSP Organize imports')
      map('n', '<leader>li', '<cmd>TSToolsAddMissingImports<CR>', 'LSP add missing imports')
      map('n', '<leader>lf', '<cmd>TSToolsFixAll<CR>', 'LSP fix all errors')
      map('n', '<leader>lu', '<cmd>TSToolsRemoveUnused<CR>', 'LSP remove unused')
      map('n', '<leader>lr', '<cmd>TSToolsRenameFile<CR>', 'LSP rename file')
      map('n', '<leader>lc', function() require('tsc').run() end, 'Type check project')
    end,
    handlers = {
      ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
        if result.diagnostics == nil then
          return
        end

        -- Ignore some ts_ls diagnostics
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

        vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
      end,
    },
  },
}
