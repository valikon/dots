local ts_config = require("nvim-treesitter.configs")
local ts_context_config = require("treesitter-context")

ts_config.setup({
	ensure_installed = "all",
	sync_install = false,
	ignore_install = { "" },
	highlight = {
		enable = true,
		-- disable = { "" }, -- list of languages to disable
		additional_vim_regex_highlighting = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
		-- colors = {} -- table of hex strings
		-- termcolors = {} -- table of color name strings
	},
	-- disable = function(lang, buf)
	--     local max_filesize = 100 * 1024 -- 100 KB
	--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	--     if ok and stats and stats.size > max_filesize then
	--         return true
	--     end
	-- end,
})

require("treesitter-context").setup({
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
		-- For all filetypes
		-- Note that setting an entry here replaces all other patterns for this entry.
		-- By setting the 'default' entry below, you can control which nodes you want to
		-- appear in the context window.
		default = {
			"class",
			"function",
			"fn",
			"method",
			"for",
			"while",
			"if",
			"switch",
			"case",
			"interface",
			"struct",
			"enum",
		},
		-- Patterns for specific filetypes
		-- If a pattern is missing, *open a PR* so everyone can benefit.
		tex = {
			"chapter",
			"section",
			"subsection",
			"subsubsection",
		},
		haskell = {
			"adt",
		},
		rust = {
			"impl_item",
		},
		terraform = {
			"block",
			"object_elem",
			"attribute",
		},
		scala = {
			"object_definition",
		},
		vhdl = {
			"process_statement",
			"architecture_body",
			"entity_declaration",
		},
		markdown = {
			"section",
		},
		elixir = {
			"anonymous_function",
			"arguments",
			"block",
			"do_block",
			"list",
			"map",
			"tuple",
			"quoted_content",
		},
		json = {
			"pair",
		},
		typescript = {
			"export_statement",
		},
		yaml = {
			"block_mapping_pair",
		},
	},
	exact_patterns = {
		-- Example for a specific filetype with Lua patterns
		-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
		-- exactly match "impl_item" only)
		-- rust = true,
	},

	-- [!] The options below are exposed but shouldn't require your attention,
	--     you can safely ignore them.

	zindex = 20, -- The Z-index of the context window
	mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
})
