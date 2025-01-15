-------------------
-- User commands --
-------------------
local api, fn = vim.api, vim.fn

local function yank_file_path(expr)
  fn.setreg('+', fn.expand(expr))
  vim.notify('Yanked file path: ' .. fn.getreg('+'))
end

api.nvim_create_user_command(
  'YankPath',
  function()
    yank_file_path('%')
  end,
  { desc = "Yank current file's path relative to cwd" }
)

api.nvim_create_user_command(
  'YankPathFull',
  function() yank_file_path('%:~') end,
  { desc = "Yank current file's absolute path" }
)
