-- Treesitter folding
-- Set level to 1 to fold children
-- Keymaps:
-- :help fold-commands:
-- zo -> open current fold | zO -> open current fold recursively
-- zc -> close current fold
-- zx -> undo manually changed folds and reapply foldlevel | zx -> reset folds
-- zm -> fold more == reduce foldlevel
-- zr -> fold less == increment foldlevel
-- zR -> open all folds
vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
})

vim.opt.foldlevel = 3
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"c",
		"lua",
		"luap",
		"luadoc",
		"vim",
		"vimdoc",
		"query",
		"bash",
		"awk",
		"cmake",
		"cpp",
		"css",
		"dockerfile",
		"gitignore",
		"gitcommit",
		"git_rebase",
		"git_config",
		"gitattributes",
		"html",
		"json5",
		"make",
		"markdown",
		"markdown_inline",
		"nix",
		"python",
		"sql",
		"yaml",
		"diff",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	-- ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		-- additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },

	-- Use init_selection to select first meaningful node, then node_incremental to select more
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>", -- Press this to start selection from the first meaningful node
			scope_incremental = "<CR>", -- Select Tree parent
			node_incremental = "<TAB>", -- Select all current depth leaves -> parent node
			node_decremental = "<S-TAB>", -- Select less
		},
	},
})
