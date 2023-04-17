return {
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		commit = "44ae62d",
		config = function()
			require("lspsaga").setup({
				ui = {
					border = "solid",
				},
				symbol_in_winbar = {
					enable = false,
				},
			})
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	{
		"ldelossa/litee-calltree.nvim",
		config = function()
			require("litee.lib").setup({})

			require("litee.calltree").setup({})

			vim.lsp.handlers["callHierarchy/incomingCalls"] =
				vim.lsp.with(require("litee.lsp.handlers").ch_lsp_handler("from"), {})
			vim.lsp.handlers["callHierarchy/outgoingCalls"] =
				vim.lsp.with(require("litee.lsp.handlers").ch_lsp_handler("to"), {})
		end,
		dependencies = {
			{ "ldelossa/litee.nvim" },
		},
	},
}
