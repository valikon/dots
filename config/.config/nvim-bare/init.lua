local use = require('utils').use

require('configs.options')
require('configs.keymaps')
require('configs.autocmds')

-- Lazy
require('utils.lazy')

local plugins = {
  'folke/lazy.nvim',
  use 'barbar',
  use 'blink',
  use 'comment',
  use 'gitsigns',
  use 'lsp',
  use 'lsp-inlayhints',
  use 'mini',
  use 'oil',
  use 'telescope',
  use 'tokyonight',
  use 'treesitter',
  use 'noice',
  -- use 'go',
  -- use 'mason',
  -- use 'none-ls',
  -- use 'nvim-surround',
  -- use 'typescript',


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
