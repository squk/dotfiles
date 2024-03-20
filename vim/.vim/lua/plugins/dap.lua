return {
	{
		"mfussenegger/nvim-jdtls",
		config = function() end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
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
			local use_google = require("utils").use_google
			require("telescope").load_extension("dap")
			local dap = require("dap")

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError" })

			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = vim.fn.exepath("OpenDebugAD7"),
			}

			if use_google then
				dap.adapters.lldb = {
					type = "executable",
					-- sudo apt install google-lldb-vscode
					command = "/usr/share/code/resources/app/extensions/google-lldb-vscode/bin/lldb-dap",
					name = "lldb",
					sourceMap = {
						{ "/proc/self/cwd", "${workspaceFolder}" },
					},
					cwd = "${workspaceFolder}",
					debuggerRoot = "${workspaceFolder}",
					sourcePath = "${workspaceFolder}",
				}
			end

			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006,
			}

			dap.configurations.cppdbg = {
				{
					name = "Attach to gdbserver :5555",
					type = "cppdbg",
					request = "launch",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:5555",
					miDebuggerPath = vim.fn.exepath("gdb"),
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
			}

			dap.configurations.cpp = {
				{
					-- If you get an "Operation not permitted" error using this, try disabling YAMA:
					--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					name = "Attach to process",
					type = "lldb",
					request = "attach",
					pid = require("dap.utils").pick_process,
					args = {},
				},
				{
					name = "Wait for process name",
					type = "lldb",
					request = "attach",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					waitFor = true,
				},
				{
					type = "lldb",
					request = "attach",
					mode = "remote",
					name = "Attach Remote",
					attachCommands = { "gdb-remote localhost:5555" },
				},
			}
			-- dap.configurations.c = dap.configurations.cpp

			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					mode = "remote",
					name = "Attach Remote",
					cwd = "${workspaceFolder}",
					hostName = "127.0.0.1",
					port = 5005,
				},
			}

			dap.configurations.gdscript = {
				{
					name = "Launch Project",
					type = "godot",
					request = "launch",
					project = "${workspaceFolder}",
					additional_options = "",
				},
				{
					name = "Launch Current File",
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
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				vim.cmd("set mouse=a")
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				vim.cmd("set mouse=")
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				vim.cmd("set mouse=")
				dapui.close()
			end
		end,
	},
}
