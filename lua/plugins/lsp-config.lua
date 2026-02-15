return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"clang-format",
					"clangd",
					"codelldb",
					"csharpier",
					"cssls",
					"html",
					"lua_ls",
					"netcoredbg",
					"powershell_es",
					"roslyn",
					"stylua",
					"ts_ls",
				},
				auto_update = false,
				run_on_start = true,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("powershell_es", {
				bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
			})
		end,
	},
	{
		"seblyng/roslyn.nvim",
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		ft = { "cs", "razor" },
		opts = {},
	},
}
