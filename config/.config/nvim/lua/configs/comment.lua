------------------
-- Comment.nvim --
------------------
return {
  'numToStr/Comment.nvim',
  lazy = false,
  dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
  config = function()
    local map = require('utils').map
    local filetype = require('Comment.ft')
    local ts_context_integration = require(
      'ts_context_commentstring.integrations.comment_nvim'
    )

    require('Comment').setup({
      ignore = '^$', -- Ignore empty lines
      pre_hook = ts_context_integration.create_pre_hook(),
    })

    -- Custom comment strings
    filetype.http = '# %s'
    filetype.bicep = '// %s'
  end,
}
