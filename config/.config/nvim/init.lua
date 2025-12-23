local use = require('utils').use

require('configs.diagnostics')
require('configs.options')
require('configs.keymaps')
require('configs.autocmds')

-- Lazy
require('utils.lazy')

local plugins = {
  'folke/lazy.nvim',
  use 'auto-session',
  use 'barbar',       -- Sexiest buffer tabline
  use 'blink',        -- Autocompletion
  use 'catppuccin',   -- use 'tokyonight', -- use 'onedark',
  use 'comment',      -- Adds `comment` verb
  use 'conform',      -- Autoformatting
  use 'feline',       -- Statusline framework
  use 'fugitive',     -- :Git commands
  use 'gitsigns',     -- Git status in sign column
  use 'highlighturl', -- Automatic URL highlighting
  use 'lazygit',
  use 'leap',         -- Move cursor anywhere
  use 'lsp',          -- Built-in LSP
  use 'mason',        -- LSP/DAP/etc. package manager
  use 'mini',
  use 'noice',        -- Nicer UI features
  use 'notify',       -- Floating notifications popups
  use 'nvim-tree',    -- File explorer
  use 'obsidian',
  use 'oil',          -- Single directory file browser
  use 'rustaceanvim', -- rust-analyzer client
  use 'snacks',
  use 'telescope',    -- Fuzzy finder
  use 'todos',
  use 'treesitter',   -- Abstract syntax tree
  use 'trouble',      -- Nicer list of diagnostics
  use 'twilight',
  use 'typescript',   -- Typescript LSP client wrapper
  use 'vim-maximizer',
  use 'vim-tmux-navigator',
  use 'zen-mode',
  -- use 'hardtime',
  { 'brenoprata10/nvim-highlight-colors', opts = {} },
  { 'folke/which-key.nvim',               opts = {} },
  { 'karb94/neoscroll.nvim',              opts = {} }, -- Smooth scrolling animations
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
