local M = {}

function M.check_lsp_client_active(name)
	local clients = vim.lsp.get_active_clients()
	for _, client in pairs(clients) do
		if client.name == name then
			return true
		end
	end
	return false
end

function M.define_augroups(definitions) -- {{{1
	-- Create autocommand groups based on the passed definitions
	--
	-- The key will be the name of the group, and each definition
	-- within the group should have:
	--    1. Trigger
	--    2. Pattern
	--    3. Text
	-- just like how they would normally be defined from Vim itself
	for group_name, definition in pairs(definitions) do
		vim.cmd("augroup " .. group_name)
		vim.cmd("autocmd!")

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.cmd(command)
		end

		vim.cmd("augroup END")
	end
end

-- misc
function M.file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- Find a file either using git files or search the filesystem.
function M.find_files()
	local opts = {}
	local telescope = require("telescope.builtin")

	local ok = pcall(telescope.git_files, opts)
	if not ok then
		telescope.find_files(opts)
	end
end

function M.find_buffers()
	local results = {}
	local buffers = vim.api.nvim_list_bufs()

	for _, buffer in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buffer) then
			local filename = vim.api.nvim_buf_get_name(buffer)
			table.insert(results, filename)
		end
	end

	vim.ui.select(results, { prompt = "Find buffer:" }, function(selected)
		if selected then
			vim.api.nvim_command("buffer " .. selected)
		end
	end)
end

-- find dotfiles
function M.find_dotfiles()
	require("telescope.builtin").find_files({
		prompt_title = "<Dotfiles>",
		cwd = "$HOME/dots",
	})
end

return M
