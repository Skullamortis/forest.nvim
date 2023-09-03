local util = require("forest.util")
local theme = require("forest.theme")
local config = require("forest.config")

local M = {}

function M._load(style)
	if style and not M._style then
		M._style = require("forest.config").options.style
	end
	if not style and M._style then
		require("forest.config").options.style = M._style
		M._style = nil
	end
	M.load({ style = style, use_background = style == nil })
end

---@param opts Config|nil
function M.load(opts)
	if opts then
		require("forest.config").extend(opts)
	end
	util.load(theme.setup())
end

M.setup = config.setup

-- keep for backward compatibility
M.colorscheme = M.load

return M
