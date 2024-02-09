local use = require('utils').use

-- General configs
require('configs.options')
require('configs.keymaps')
require('configs.autocmds')
require('configs.commands')
require('configs.diagnostics')

-- Lazy
require('utils.lazy')

local plugins = {
  'folke/lazy.nvim',
  use 'barbar',
  use 'tokyonight',
  use 'comment',
  use 'cmp',
  use 'dap',
  use 'dap-ui',
  use 'dap-python',
  use 'treesitter',
  use 'treesitter.context-commentstring',
  use 'none-ls',
  use 'indent-blankline',
  use 'comment',
  use 'obsidian',
  use 'gitsigns',
  use 'nvim-surround',
  use 'nvim-tree',
  use 'mason',
  use 'lsp',
  use 'lsp-inlay-hints',
  use 'nvim-web-devicons',
  use 'lualine',   -- TODO install and configure feline
  use 'telescope', -- TODO do some more config, plain vanilla now

  'nvim-lua/plenary.nvim',
  'christoomey/vim-tmux-navigator',
  'szw/vim-maximizer',
  'vim-scripts/ReplaceWithRegister',

  { 'folke/which-key.nvim', opts = {} },

  {
    'tpope/vim-fugitive',                -- Git commands
    dependencies = 'tpope/vim-dispatch', -- Asynchronous `:Gpush`, etc.
    cmd = { 'G', 'Git', 'Gvdiffsplit' },
  },

}

require('lazy').setup({
  spec = plugins,
  concurrency = 30, -- GitHub seems to not allow too many concurrent fetches
  performance = {
    rtp = {
      disabled_plugins = { 'netrwPlugin', 'tutor' },
    },
  },
})

-- require('lazy').setup({
--   -- NOTE: First, some plugins that don't require any configuration
--
--   -- Git related plugins
--   'tpope/vim-fugitive',
--   'tpope/vim-rhubarb',
--
-- Useful plugin to show you pending keybinds.
-- {
--   -- Adds git related signs to the gutter, as well as utilities for managing changes
--   'lewis6991/gitsigns.nvim',
--   opts = {
--     -- See `:help gitsigns.txt`
--     signs = {
--       add = { text = '+' },
--       change = { text = '~' },
--       delete = { text = '_' },
--       topdelete = { text = '‾' },
--       changedelete = { text = '~' },
--     },
--     on_attach = function(bufnr)
--       vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
--
--       -- don't override the built-in and fugitive keymaps
--       local gs = package.loaded.gitsigns
--       vim.keymap.set({ 'n', 'v' }, ']c', function()
--         if vim.wo.diff then
--           return ']c'
--         end
--         vim.schedule(function()
--           gs.next_hunk()
--         end)
--         return '<Ignore>'
--       end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
--       vim.keymap.set({ 'n', 'v' }, '[c', function()
--         if vim.wo.diff then
--           return '[c'
--         end
--         vim.schedule(function()
--           gs.prev_hunk()
--         end)
--         return '<Ignore>'
--       end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
--     end,
--   },
-- },

-- {
--   -- Add indentation guides even on blank lines
--   'lukas-reineke/indent-blankline.nvim',
--   -- Enable `lukas-reineke/indent-blankline.nvim`
--   -- See `:help ibl`
--   main = 'ibl',
--   opts = {},
-- },

-- {
--   -- Highlight, edit, and navigate code
--   'nvim-treesitter/nvim-treesitter',
--   dependencies = {
--     'nvim-treesitter/nvim-treesitter-textobjects',
--   },
--   build = ':TSUpdate',
-- },

-- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
--       These are some example plugins that I've included in the kickstart repository.
--       Uncomment any of the lines below to enable them.
-- require 'kickstart.plugins.autoformat',
-- require 'kickstart.plugins.debug',

-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
--    up-to-date with whatever is in the kickstart repo.
--    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
--
--    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
-- { import = 'custom.plugins' },
-- }, {})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-- require('telescope').setup {
--   defaults = {
--     mappings = {
--       i = {
--         ['<C-u>'] = false,
--         ['<C-d>'] = false,
--       },
--     },
--   },
-- }

-- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })
--
-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
-- vim.defer_fn(function()
--   require('nvim-treesitter.configs').setup {
--     -- Add languages to be installed here that you want installed for treesitter
--     ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },
--
--     -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
--     auto_install = false,
--
--     highlight = { enable = true },
--     indent = { enable = true },
--     incremental_selection = {
--       enable = true,
--       keymaps = {
--         init_selection = '<c-space>',
--         node_incremental = '<c-space>',
--         scope_incremental = '<c-s>',
--         node_decremental = '<M-space>',
--       },
--     },
--     textobjects = {
--       select = {
--         enable = true,
--         lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--         keymaps = {
--           -- You can use the capture groups defined in textobjects.scm
--           ['aa'] = '@parameter.outer',
--           ['ia'] = '@parameter.inner',
--           ['af'] = '@function.outer',
--           ['if'] = '@function.inner',
--           ['ac'] = '@class.outer',
--           ['ic'] = '@class.inner',
--         },
--       },
--       move = {
--         enable = true,
--         set_jumps = true, -- whether to set jumps in the jumplist
--         goto_next_start = {
--           [']m'] = '@function.outer',
--           [']]'] = '@class.outer',
--         },
--         goto_next_end = {
--           [']M'] = '@function.outer',
--           [']['] = '@class.outer',
--         },
--         goto_previous_start = {
--           ['[m'] = '@function.outer',
--           ['[['] = '@class.outer',
--         },
--         goto_previous_end = {
--           ['[M'] = '@function.outer',
--           ['[]'] = '@class.outer',
--         },
--       },
--       swap = {
--         enable = true,
--         swap_next = {
--           ['<leader>a'] = '@parameter.inner',
--         },
--         swap_previous = {
--           ['<leader>A'] = '@parameter.inner',
--         },
--       },
--     },
--   }
-- end, 0)
