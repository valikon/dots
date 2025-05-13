------------
-- Feline --
------------
return {
  'second2050/feline.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/lsp-status.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require("feline").setup()
    vim.opt.laststatus = 3 -- Global statusline
  end
}
