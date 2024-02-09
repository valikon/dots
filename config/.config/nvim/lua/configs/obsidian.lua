---------------
-- Obsidian ---
---------------

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local obsidian = require("obsidian")

    obsidian.setup({
      dir = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal",
      completion = {
        nvim_cmp = true,
        min_chars = 2,
        prepend_note_id = true,
        prepend_note_path = false,
        use_path_only = false,
      },
    })
  end,
}
