-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"angular",
				"bash",
				"c",
				"c_sharp",
				"cmake",
				"cpp",
				"css",
				"diff",
				"git_config",
				"gitignore",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"mermaid",
				"powershell",
				"python",
				"query",
				"razor",
				"sql",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}
