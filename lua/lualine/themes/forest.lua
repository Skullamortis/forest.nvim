local colors = require("forest.colors").setup({ transform = true })
local config = require("forest.config").options

local forest = {}

forest.normal = {
	a = { bg = colors.blue, fg = colors.black },
	b = { bg = colors.fg_gutter, fg = colors.blue },
	c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
}

forest.insert = {
	a = { bg = colors.green, fg = colors.black },
	b = { bg = colors.fg_gutter, fg = colors.green },
}

forest.command = {
	a = { bg = colors.yellow, fg = colors.black },
	b = { bg = colors.fg_gutter, fg = colors.yellow },
}

forest.visual = {
	a = { bg = colors.magenta, fg = colors.black },
	b = { bg = colors.fg_gutter, fg = colors.magenta },
}

forest.replace = {
	a = { bg = colors.red, fg = colors.black },
	b = { bg = colors.fg_gutter, fg = colors.red },
}

forest.terminal = {
	a = { bg = colors.green1, fg = colors.black },
	b = { bg = colors.fg_gutter, fg = colors.green1 },
}

forest.inactive = {
	a = { bg = colors.bg_statusline, fg = colors.blue },
	b = { bg = colors.bg_statusline, fg = colors.fg_gutter, gui = "bold" },
	c = { bg = colors.bg_statusline, fg = colors.fg_gutter },
}

if config.lualine_bold then
	for _, mode in pairs(forest) do
		mode.a.gui = "bold"
	end
end

return forest
