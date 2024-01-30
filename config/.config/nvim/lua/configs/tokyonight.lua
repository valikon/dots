-- Colorscheme setup
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "storm",
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "dark",
      floats = "dark",
    },
    sidebars = { "help", "terminal" },
    hide_inactive_statusline = false, 
    dim_inactive = false,
    lualine_bold = false,
  },
  config = function()
    vim.cmd.colorscheme('tokyonight-storm')
  end
}
