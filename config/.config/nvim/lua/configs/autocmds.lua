---------------
-- Autocmds --
---------------
local o, opt, bo, wo, fn = vim.o, vim.opt, vim.bo, vim.wo, vim.fn
local utils = require('utils')
local map = utils.map

vim.api.nvim_create_augroup('GeneralAutocmds', {})
vim.api.nvim_create_augroup('FileTypeAutocmds', {})

-- TypeScript specific --
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typescript',
  callback = function()
    opt.matchpairs:append('<:>')
  end,
  group = 'FileTypeAutocmds',
})

-- Disabled until TSLspOrganize and/or TSLspImportAll doesn't collide with
--     ['*.ts,*.tsx'] = function()
--       if b.format_on_write ~= false then
--         vim.cmd 'TSLspOrganize'
--         vim.cmd 'TSLspImportAll'
--       end
--     end
--   }
-- }

-- Check if any file has changed when Neovim is focused
vim.api.nvim_create_autocmd('FocusGained', {
  command = 'checktime',
  group = 'GeneralAutocmds',
})

-- Custom filetypes
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.dconf',
  callback = function() o.syntax = 'sh' end,
  group = 'FileTypeAutocmds',
})

-- Open :help in vertical split instead of horizontal
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    bo.bufhidden = 'unload'
    vim.cmd.wincmd('L')
    vim.cmd 'vertical resize 81'
  end,
  group = 'FileTypeAutocmds',
})

-- Don't conceal current line in some file formats
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'latex', 'tex', 'json', 'http' },
  callback = function() wo.concealcursor = '' end,
  group = 'FileTypeAutocmds',
})

-- Markdown specific --
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- Adds horizontal line below and enters insert mode below it
    map('n', '<leader>-', 'o<Esc>0"_Do<Esc>0"_C---<CR><CR>')
  end,
  group = 'FileTypeAutocmds',
})

-- Filetype specific indent settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'css', 'python', 'cs' },
  callback = function() bo.shiftwidth = 4 end,
  group = 'FileTypeAutocmds',
})

-- Start git commits at start of line, and insert mode if message is empty
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    wo.spell = true
    if fn.getline(1) == '' then
      vim.cmd('startinsert!')
    end
  end,
  group = 'FileTypeAutocmds',
})

-- `K` in Lua files opens Vim helpdocs
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function() bo.keywordprg = ':help' end,
  group = 'FileTypeAutocmds',
})
