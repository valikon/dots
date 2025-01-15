---------------
-- Autocmds --
---------------

vim.api.nvim_create_augroup('GeneralAutocmds', {})

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

-- Check if any file has changed when Neovim is focused
vim.api.nvim_create_autocmd('FocusGained', {
  command = 'checktime',
  group = 'GeneralAutocmds'
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
