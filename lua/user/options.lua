vim.cmd([[ set isfname-=: ]])
-- vim.cmd([[ set fillchars+=diff:╱,fold: ]])
vim.cmd([[ autocmd FileType * set formatoptions-=o ]])
vim.cmd([[ autocmd User TelescopePreviewerLoaded setlocal wrap nu ]]) -- wrap + line number telescope
vim.cmd([[ set diffopt+=vertical ]]) -- vertical fugitive diffs

return {
	opt = {
		conceallevel = 2, -- enable conceal
		list = true, -- show whitespace characters
		-- listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
		listchars = { extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
		showbreak = "↪  ",
		showtabline = 0,
		-- spellfile = vim.fn.expand "~/.config/nvim/lua/user/spell/en.utf-8.add",
		swapfile = false,
		-- thesaurus = vim.fn.expand "~/.config/nvim/lua/user/spell/mthesaur.txt",
		wrap = true, -- soft wrap lines
		-- fillchars = vim.opt.fillchars + "diff:╱" + "fold: ", -- TODO: giving error, look into it later
		nrformats = vim.opt.nrformats + "alpha", -- to increment alphabets as well
	},
}
