------------------
-- Conform.nvim --
------------------

return {
  'stevearc/conform.nvim',
  config = function()
    local b = vim.b
    local javascript = { 'prettierd', 'prettier', stop_after_first = true }
    require('conform').setup({
      format_on_save = function(bufnr)
        -- skip format for files matching provided patterns
        local name = vim.api.nvim_buf_get_name(bufnr)
        local skip_patterns = {
          "helmfile%.ya?ml",
          "helmfile%.d/.*%.ya?ml",
          ".*/templates/.*%.ya?ml",
          ".*/templates/.*%.tpl",
        }
        for _, pattern in ipairs(skip_patterns) do
          if name:match(pattern) then return nil end
        end

        -- always format unless specifically set for this particular buffer
        if vim.b.format_on_write ~= false then
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end
      end,
      formatters_by_ft = {
        javascript = javascript,
        typescript = javascript,
        typescriptreact = javascript,
        javascriptreact = javascript,
      },
    })
    vim.keymap.set('n', '<leader>lF', function()
      b.format_on_write = (not b.format_on_write and b.format_on_write ~= nil)
      local state = b.format_on_write and 'enabled' or 'disabled'
      vim.notify('Format on write ' .. state)
    end, { desc = 'Toggle autoformatting on write' })
  end,
}
