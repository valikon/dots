---------------
-- Autocmds --
---------------

vim.api.nvim_create_augroup('GeneralAutocmds', {})
vim.api.nvim_create_augroup('lsp', { clear = true })

-- LSP Attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = 'lsp',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    require("lsp-inlayhints").on_attach(client, args.buf, false)

    if client.supports_method('textDocument/formatting') then
      -- Format the CURRENT buffer on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          -- 4 + 5
          vim.lsp.buf.format { async = false, id = args.data.client_id }
        end,
      })
    end
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

-- Check if any file has changed when Neovim is focused
vim.api.nvim_create_autocmd('FocusGained', {
  command = 'checktime',
  group = 'GeneralAutocmds'
})
