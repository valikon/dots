local M = {}

function M.map(modes, lhs, rhs, opts)
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  local options = vim.tbl_extend('keep', opts or {}, { silent = true })
  vim.keymap.set(modes, lhs, rhs, options)
end

function M.local_map(buffer)
  return function(modes, lhs, rhs, opts)
    if type(opts) == 'string' then
      opts = { desc = opts, buffer = buffer }
    end
    local options = vim.tbl_extend('keep', opts or {}, { silent = true })

    vim.keymap.set(modes, lhs, rhs, options)
  end
end

--- Import plugin config from external module in `lua/configs/`
function M.use(module)
  local ok, m = pcall(require, string.format('configs.%s', module))
  if ok then
    return m
  else
    vim.notify(string.format('Failed to import Lazy config module %s: %s', module, m))
    return {}
  end
end

function M.termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.feedkeys(keys, mode)
  if mode == nil then mode = 'in' end
  return vim.api.nvim_feedkeys(M.termcodes(keys), mode, true)
end

function M.error(message)
  vim.api.nvim_echo({ { message, 'Error' } }, false, {})
end

local function lsp_server_has_references()
  return vim.tbl_contains(vim.lsp.get_clients(), function(client)
    local capabilities = client.server_capabilities
    return capabilities and capabilities.referencesProvider
  end, { predicate = true })
end

--- Clear all highlighted LSP references in all windows
function M.clear_lsp_references()
  vim.cmd.nohlsearch()
  if lsp_server_has_references() then
    vim.lsp.buf.clear_references()
    for _, buffer in pairs(M.visible_buffers()) do
      vim.lsp.util.buf_clear_references(buffer)
    end
  end
end

function M.noice_is_loaded()
  local success, _ = pcall(require, 'noice.config')
  return success and require('noice.config')._running
end

return M
