BOXFONT = require("plugins.my-dashboard.boxfont")

local clock = {}

local dbBufferNumber = -1
local function getDbBufferNumber()
	if dbBufferNumber == -1 then
		dbBufferNumber = vim.api.nvim_get_current_buf()
		return dbBufferNumber
	end
	if vim.api.nvim_get_current_buf() == dbBufferNumber then
		return dbBufferNumber
	else
		return -1
	end
end

local function highlightFooter(buf, footerStr)
	local _, footerLineCount = footerStr:gsub("\n", "\n")
	local bufLineCount = vim.api.nvim_buf_line_count(buf)
	for i = 1, footerLineCount do
		vim.api.nvim_buf_add_highlight(buf, 0, "DashboardFooter", bufLineCount - i, 0, -1)
	end
end

local function getCurrentTimeString()
	local curTime = os.date("*t")
	return ("%02d:%02d:%02d"):format(curTime.hour, curTime.min, curTime.sec)
end

local function getFooterStr()
	local invisibleChar = " "
	local footerStart = invisibleChar .. "\n"
	return footerStart .. BOXFONT.toBoxFont(string.upper(getCurrentTimeString()))
end

-- make sure to not execute anything if in the process
-- of stopping the timer
local doRun = true
clock.makeClock = function()
	local timer = vim.uv.new_timer()
	timer:start(
		10, -- wait before first call
		150, -- wait between calls
		vim.schedule_wrap(function()
			if not doRun then
				return
			end
			if vim.fn.exists(":DashboardUpdateFooter") == 0 then
				timer:close()
				doRun = false -- don't close twice
				return
			end
			local bufferNumber = getDbBufferNumber()
			if bufferNumber == -1 then
				timer:close()
				doRun = false
			else
				local footerStr = getFooterStr()
				vim.cmd.DashboardUpdateFooter(vim.split(footerStr, "\n"))
				highlightFooter(bufferNumber, footerStr)
			end
		end)
	)
end

return clock
