return {
	{
		"mfussenegger/nvim-jdtls",
		config = function() end,
	},
	{
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
			dap.adapters.java = {}

			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006,
			}

			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					mode = "remote",
					name = "Java - Attach Remote",
					cwd = "${workspaceFolder}",
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

			dap.configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
					host = function()
						local value = vim.fn.input("Host [127.0.0.1]: ")
						if value ~= "" then
							return value
						end
						return "127.0.0.1"
					end,
					port = function()
						local val = tonumber(vim.fn.input("Port: "))
						assert(val, "Please provide a port number")
						return val
					end,
				},
			}

			-- vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint' })
			-- 	vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpointCondition' })
			-- 	vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DapBreakpointRejected' })
			vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint" })
			vim.fn.sign_define("DapStopped", {
				text = " ",
				texthl = "DapStopped",
				linehl = "DapStoppedLine",
			})

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
	},
}
