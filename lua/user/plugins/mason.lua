return {
	{ "williamboman/mason.nvim", opts = { PATH = "append" } },
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"marksman",
				"taplo",
			},
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {
				"shellcheck",
				"stylua",
				"isort",
				"prettierd",
				"shfmt",
				"shellcheck",
			},
		},
		config = function(_, opts)
			local mason_null_ls = require("mason-null-ls")
			local null_ls = require("null-ls")
			mason_null_ls.setup(opts)
			mason_null_ls.setup_handlers({
				taplo = function() end, -- disable taplo in null-ls, it's taken care of by lspconfig
				prettierd = function()
					null_ls.register(
						null_ls.builtins.formatting.prettierd.with({ extra_filetypes = { "markdown", "rmd", "qmd" } })
					)
				end,
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = {
				"bash",
				-- "js",
				-- "python",
			},
		},
	},
}
