-------------
-- Keymaps --
-------------
local bo, o = vim.bo, vim.o
local utils = require('utils')
local map = utils.map
local feedkeys = utils.feedkeys

-- Leader --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map('n', '<S-Space>', '<Space>')

map('i', 'kk', "<ESC>")
map('i', 'jj', "<ESC>")
map('i', 'jk', "<ESC>")
map('i', "<C-E>", "<ESC>A") -- mimic shell movements
map('i', "<C-A>", "<ESC>I") -- mimic shell movements
map('i', "<C-j>", "<ESC>ja")
map('i', "<C-k>", "<ESC>ka")
map('i', "<C-l>", "<ESC>la")
map('s', '<C-h>', '<BS>i')

-- dev
map("n", "<leader>X", "<cmd>source %<CR>", "Source current file")
map("n", "<leader>x", ":.lua<CR>", "Execute lua")
map("v", "<leader>x", ":lua<CR>", "Execute lua")

-- quality of life stuff
map('n', '<leader>a', 'ggVG', "Select all")
map('n', "<leader>w", "<ESC>:w<CR>", "Write buffer")
map('n', "<leader>nh", ":nohl<CR>", "Reset highlight")
map('n', "x", '"_x') -- delete char without clipping
map('n', '<C-j>', 'o<Esc>')
map('n', '<C-k>', 'O<Esc>')
map('n', '<M-BS>', 'db')
map('n', '<BS>', 'X')
map('n', '<M-j>', ':m      .+1<CR>==')
map('n', '<M-k>', ':m      .-2<CR>==')
map('x', '<M-j>', ":m      '>+1<CR>gv=gv")
map('x', '<M-k>', ":m      '<-2<CR>gv=gv")
map('i', '<M-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<M-k>', '<Esc>:m .-2<CR>==gi')
map('n', '<leader>i', ':source ~/.config/nvim/init.lua<CR>')
map('n', '<leader>I', ':edit   ~/.config/nvim/init.lua<CR>')
map('n', '<leader>F', ':edit   ~/.config/fish<CR>')
map('s', '<BS>', '<BS>i') -- By default <BS> puts you in normal mode
map({ 'n', 'i', 'v', 's', 'o', 't' }, '<C-m>', '<CR>', { remap = true })
map({ 'i', 'c' }, '<C-i>', '<Tab>', { remap = true })
map('n', 'g<C-a>', 'v<C-a>', 'Increment number under cursor')
map('n', 'g<C-x>', 'v<C-x>', 'Decrement number under cursor')
map('s', '<C-r>', '<C-g>c<C-r>', 'Insert content of a register')
map({ 'n', 'x' }, '<C-y>', '5<C-y>')
map({ 'n', 'x' }, '<C-e>', '5<C-e>')

map('n', '<leader><C-t>', function()
  bo.bufhidden = 'delete'
  feedkeys('<C-t>')
end, 'Delete buffer and pop jump stack')

map('n', '<leader>N', function()
  o.relativenumber = not o.relativenumber
  vim.notify('Relative line numbers ' .. (o.relativenumber and 'enabled' or 'disabled'))
end, 'Toggle relative line numbers')

map('n', '<leader>W', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify('Line wrap ' .. (vim.wo.wrap and 'enabled' or 'disabled'))
end, 'Toggle line wrap')

-- map('n', '<Esc>', function()
--   if vim.v.hlsearch == 1 then
--     vim.cmd.nohlsearch()
--   elseif bo.modifiable then
--     utils.clear_lsp_references()
--   elseif #vim.api.nvim_list_wins() > 1 then
--     return feedkeys('<C-w>c')
--   end
--   vim.cmd.fclose({ bang = true })
-- end, 'Close window if not modifiable, otherwise clear LSP references')

map('n', '<C-l>', function()
  require('notify').dismiss({ silent = true, pending = true }) -- Dismiss all notifcatcions on screen
  feedkeys('<C-l>')
end, { silent = true, desc = "Dismiss all notifications on screen" })



-- Files & Directories
map('n', '-', '<cmd>Oil<CR>', "Edit directory") -- open file/directory editor

-- quickfix lists
map('n', '<M-j>', '<cmd>cnext<CR>')     -- open next quickfix entry
map('n', '<M-k>', '<cmd>cprevious<CR>') -- open previous quickfix entry

--terminal
map('t', '<esc>', '<c-\\><c-n>')
map('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
end, "Simple terminal")
