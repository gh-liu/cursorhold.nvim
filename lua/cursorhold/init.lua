--- Implementation inspired from https://github.com/antoinemadec/FixCursorHold.nvim/blob/master/plugin/fix_cursorhold_nvim.vim
local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

local cursorhold_updatetime = vim.g.cursorhold_updatetime or vim.o.updatetime

-- disable this when updatetime < cursorhold_updatetime
if vim.o.updatetime < cursorhold_updatetime then
	return
end

vim.cmd([[set eventignore+=CursorHold,CursorHoldI]])

---@param ms integer
---@param fn function
local debounce = function(ms, fn)
	---@diagnostic disable-next-line: undefined-field
	local timer = vim.uv.new_timer()
	return function(...)
		local argv = { ... }
		timer:start(ms, 0, function()
			timer:stop()
			vim.schedule_wrap(fn)(unpack(argv))
		end)
	end
end

---@param ev string
local function trigger_event(ev)
	vim.cmd(string.format([[ set eventignore-=%s | doautocmd <nomodeline> %s | set eventignore+=%s ]], ev, ev, ev))
end

local CursorMoved = debounce(cursorhold_updatetime, function()
	trigger_event("CursorHold")
end)
local CursorMovedI = debounce(cursorhold_updatetime, function()
	trigger_event("CursorHoldI")
end)

local g = augroup("cursorhold/updatetime", { clear = true })
autocmd({ "CursorMoved" }, { group = g, callback = CursorMoved })
autocmd({ "CursorMovedI" }, { group = g, callback = CursorMovedI })
