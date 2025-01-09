------------------
-- Comment.nvim --
------------------
return {
  'numToStr/Comment.nvim',
  lazy = false,
  config = function()
    local map = require('utils').map
    local filetype = require('Comment.ft')

    require('Comment').setup({
      ignore = '^$', -- Ignore empty lines
    })

    -- Custom comment strings
    filetype.http = '# %s'
  end,
}
