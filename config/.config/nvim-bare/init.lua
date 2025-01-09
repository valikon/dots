local use = require('utils').use

require('configs.options')
require('configs.keymaps')

-- Lazy
require('utils.lazy')

local plugins = {
  'folke/lazy.nvim',
  use 'tokyonight',
  use 'comment',
  use 'mini'
  -- use 'telescope',
  -- { 'folke/which-key.nvim', opts = {} },
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
