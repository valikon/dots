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
  use 'barbar',
  use 'blink',
  use 'catppuccin', -- use 'tokyonight', -- use 'onedark',
  use 'comment',
  use 'conform',
  use 'feline',
  use 'gitsigns',
  use 'hardtime',
  use 'lazygit',
  use 'leap',
  use 'lsp',
  use 'mason',
  use 'mini',
  use 'noice',
  use 'nvim-tree',
  use 'obsidian',
  use 'oil',
  use 'rustaceanvim',
  use 'snacks',
  use 'telescope',
  use 'todos',
  use 'treesitter',
  use 'trouble',
  use 'twilight',
  use 'typescript',
  use 'vim-maximizer',
  use 'vim-tmux-navigator',
  use 'zen-mode',
  { 'folke/which-key.nvim',  opts = {} },
  { 'karb94/neoscroll.nvim', opts = {} },
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
