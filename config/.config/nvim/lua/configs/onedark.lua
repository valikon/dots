-------------
-- Onedark --
-------------
---@diagnostic disable: missing-fields
return {
  "navarasu/onedark.nvim",
  priority = 999, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'dark'
    }
    -- Enable theme
    require('onedark').load()
  end
}
