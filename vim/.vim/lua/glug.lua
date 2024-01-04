local M = {}

-- Converts a lua value to a vimscript value
local primitives = { number = true, string = true, boolean = true }
M.convertLuaToVim = function(value)
	-- Functions refs that match the pattern "function(...)" are returned as is.
	if type(value) == "string" and string.match(value, "^function%(.+%)$") then
		return value
	elseif vim.tbl_islist(value) then
		return "[" .. table.concat(vim.tbl_map(M.convertLuaToVim, value), ", ") .. "]"
	elseif type(value) == "table" then
		local tbl_str_list = {}
		for key, val in pairs(value) do
			table.insert(tbl_str_list, vim.inspect(key) .. ": " .. M.convertLuaToVim(val))
		end
		return "{ " .. table.concat(tbl_str_list, ", ") .. " }"
	elseif primitives[type(value)] then
		return vim.inspect(value)
	end
	error("unsupported type for value: " .. type(value))
end

-- Allow glugin options to be set by `spec.opts`
-- This makes configuring options locally easier
M.glugOpts = function(name, spec)
	if type(spec) == "table" and type(spec.opts) == "table" then
		local originalConfig = spec.config
		spec.config = function(plugin, opts)
			local cmd = "let s:plugin = maktaba#plugin#Get('" .. name .. "')\n"
			for key, value in pairs(opts) do
				local vim_value = M.convertLuaToVim(value)
				cmd = cmd .. "call s:plugin.Flag(" .. vim.inspect(key) .. ", " .. vim_value .. ")\n"
			end
			vim.cmd(cmd)
			if type(originalConfig) == "function" then
				originalConfig(plugin, opts)
			end
		end
	end
	return spec
end

M.glug = function(name, spec)
	return M.glugOpts(
		name,
		vim.tbl_deep_extend("force", {
			name = name,
			dir = "/usr/share/vim/google/" .. name,
			dependencies = { "maktaba" },
		}, spec or {})
	)
end

-- veryLazy allows a plugin to be loaded on the `VeryLazy` event and
-- at the same time allow the plugin to bind ot any autocmd events that
-- come before `VeryLazy`, such as `FileType` and `BufRead`.
-- The `VeryLazy` command is fired after the UI is first loaded, using
-- this helps improve app start when nvim is opened with a file.

-- Events to check autocmds for. We target events that could fire before vim fully loads.
local events = { "BufEnter", "BufRead", "BufReadPost", "BufReadPre", "BufWinEnter", "FileType" }

-- A unique key to help identify autocmds.
local getAutocmdKey = function(autocmd)
	return table.concat({
		autocmd.event,
		autocmd.group or "",
		autocmd.id or "",
		autocmd.command or "",
		autocmd.buffer or "",
	}, "-")
end

-- Take note of which autocmds exist before any plugins are loaded.
local existingAutocmds = {}
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	once = true,
	callback = function()
		for _, autocmd in pairs(vim.api.nvim_get_autocmds({ event = events })) do
			existingAutocmds[getAutocmdKey(autocmd)] = true
		end
		for _, autocmd in pairs(vim.api.nvim_get_autocmds({ event = events, buffer = vim.api.nvim_list_bufs() })) do
			existingAutocmds[getAutocmdKey(autocmd)] = true
		end
	end,
})

M.veryLazy = function(spec)
	local originalConfig = spec.config

	return vim.tbl_extend("force", spec, {
		event = "VeryLazy",
		config = function(plugin, opts)
			if type(originalConfig) == "function" then
				originalConfig(plugin, opts)
			end

			-- Execute any missed autocmd events that fired before the plugin was loaded,
			-- and only for autocmds that were set by this plugin.
			for _, autocmd in pairs(vim.api.nvim_get_autocmds({ event = events })) do
				local autocmd_key = getAutocmdKey(autocmd)
				if not existingAutocmds[autocmd_key] then
					existingAutocmds[getAutocmdKey(autocmd)] = true
					vim.api.nvim_exec_autocmds(autocmd.event, { group = autocmd.group })
				end
			end
			for _, autocmd in pairs(vim.api.nvim_get_autocmds({ event = events, buffer = vim.api.nvim_list_bufs() })) do
				local autocmd_key = getAutocmdKey(autocmd)
				if not existingAutocmds[autocmd_key] then
					existingAutocmds[getAutocmdKey(autocmd)] = true
					vim.api.nvim_exec_autocmds(autocmd.event, { group = autocmd.group, buffer = autocmd.buffer })
				end
			end

			-- Source any ftplugin files for opened buffers.
			for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
				vim.api.nvim_buf_call(bufnr, function()
					local ftplugin_file = plugin.dir .. "/ftplugin/" .. vim.bo.filetype .. ".vim"
					if vim.fn.filereadable(ftplugin_file) == 1 then
						vim.cmd("source " .. ftplugin_file)
					end
				end)
			end
		end,
	})
end

return M
