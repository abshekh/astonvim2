vim.api.nvim_create_autocmd("VimLeave", {
	desc = "Stop running auto compiler",
	group = vim.api.nvim_create_augroup("autocomp", { clear = true }),
	pattern = "*",
	callback = function()
		vim.fn.jobstart({ "autocomp", vim.fn.expand("%:p"), "stop" })
	end,
})

-- text like documents enable wrap and spell
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "text", "plaintex" },
	group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd([[
  au BufNewFile,BufRead *.log  :setl ft=my-log
  au BufNewFile,BufRead *.purs :setl ft=purescript
  autocmd BufEnter,BufRead * normal zR
]])

vim.cmd([[
  augroup neovim_terminal
      autocmd!
      " Enter Terminal-mode (insert) automatically
      autocmd TermOpen * startinsert
      " Disables number lines on terminal buffers
      autocmd TermOpen * :set nonumber norelativenumber
      " allows you to use Ctrl-c on terminal window
      autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
      autocmd TermClose zsh call feedkeys("i")
  augroup END
]])
