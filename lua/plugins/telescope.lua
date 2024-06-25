local telescope = require("telescope")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ft", builtin.treesitter, {})

local wk = require("which-key")

wk.register({
	["<leader>f"] = { name = "+file" },
	["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "[F]ind" },
	["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Live [G]rep" },
	["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "[B]uffers" },
	["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "[H]elp Tags" },
	["<leader>ft"] = { "<cmd>Telescope treesitter<cr>", "[T]reesitter" },
	["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "[R]ecent" },
	["<leader>fn"] = { "<cmd>enew<cr>", "[N]ew" },
})
