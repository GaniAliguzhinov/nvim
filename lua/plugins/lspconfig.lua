local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
	capabilities = lsp_capabilities,
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					"/run/current-system/sw/share/nvim/runtime",
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true),
			},
		})
	end,
	settings = {
		Lua = {},
	},
})
lspconfig.nixd.setup({
	capabilities = lsp_capabilities,
})

lspconfig.clangd.setup({
	capabilities = lsp_capabilities,
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	single_file_support = true,
})
lspconfig.cmake.setup({})

local wk = require("which-key")

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function()
		wk.register({
			["<leader>l"] = { name = "+lsp" },
			["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[R]ename Symbol" },
			["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code [A]ction" },
			["<leader>lh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "[H]over" },
			["<leader>ld"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "[D]iagnostics" },
			["<leader>ls"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[S]ignature" },
			["<leader>g"] = { name = "+goto(lsp)" },
			["<leader>gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto [D]efinition" },
			["<leader>gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto [D]eclaration" },
			["<leader>gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto [I]mplementation" },
			["<leader>gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto [R]eferences" },
			["["] = { name = "+prev" },
			["]"] = { name = "+next" },
			["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev [D]iagnostic" },
			["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next [D]iagnostic" },
		})
	end,
})
