return {
	"rebelot/heirline.nvim",
	opts = function(_, opts)
		local status = require("astronvim.utils.status")

		opts.statusline = { -- statusline
			hl = { fg = "fg", bg = "bg" },
			status.component.mode(),
			status.component.git_branch(),
			status.component.file_info({ filetype = {}, filename = false }),
			status.component.git_diff(),
			status.component.diagnostics(),
			status.component.fill(),
			status.component.cmd_info(),
			status.component.fill(),
			status.component.lsp(),
			status.component.treesitter(),
			status.component.nav({
				percentage = { padding = { left = 1, right = 1 } },
				scrollbar = false,
			}),
			{ -- tab list
				condition = function()
					return #vim.api.nvim_list_tabpages() >= 2
				end, -- only show tabs if there are more than one
				status.heirline.make_tablist({ -- component for each tab
					provider = status.provider.tabnr(),
					hl = function(self)
						return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true)
					end,
				}),
			},
			status.component.mode({ surround = { separator = "right" } }),
		}

		opts.tabline[2] = status.heirline.make_buflist(status.component.tabline_file_info({ close_button = false }))

		opts.winbar[1][1] =
			status.component.separated_path({ path_func = status.provider.filename({ modify = ":.:h" }) })
		opts.winbar[2] = {
			status.component.separated_path({ path_func = status.provider.filename({ modify = ":.:h" }) }),
			status.component.file_info({ -- add file_info to breadcrumbs
				file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
				file_modified = false,
				file_read_only = false,
				hl = status.hl.get_attributes("winbar", true),
				surround = false,
				update = "BufEnter",
			}),
			status.component.breadcrumbs({
				icon = { hl = true },
				hl = status.hl.get_attributes("winbar", true),
				prefix = true,
				padding = { left = 0 },
			}),
		}
		return opts
	end,
}
