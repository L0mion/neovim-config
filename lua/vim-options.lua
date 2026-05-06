vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.mouse = "a"
vim.o.showmode = false

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.inccommand = "split"

vim.o.confirm = true

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.wrap = false

vim.opt.colorcolumn = { 80, 120 }

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },

	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	jump = { float = true },
})
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next diagnostic in current buffer" })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous diagnostic in current buffer" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<Enter>", "o<Esc>")
vim.keymap.set("n", "<S-Enter>", "O<Esc>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "Yank line to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.filetype.add({
	extension = {
		razor = "razor",
		cshtml = "razor",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	callback = function()
		if vim.fn.filereadable("build.ps1") == 1 then
			vim.opt.makeprg = "powershell -File build.ps1"
		end
	end,
})
vim.keymap.set("n", "<leader>cb", "<cmd>make<CR>", { desc = "Build using :make (calls build.ps1)" })
vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix window" })
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix window" })
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "Next compilation error" })
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>", { desc = "Prev compilation error" })
vim.keymap.set("n", "<leader>cf", "<cmd>cfirst<CR>", { desc = "First compilation error" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		map("<leader>dd", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	end,
})
