local M = {
	use_google_cache = nil,
	flags = {
		blink = false,
	},
}

function M.exec(command, args)
	local Job = require("plenary.job")
	local job = Job:new({
		command = command,
		args = args,
	})
	job:sync()
	job:wait()
	return job:result()
end

function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	-- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
	vim.keymap.set(mode, lhs, rhs, options)
end

function M.use_google()
	if M.use_google_cache == nil then
		M.use_google_cache = M.file_exists(os.getenv("HOME") .. "/use_google")
	end
	return M.use_google_cache
end

function M.file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

function M.dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

function M.tprint(tbl, indent)
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if type(k) == "number" then
			toprint = toprint .. "[" .. k .. "] = "
		elseif type(k) == "string" then
			toprint = toprint .. k .. "= "
		end
		if type(v) == "number" then
			toprint = toprint .. v .. ",\r\n"
		elseif type(v) == "string" then
			toprint = toprint .. '"' .. v .. '",\r\n'
		elseif type(v) == "table" then
			toprint = toprint .. M.tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

function M.log(message)
	local log_file_path = vim.fn.expand("$HOME/nvim.log")
	local log_file = io.open(log_file_path, "a")
	io.output(log_file)
	io.write(message .. "\n")
	io.close(log_file)
end

function M.TableConcat(t1, t2)
	for i = 1, #t2 do
		t1[#t1 + 1] = t2[i]
	end
	return t1
end

return M
