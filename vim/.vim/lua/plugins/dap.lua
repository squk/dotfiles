return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		-- <leader>dl :lua require'dapui'.open()<CR>
		-- <F5> :lua require'dap'.continue()<CR>
		-- <leader>dl :lua require'dap'.run_last()<CR>
		-- <leader>db :lua require'dap'.toggle_breakpoint()<CR>
		-- <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
		-- <leader>dlp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
		-- <leader>dr :lua require'dap'.repl.open()<CR>
		--
		require("telescope").load_extension("dap")
		local dap = require("dap")
		dap.adapters.java = function(callback)
			-- FIXME:
			-- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
			-- The response to the command must be the `port` used below
			callback({
				type = "server",
				host = "127.0.0.1",
				port = port,
			})
		end

		dap.configurations.java = {
			{
				type = "java",
				request = "attach",
				name = "Debug (Attach) - Remote",
				hostName = "127.0.0.1",
				port = 5005,
			},
		}
	end,
}
