return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- UI setup
			dapui.setup()

			-- Auto open/close UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Get netcoredbg from Mason
			local mason_path = vim.fn.stdpath("data") .. "/mason/"
			local netcoredbg_path = mason_path .. "packages/netcoredbg/netcoredbg/netcoredbg.exe"

			dap.adapters.coreclr = {
				type = "executable",
				command = netcoredbg_path,
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch netcoredbg",
					request = "launch",
					program = function()
						local cwd = vim.fn.getcwd()
						local dll = vim.fn.glob(cwd .. "/bin/Debug/net*/" .. vim.fn.fnamemodify(cwd, ":t") .. ".dll")

						if dll == "" then
							print("No DLL found. Build the project first.")
							return ""
						end
						return dll
					end,
				},
			}

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "\\mason\\bin\\codelldb.cmd",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.cpp = {
				{
					type = "codelldb",
					name = "Launch codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			-- Keymaps
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F10>", dap.step_over)
			vim.keymap.set("n", "<F11>", dap.step_into)
			vim.keymap.set("n", "<F12>", dap.step_out)
			vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>dr", dap.repl.open)
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
}
