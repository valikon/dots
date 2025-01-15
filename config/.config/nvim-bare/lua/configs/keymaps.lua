-------------
-- Keymaps --
-------------
local utils = require('utils')
local map = utils.map

-- Leader --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map('n', '<S-Space>', '<Space>')

-- insert mode mappings
map('i', 'kk', "<ESC>")
map('i', 'jj', "<ESC>")
map('i', 'jk', "<ESC>")
map('i', "<C-E>", "<ESC>A") -- mimic shell movements
map('i', "<C-A>", "<ESC>I") -- mimic shell movements

-- lua dev
map("n", "<leader><leader>x", "<cmd>source %<CR>", "Source current file")
map("n", "<leader>x", ":.lua<CR>", "Execute lua")
map("v", "<leader>x", ":lua<CR>", "Execute lua")

-- quality of life stuff
map('n', "<leader>w", "<ESC>:w<CR>", "Write buffer")
map('n', "<leader>nh", ":nohl<CR>", "Reset highlight")
map('n', "x", '"_x') -- delete char without clipping

-- Files & Directories
map('n', '-', '<cmd>Oil<CR>', "Edit directory") -- open file/directory editor
map('n', '<leader>a', 'ggVG', "Select all")

-- quickfix lists
map('n', '<M-j>', '<cmd>cnext<CR>')     -- open next quickfix entry
map('n', '<M-k>', '<cmd>cprevious<CR>') -- open previous quickfix entry

-- code
map('n', 'gr', vim.lsp.buf.references)
map('n', 'gd', vim.lsp.buf.definition)

--terminal
map('t', '<esc><esc>', '<c-\\><c-n>')
map('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
end, "Simple terminal")
