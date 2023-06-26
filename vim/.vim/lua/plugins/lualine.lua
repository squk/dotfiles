local split = function(inputstr, sep)
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end
local function getCitc()
	local fname = vim.api.nvim_buf_get_name(0)
	if string.find(fname, "/google/src/cloud/", 1, true) then
		local parts = split(fname, "/")
		return parts[5]
	end
end
local function isCiderLspAttached()
	if vim.b["is_cider_lsp_attached"] then
		if vim.b["is_cider_lsp_attached"] == "yes" then
			return "✓"
		else
			return "x"
		end
	else
		return ""
	end
end

local function getLightbulb()
	return require("nvim-lightbulb").get_status_text()
end

local function getLGTMs()
	local comments = require("google.comments")
	local tracker = require("google.comments.tracker")
	local dump = require("utils").dump

	print(dump(tracker.get_all_comments()))
	local lgtm = comments.get_lgtms()
	local appr = comments.get_approvals()
	print("lgtms" .. dump(lgtm))
	print("approvals" .. dump(appr))
	return "LGTM:" .. table.concat(lgtm, ",") .. "   Approval:" .. table.concat(appr, ",")
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		local lsp_status = require("lsp-status")

		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", getCitc, isCiderLspAttached },
				lualine_c = { getLightbulb, "filename" },
				lualine_x = {
					"aerial",
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			tabline = {
				lualine_a = {
					{
						"tabs",
						mode = 1,
						use_mode_colors = true,
						max_length = (vim.o.columns / 5) * 4,
						fmt = function(name, context)
							-- Show + if buffer is modified in tab
							local buflist = vim.fn.tabpagebuflist(context.tabnr)
							local winnr = vim.fn.tabpagewinnr(context.tabnr)
							local bufnr = buflist[winnr]
							local mod = vim.fn.getbufvar(bufnr, "&mod")

							return name .. (mod == 1 and " +" or "")
						end,
					},
				},
				lualine_b = { "branch" },
				-- lualine_c = { "filename" },
				lualine_c = {
					{
						"diagnostics",
						sources = { "nvim_workspace_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
				},
				-- lualine_y = { getLGTMs }
			},
		})
	end,
}
