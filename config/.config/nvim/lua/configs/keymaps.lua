-------------
-- Keymaps --
-------------
local bo, o, wo, v, fn = vim.bo, vim.o, vim.wo, vim.v, vim.fn
local utils = require('utils')
local map = utils.map
local feedkeys, feedkeys_count = utils.feedkeys, utils.feedkeys_count

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
map('i', "<C-'>", "``<esc>i")        -- Backtick

map('n', "<leader>w", "<ESC>:w<CR>") -- write buffer
map('n', "<leader>nh", ":nohl<CR>")  -- clear search highlight
map('n', "x", '"_x')                 -- delete char without clipping

map('n', "<leader>ff", ":Telescope find_files<CR>")

-- map('n', "<leader>sv", "<C-w>v")        -- split window vertically
-- map('n', "<leader>sh", "<C-w>s")        -- split window horizontally
-- map('n', "<leader>se", "<C-w>=")        -- make split windows equal width
-- map('n', "<leader>sx", ":close<CR>")    -- close current split window

-- map("n", "<leader>to", ":tabnew<CR>")   -- open new tab
-- map("n", "<leader>tx", ":tabclose<CR>") -- close current tab
-- map("n", "<leader>tn", ":tabn<CR>")     -- go to next tab
-- map("n", "<leader>tp", ":tabp<CR>")     -- go to previous tab


----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
map('n', "<leader>sm", ":MaximizerToggle<CR>") -- toggle split vindow maximizer

-- nvim-tree
map('n', "<leader>e", ":NvimTreeToggle<CR>")


--
-- Melkers keymaps
--

-- map({'n', 'v'}, '<C-q>',         ':qa<CR>')
-- map('n',        '<C-j>',         'o<Esc>')
-- map('n',        '<C-j>',         'i<CR><Esc>')
-- map('n',        '<C-k>',         'O<Esc>')
-- map('n',        'g<C-k>',        'DO<Esc>P_')
-- map('n',        'gK',            'kjddkPJ<C-y>')
-- map('n',        '<C-s>',         ':w<CR>',        { silent = true })
-- map({'i', 's'}, '<C-s>',         '<Esc>:w<CR>',   { silent = true })
-- map('x',        '<C-s>',         '<Esc>:w<CR>gv', { silent = true })
-- map('x',        'v',             '$h')
-- map('n',        '<BS>',          'X')
-- map('n',        '<M-BS>',        'db')
-- map({'i', 'c'}, '<M-BS>',        '<C-w>')
-- map('!',        '<C-f>',         '<Right>')
-- map('!',        '<M-f>',         '<C-Right>')
-- map('!',        '<C-b>',         '<Left>')
-- map('!',        '<M-l>',         '<Right>')
-- map('!',        '<M-h>',         '<Left>')
-- map('s',        '<M-l>',         '<Esc><Right>i')
-- map('s',        '<M-h>',         '<Esc><Left>i')
-- map('c',        '<C-p>',         '<Up>')
-- map('c',        '<C-n>',         '<Down>')
-- map('c',        '<C-q>',         '<Esc>')
-- map('!',        '<M-b>',         '<C-Left>')
-- map('!',        '<M-w>',         '<C-Right>')
-- map('c',        '<C-a>',         '<Home>')
-- map('n',        '<M-j>',         ':m      .+1<CR>==')
-- map('n',        '<M-k>',         ':m      .-2<CR>==')
-- map('x',        '<M-j>',         ":m      '>+1<CR>gv=gv")
-- map('x',        '<M-k>',         ":m      '<-2<CR>gv=gv")
-- map('i',        '<M-j>',         '<Esc>:m .+1<CR>==gi')
-- map('i',        '<M-k>',         '<Esc>:m .-2<CR>==gi')
-- map('n',        '<C-w>C',        ':tabclose<CR>')
-- map('n',        '<C-c>',         '<Nop>') -- Allow <C-w><C-c>
-- map('n',        '<leader>wn',    ':tab split<CR>')
-- map('n',        '<leader>wc',    ':tabclose<CR>')
-- map('n',        '<leader>wo',    ':tabonly<CR>')
-- map('n',        '<leader><Esc>', '<Nop>')
-- map('n',        '<leader>i',     ':source ~/.config/nvim/init.lua<CR>')
-- map('n',        '<leader>I',     ':edit   ~/.config/nvim/init.lua<CR>')
-- map('n',        '<leader>V',     ':edit   ~/.config/nvim/config.vim<CR>')
-- map('n',        '<leader>Z',     ':edit   ~/.zshrc<CR>')
-- map('n',        'gX',            ':exec   "silent !brave %:p &"<CR>')
-- map('x',        '//',            'omsy/<C-R>"<CR>`s')
-- map('n',        '/',             'ms/', { silent = false })
-- map('n',        '*',             'ms*')
-- map('n',        'g*',            'msg*`s')
-- map('n',        '<leader>*',     'ms*`s')
-- map('n',        '<leader>g*',    'msg*`s')
-- map('n',        '#',             'ms#')
-- map('n',        'g#',            'msg#`s')
-- map('n',        '`/',            '`s')
-- map('n',        'g/',            '/\\<\\><Left><Left>')
-- map('n',        '<leader>R',     ':%s/<C-R><C-W>//gci<Left><Left><Left><Left>')
-- map({'n', 'x'}, '<leader>q',     'qqqqq')
-- map({'n', 'x'}, 'Q',             '@@')
-- map('n',        'cg*',           '*Ncgn')
-- map('n',        'dg*',           '*Ndgn')
-- map('x',        'gcn',           '//Ncgn')
-- map('x',        'gdn',           '//Ndgn')
-- map('n',        'g.',            '/\\V\\C<C-R>"<CR>cgn<C-a><Esc>')
-- map('x',        'g.',            '.')
-- map({'n', 'x'}, '[y',            '`[', 'First character of latest yank')
-- map({'n', 'x'}, ']y',            '`]', 'Last character of latest yank')
-- map({'n', 'x'}, '[v',            '`<', 'First character of latest visual select')
-- map({'n', 'x'}, ']v',            '`>', 'Last character of latest visual select')

-- local function spell_jump(command)
--   return function()
--     local spell = wo.spell
--     wo.spell = true
--     feedkeys_count(command, 'xn')
--     wo.spell = spell
--   end
-- end
--
-- map('n', ']s', spell_jump(']s'), 'Jump to next spelling error')
-- map('n', '[s', spell_jump('[s'), 'Jump to previous spelling error')
--
-- local function char_search(forward, backward)
--   return function()
--     if fn.getcharsearch().forward == 1 then
--       feedkeys_count(forward)
--     else
--       feedkeys_count(backward)
--     end
--   end
-- end
--
-- -- ;/, always search forwards/backwards, respectively
-- map({'n', 'x'}, ';', char_search(';', ','))
-- map({'n', 'x'}, ',', char_search(',', ';'))
--
-- map('n', '<leader>K',        ':vertical Man <C-R><C-W><CR>')
-- map('x', '<leader>K',        'y:vertical Man <C-R>"<CR>')
--
-- map({'n', 'x'}, 'g)',        'w)ge')
-- map({'n', 'x'}, 'g(',        '(ge')
-- map('o',        'g)',        ':silent normal vg)h<CR>')
-- map('o',        'g(',        ':silent normal vg(oh<CR>')
-- map({'n', 'x'}, 'sP',        ':setlocal spell!<CR>', 'Toggle spell check')
--
-- -- Adds previous cursor location to jumplist if count is > 5
-- local function move_vertically(direction)
--   return function()
--     local mark = v.count > 5 and "m'" or ""
--     feedkeys(mark .. v.count1 .. direction)
--   end
-- end
--
-- map('n', 'k', move_vertically('k'), 'k')
-- map('n', 'j', move_vertically('j'), 'j')
-- map('n', '-', move_vertically('-'), 'k')
-- map('n', '+', move_vertically('+'), 'j')
--
-- -- Sets the font size
-- local function zoom_set(font_size)
--   return function()
--     if fn.exists('g:goneovim') then
--       o.guifont = fn.substitute(
--         fn.substitute(o.guifont, ':h\\d\\+', ':h' .. font_size, ''),
--         ' ',
--         '\\ ',
--         'g'
--       )
--     else
--       local font = fn.substitute(o.guifont, ':h\\d\\+', ':h' .. font_size, '')
--       vim.cmd('GuiFont! ' .. font)
--     end
--   end
-- end
--
-- -- Increases the font zise with `amount`
-- local function zoom(amount)
--   return function()
--     zoom_set(fn.matchlist(o.guifont, ':h\\(\\d\\+\\)')[2] + amount)()
--   end
-- end
--
-- map('n', '<C-=>', zoom(v.count1))
-- map('n', '<C-+>', zoom(v.count1))
-- map('n', '<C-->', zoom(-v.count1))
-- map('n', '<C-0>', zoom_set(11))
--
-- map('n', '<C-w><C-n>', '<cmd>vnew<CR>')
-- map('n', '<C-w><C-^>', '<C-w>v<C-6>')
-- map('n', '<C-w>6',     '<C-w>v<C-6>')
--
-- map('s', '<BS>', '<BS>i') -- By default <BS> puts you in normal mode
-- map('s', '<C-h>', '<BS>i')
-- map({'n', 'i', 'v', 's', 'o', 't'}, '<C-m>', '<CR>', { remap = true })
-- map({'i', 'c'}, '<C-i>', '<Tab>', { remap = true })
-- map('n', 'g<C-a>', 'v<C-a>', 'Increment number under cursor')
-- map('n', 'g<C-x>', 'v<C-x>', 'Decrement number under cursor')
-- map('s', '<C-r>', '<C-g>c<C-r>', 'Insert content of a register')
--
-- map('n', '<leader><C-t>', function()
--   bo.bufhidden = 'delete'
--   feedkeys('<C-t>')
-- end, 'Delete buffer and pop jump stack')
-- map('n', '<leader>N', function()
--   o.relativenumber = not o.relativenumber
--   vim.notify('Relative line numbers ' .. (o.relativenumber and 'enabled' or 'disabled'))
-- end, 'Toggle relative line numbers')
-- map('n', '<leader>W', function()
--   vim.wo.wrap = not vim.wo.wrap
--   vim.notify('Line wrap ' .. (vim.wo.wrap and 'enabled' or 'disabled'))
-- end, 'Toggle line wrap')
--
-- map('n', '<Esc>', function()
--   if vim.v.hlsearch == 1 then
--     vim.cmd.nohlsearch()
--   elseif bo.modifiable then
--     utils.clear_lsp_references()
--   elseif #vim.api.nvim_list_wins() > 1 then
--     return feedkeys('<C-w>c')
--   end
--
--   utils.close_floating_windows()
-- end, 'Close window if not modifiable, otherwise clear LSP references')
-- map('t', '<Esc>', '<C-\\><C-n>')
-- map('n', '<C-l>', '<cmd>LuaSnipUnlinkCurrent<CR><C-l>')
--
-- map({'n', 'x'}, '<C-y>', '5<C-y>')
-- map({'n', 'x'}, '<C-e>', '5<C-e>')
--
-- vim.api.nvim_create_augroup('CmdWinMaps', {})
-- vim.api.nvim_create_autocmd('CmdwinEnter', {
--   callback = function()
--     map('n', '<CR>',  '<CR>',   { buffer = true })
--     map('n', '<Esc>', '<C-w>c', { buffer = true })
--   end,
--   group = 'CmdWinMaps'
-- })

--
-- Kickstart keymaps
--

-- document existing key chains
--require('which-key').register {
--['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
--['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
--}

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--
-- -- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--
-- -- [[ Highlight on yank ]]
-- -- See `:help vim.highlight.on_yank()`
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
--   group = highlight_group,
--   pattern = '*',
-- })
--
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
