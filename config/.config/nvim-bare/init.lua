local use = require('utils').use

-- General configs
require('configs.options')
require('configs.keymaps')

-- local plugins = {
--   'folke/lazy.nvim',
--   -- use 'tokyonight',
--   -- use 'comment',
--   -- use 'lualine',   -- TODO install and configure feline
--   -- use 'telescope', -- TODO do some more config, plain vanilla now

--   { 'folke/which-key.nvim', opts = {} },
-- }

-- require('lazy').setup({
--   spec = plugins,
--   concurrency = 30, -- GitHub seems to not allow too many concurrent fetches
--   performance = {
--     rtp = {
--       disabled_plugins = { 'netrwPlugin', 'tutor' },
--     },
--   },
-- })
