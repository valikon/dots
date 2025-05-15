---------------
-- mini.nvim --
---------------

return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = true }

    -- extend and create a/i textobjects
    local ai = require 'mini.ai'
    ai.setup { silent = true }

    local surround = require 'mini.surround'
    surround.setup { silent = true }

    local pairs = require 'mini.pairs'
    pairs.setup { silent = true }
  end
}
