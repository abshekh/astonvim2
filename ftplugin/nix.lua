local map = vim.keymap.set
map("n", "Q", "<cmd>%!nixpkgs-fmt<CR>", { buffer = true, noremap = true })
map({ "v", "x" }, "Q", "<esc><cmd>'<,'>!nixpkgs-fmt<cr>", { buffer = true, noremap = true })
