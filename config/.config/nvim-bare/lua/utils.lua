local M = {}

function M.map(modes, lhs, rhs, opts)
  -- if type(opts) == 'string' then
  --   opts = { desc = opts }
  -- end
  -- local options = vim.tbl_extend('keep', opts or {}, { silent = true })
  vim.keymap.set(modes, lhs, rhs, options)
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

function M.error(message)
  vim.api.nvim_echo({ { message, 'Error' } }, false, {})
end

return M
