-- Generated from https://www.patorjk.com/software/taag/#p=display&v=0&f=ANSI%20Shadow&t=AVII
local boxfont = require("plugins.my-dashboard.boxfont")
local clock = require("plugins.my-dashboard.clock")
local art = require("plugins.my-dashboard.art")

Customdb = {}
Customdb.MyDashboardConfig = function(db)
	clock.makeClock()

	local time = os.date("*t")
	local timeStr = string.upper(("%02d:%02d:%02d"):format(time.hour, time.min, time.sec))
	local quit = function()
		vim.api.nvim_input("<cmd>qa<cr>")
	end

	db.setup({
		theme = "doom",
		hide = {
			-- this is taken care of by lualine
			-- enabling this messes up the actual laststatus setting after loading a file
			statusline = true,
		},
		config = {
			header = vim.split("\n\n" .. art["Rocket"] .. "\n", "\n"),
			-- icons: https://fontawesome.com/search?q=tree&o=r&m=free, modify with
			-- utf symbol for making them bigger
			center = {
				{ action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
				{ action = "Telescope oldfiles", desc = " Recent Files", icon = " ", key = "r" },
				{ action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
				{ action = "vim.cmd.PackerSync()", desc = " Packer Sync", icon = " ", key = "p" },
				-- { action = "vim.cmd.TSUpdateSync()", desc = " TS UpdateSync", icon = " ", key = "t" },
				-- { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
				{ action = quit, desc = " Quit", icon = " ", key = "q" },
			},
			footer = vim.split("\n" .. boxfont.toBoxFont(timeStr), "\n"),
		},
	})
end
return Customdb
