local use = require('utils').use

require('configs.options')
require('configs.keymaps')
require('configs.autocmds')

-- Lazy
require('utils.lazy')

local plugins = {
  'folke/lazy.nvim',
  use 'blink',
  use 'comment',
  use 'lsp',
  use 'mini',
  use 'oil',
  use 'gitsigns',
  use 'telescope',
  use 'tokyonight',
  use 'treesitter',
  { 'folke/which-key.nvim', opts = {} },
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
