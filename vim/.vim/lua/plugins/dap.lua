return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
	},
	keys = {
		{ "<leader>do", ":lua require'dapui'.open()<CR>" },
		-- { "<F5>", ":lua require'dap'.continue()<CR>" },
		{ "<leader>dl", ":lua require'dap'.run_last()<CR>" },
		{ "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>" },
		{ "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
		{ "<leader>dlp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" },
		{ "<leader>dr", ":lua require'dap'.repl.open()<CR>" },
		{ "<leader>dt", ":Telescope dap configurations<CR>" },
	},
	config = function()
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

		dap.adapters.godot = {
			type = "server",
			host = "127.0.0.1",
			port = 6006,
		}

		dap.configurations.java = {
			{
				type = "java",
				request = "attach",
				name = "Java - Attach Remote",
				hostName = "127.0.0.1",
				port = 5005,
			},
		}
		dap.configurations.gdscript = {
			{
				name = "Godot - Launch Project",
				type = "godot",
				request = "launch",
				project = "${workspaceFolder}",
				additional_options = "",
			},
			{
				name = "Godot - Launch Current File",
				type = "godot",
				request = "launch",
				scene = "current",
				project = "${workspaceFolder}",
				additional_options = "",
			},
			{
				name = "Godot - Attach to Godot",
				type = "godot",
				request = "attach",
				address = "127.0.0.1",
				port = 6007,
			},
		}

		local dapui = require("dapui")
		vim.cmd("set mouse=n")
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
