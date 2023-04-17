local tbl_contains = vim.tbl_contains
local tbl_isempty = vim.tbl_isempty
local user_opts = astronvim.user_opts
--
local utils = require("astronvim.utils")
local conditional_func = utils.conditional_func
local is_available = utils.is_available

local function add_buffer_autocmd(augroup, bufnr, autocmds)
	if not vim.tbl_islist(autocmds) then
		autocmds = { autocmds }
	end
	local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
	if not cmds_found or vim.tbl_isempty(cmds) then
		vim.api.nvim_create_augroup(augroup, { clear = false })
		for _, autocmd in ipairs(autocmds) do
			local events = autocmd.events
			autocmd.events = nil
			autocmd.group = augroup
			autocmd.buffer = bufnr
			vim.api.nvim_create_autocmd(events, autocmd)
		end
	end
end

--
local M = {}

M.formatting = user_opts("lsp.formatting", { format_on_save = { enabled = true }, disabled = {} })
if type(M.formatting.format_on_save) == "boolean" then
	M.formatting.format_on_save = { enabled = M.formatting.format_on_save }
end

M.format_opts = vim.deepcopy(M.formatting)
M.format_opts.disabled = nil
M.format_opts.format_on_save = nil
M.format_opts.filter = function(client)
	local filter = M.formatting.filter
	local disabled = M.formatting.disabled or {}
	-- check if client is fully disabled or filtered by function
	return not (vim.tbl_contains(disabled, client.name) or (type(filter) == "function" and not filter(client)))
end

local lspsaga_status_ok, _ = pcall(require, "lspsaga")

local on_attach = function(client, bufnr)
	local lsp_mappings = { n = {}, v = {} }
	local capabilities = client.server_capabilities
	if capabilities.documentFormattingProvider and not tbl_contains(M.formatting.disabled, client.name) then
		lsp_mappings.n["Q"] = {
			function()
				vim.lsp.buf.format(M.format_opts)
			end,
			desc = "Format buffer",
		}
		lsp_mappings.v["Q"] = lsp_mappings.n["Q"]
	end

	if lspsaga_status_ok then
		lsp_mappings.n["<leader>li"] = {
			"<cmd>Lspsaga incoming_calls<CR>",
			desc = "Incoming Calls",
		}

		lsp_mappings.n["<leader>lo"] = {
			"<cmd>Lspsaga outgoing_calls<CR>",
			desc = "Outgoing Calls",
		}
	end

	utils.set_mappings(user_opts("lsp.mappings", lsp_mappings), { buffer = bufnr })
end

return on_attach
