-----------
-- Mason --
-----------
return {
  'williamboman/mason.nvim',
  dependencies = 'williamboman/mason-lspconfig.nvim',
  event = 'VeryLazy',
  opts = {
    ensure_installed = {
      "mypy",
      "ruff",
      "debugpy",
      "pyright",
    },
  },
}
