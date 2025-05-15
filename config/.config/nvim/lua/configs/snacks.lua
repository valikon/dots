-----------------
-- snacks.nvim --
-----------------

return {
  'folke/snacks.nvim',
  priority = 999,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      keys = {
        -- { icon = " ", key = "s", desc = "Restore Session", action = "<cmd>SessionRestore<CR>" },  TODO: consider switching to mini.sessions
      },
      formats = {
        key = function(item)
          return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
        end,
      },
      sections = {
        { section = "terminal", cmd = "fortune -s | cowsay | lolcat", hl = "header", padding = 1, indent = 8 },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { section = "recent_files", cwd = true, limit = 8, padding = 1 },
        { title = "Projects", padding = 1 },
        { section = "projects", padding = 1 },
        { section = "startup" }
      },
      enabled = true
    }
  }
}
