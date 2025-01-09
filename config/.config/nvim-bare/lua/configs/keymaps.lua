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
map('i', "<C-E>", "<ESC>A")          -- mimic shell movements
map('i', "<C-A>", "<ESC>I")          -- mimic shell movements

map("n", "<leader><leader>x", "<cmd>source %<CR>")  -- source current file
map("n", "<leader>x", ":.lua<CR>")                  -- execute lua code on the line
map("v", "<leader>x", ":lua<CR>")                   -- execute selected lua code

map('n', "<leader>w", "<ESC>:w<CR>") -- write buffer
map('n', "<leader>nh", ":nohl<CR>")  -- clear search highlight
map('n', "x", '"_x')                 -- delete char without clipping

-- map('n', "<leader>ff", ":Telescope find_files<CR>")
