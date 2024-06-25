local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd" } },
		nix = { "alejandra" },
		bash = { "beautysh" },
		c = { "clang-format" },
		h = { "clang-format" },
		cpp = { "clang-format" },
		hpp = { "clang-format" },
		json = { "fixjson" },
		markdown = { "mdformat" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "CMakeLists.txt",
	callback = function(args)
		conform.format({
			bufnr = args.buf,
			formatters = { "cmake_format" },
		})
	end,
})
