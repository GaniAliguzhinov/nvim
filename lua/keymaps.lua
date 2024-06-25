-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

-- Plugins
--  NVIM-TREE
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<cr>", opts)

vim.api.nvim_set_keymap("n", "[t", ":tabprevious<cr>", opts)
vim.api.nvim_set_keymap("n", "]t", ":tabNext<cr>", opts)

vim.api.nvim_set_keymap("n", "[b", ":bprevious<cr>", opts)
vim.api.nvim_set_keymap("n", "]b", ":bnext<cr>", opts)

-- LSP
