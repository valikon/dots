-------------------
-- Highlight URL --
-------------------

local colors = require('utils.colors')

return {
  "rubiin/highlighturl.nvim",
  event = "VeryLazy",

  config = function()
    require("highlighturl").setup({
      -- Filetypes to skip highlighting
      ignore_filetypes = { "qf", "help", "NvimTree", "gitcommit" },

      -- URL highlight color (supports hex colors)
      highlight_color = colors.blue,

      -- Debounce delay (ms) for TextChanged events (improves performance)
      debounce_ms = 100,

      -- Whether to underline URLs
      underline = true,

      -- Suppress toggle notifications
      silent = true,
    })
  end,
}
