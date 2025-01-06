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

function M.error(message)
  vim.api.nvim_echo({ { message, 'Error' } }, false, {})
end

return M
