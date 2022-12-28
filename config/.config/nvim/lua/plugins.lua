-------------------------------------------------
-- PLUGINS
-------------------------------------------------

vim.cmd([[packadd packer.nvim]])

local status_ok, _ = pcall(require, "packer")
if not status_ok then
	print("Packer is not installed")
	return
end

-- Reloads Neovim after whenever you save plugins.lua
vim.cmd([[
    augroup packer_user_config
      autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Vim training mode
	use("ThePrimeagen/vim-be-good")

	-- lsp
	use("neovim/nvim-lspconfig")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = [[require('config.treesitter')]],
	})
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/nvim-treesitter-context")

	-- Lualine
	use({
		"nvim-lualine/lualine.nvim", -- A better statusline
		opt = true,
		event = "VimEnter",
		config = [[require('config.statusline')]],
	})

	-- Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		config = [[require('config.cmp-config')]],
		requires = {
			"hrsh7th/cmp-cmdline", -- command line
			"hrsh7th/cmp-buffer", -- buffer completions
			"hrsh7th/cmp-nvim-lua", -- nvim config completions
			"hrsh7th/cmp-nvim-lsp", -- lsp completions
			"hrsh7th/cmp-path", -- file path completions
			"saadparwaiz1/cmp_luasnip", -- snippets completions
		},
	})

	-- snippets
	use({ "L3MON4D3/LuaSnip", requires = {
		"rafamadriz/friendly-snippets",
	} })

	-- commenting
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({ "numToStr/Comment.nvim", tag = "v0.6", config = [[require('Comment').setup()]] })

	-- Formatting
	use({ "mhartington/formatter.nvim", config = [[require('config.formatter-config')]] })

	-- Undotree
	use("mbbill/undotree")

	-- file tree
	use({
		"kyazdani42/nvim-tree.lua",
		config = [[require('config.nvim-tree-config')]],
		requires = "nvim-tree/nvim-web-devicons",
	})
	-- icons
	use("nvim-tree/nvim-web-devicons")
	use({ "onsails/lspkind-nvim", config = [[require('config.lspkind-config')]] })

	-- Colorizer
	use({ "norcalli/nvim-colorizer.lua", config = [[require('config.colorizer-config')]] })

	-- jsonc file type for json - comments in json
	use("kevinoid/vim-jsonc")

	-- folke
	use("folke/which-key.nvim")
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})
	use({ "folke/tokyonight.nvim", config = require("config.theme-config") })

	-- better code action menu
	use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })

	-- Dashboard
	use({ "goolord/alpha-nvim", config = [[require('config.dashboard-config')]] })

	-- Productivity
	use("preservim/tagbar")
	use("lukas-reineke/indent-blankline.nvim") -- line indentation
	use("mg979/vim-visual-multi") -- multiline cursor
	use("windwp/nvim-ts-autotag") -- auto close and rename tags
	use({
		"windwp/nvim-autopairs", -- previously 'jiangmiao/auto-pairs'
		config = [[require('config.autopairs')]],
	})
	use({ "windwp/nvim-spectre", config = [[require('spectre').setup({})]] }) -- Spectre for find and replace
	--  use("vimwiki/vimwiki")
	--  use("nvim-orgmode/orgmode")

	-- Buffers and tabs
	use({ "tiagovla/scope.nvim", event = "VimEnter", config = [[require('scope').setup()]] })
	use({
		"akinsho/bufferline.nvim",
		event = "VimEnter",
		config = [[require('config.bline')]],
		tag = "v3.*",
		requires = "nvim-tree/nvim-web-devicons",
	})

	-- Tim Pope Plugins --
	use("tpope/vim-fugitive")
	use("tpope/vim-surround")
	-- use "tpope/vim-commentary"

	-- Syntax Highlighting and Colors --
	use({ "neovimhaskell/haskell-vim", config = [[require('config.haskell-vim')]] })
	use("ap/vim-css-color")
	use("rafi/awesome-vim-colorschemes")
	--  use("kovetskiy/sxhkd-vim")
	--  use("vim-python/python-syntax")

	-- fzf --
	-- use("junegunn/fzf")
	-- use("junegunn/fzf.vim")
	-- use({
	-- 	"ibhagwan/fzf-lua",
	-- 	-- optional for icon support
	-- 	branch = "main",
	-- 	requires = { "nvim-tree/nvim-web-devicons" },
	-- })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope").setup()
		end,
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			"nvim-telescope/telescope-project.nvim",
			"cljoly/telescope-repo.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{
				"ahmedkhalf/project.nvim",
				config = function()
					require("project_nvim").setup({})
				end,
			},
		},
	})

	use({
		"phaazon/hop.nvim",
		as = "hop",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- Other stuff --
	--  use("frazrepo/vim-rainbow")
	--  use("vifm/vifm.vim")

	-- -- sessions
	-- use({
	--   "rmagatti/auto-session",
	--   config = function()
	--     require("auto-session").setup({
	--       log_level = "error",
	--       auto_session_suppress_dirs = { "~/", "~/Projects" },
	--     })
	--   end,
	-- })
end)
