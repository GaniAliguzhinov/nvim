-- Load the nvim-tree first to disable netrw at the top
require("plugins.nvim-tree")

vim.g.mapleader = " "

require("options") -- Include ./lua/options.lua with basic vim config
require("keymaps") -- Include ./lua/keymaps.lua

vim.opt.termguicolors = true

require("plugins")
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
-- vim.cmd([[colorscheme tokyonight-moon]])
vim.cmd([[colorscheme catppuccin-frappe]])

vim.cmd.syntax("on")
vim.cmd.syntax("enable")
vim.g.editorconfig = true
