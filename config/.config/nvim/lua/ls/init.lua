-- require all language server modules
require("ls.typescript")
require("ls.eslint")
-- require("ls.css")
-- require("ls.html")
require("ls.luals")
require("ls.python")
-- require("ls.json")
require("ls.yaml")
-- require("ls.emmet")
-- require("ls.gql")
require("ls.rust")
require("ls.haskell")

-- Customization and appearance -----------------------------------------
-- change gutter diagnostic symbols
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = {
		source = "if_many",
		prefix = " ", -- Could be '●', '▎', 'x'
	},
	float = {
		source = "always",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})
