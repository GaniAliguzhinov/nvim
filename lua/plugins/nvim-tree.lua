-- disable builtin file explorer netrw
-- means that this module has to be loaded first
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_nvim_tree_on_attach(bufnr)
	local api = require("nvim-tree.api")

	-- :help nvim-tree-mappings-default for the default mappings (when tree is open)
	api.config.mappings.default_on_attach(bufnr)
end

require("nvim-tree").setup({
	on_attach = my_nvim_tree_on_attach,
})
