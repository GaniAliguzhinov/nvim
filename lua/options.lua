-- Basic
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a"

-- Tab
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

local function setTabToTwoSpace()
	vim.opt.tabstop = 2
	vim.opt.softtabstop = 2
	vim.opt.shiftwidth = 2
end

-- Run on entering a new buffer or a window:
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.nix", "*.lua", "*.vim", "*.cpp", "*.hpp", "*.h", "*.c" },
	callback = setTabToTwoSpace,
})

-- UI
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.smartindent = true

-- Split behaviour
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.colorcolumn = "100"
