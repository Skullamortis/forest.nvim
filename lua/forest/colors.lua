local util = require("forest.util")

local M = {}

---@class Palette
M.default = {
	none = "NONE",
	bg_dark = "#0b0e0e",
	bg = "#0f171b",
	bg_highlight = "#192326",
	terminal_black = "#738c8c",
	fg = "#67e480",
	fg_dark = "#1fad66",
	fg_gutter = "#2b3b34",
	dark3 = "#738c8c",
	comment = "#344040",
	dark5 = "#9dffaf",
	blue0 = "#348b4a",
	blue = "#8bc671",
	cyan = "#a3e8ff",
	blue1 = "#4dff4d",
	blue2 = "#00cc00",
	blue5 = "#a9d369",
	blue6 = "#e6ffe6",
	blue7 = "#348d4a",
	magenta = "#bf8040",
	magenta2 = "#990011",
	purple = "#c47321",
	orange = "#dd501a",
	yellow = "#efff4d",
	green = "#abeb28",
	green1 = "#30905e",
	green2 = "#558000",
	teal = "#208000",
	red = "#ff944d",
	red1 = "#db4b4b",
	git = { change = "#39e600", add = "#99ff33", delete = "#994d00" },
	gitSigns = {
		add = "#86b300",
		change = "#2db300",
		delete = "#e67300",
	},
}

M.night = {
	bg = "#090e10",
	bg_dark = "#040403",
}
M.day = M.night

---@return ColorScheme
function M.setup(opts)
	opts = opts or {}
	local config = require("forest.config")

	local style = config.is_day() and config.options.light_style or config.options.style
	local palette = M[style] or {}
	if type(palette) == "function" then
		palette = palette()
	end

	-- Color Palette
	---@class ColorScheme: Palette
	local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

	util.bg = colors.bg
	util.day_brightness = config.options.day_brightness

	colors.diff = {
		add = util.darken(colors.green2, 0.15),
		delete = util.darken(colors.red1, 0.15),
		change = util.darken(colors.blue7, 0.15),
		text = colors.blue7,
	}

	colors.git.ignore = colors.dark3
	colors.black = util.darken(colors.bg, 0.8, "#000000")
	colors.border_highlight = util.darken(colors.blue1, 0.8)
	colors.border = colors.black

	-- Popups and statusline always get a dark background
	colors.bg_popup = colors.bg_dark
	colors.bg_statusline = colors.bg_dark

	-- Sidebar and Floats are configurable
	colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
		or config.options.styles.sidebars == "dark" and colors.bg_dark
		or colors.bg

	colors.bg_float = config.options.styles.floats == "transparent" and colors.none
		or config.options.styles.floats == "dark" and colors.bg_dark
		or colors.bg

	colors.bg_visual = util.darken(colors.blue0, 0.4)
	colors.bg_search = colors.blue0
	colors.fg_sidebar = colors.fg_dark
	-- colors.fg_float = config.options.styles.floats == "dark" and colors.fg_dark or colors.fg
	colors.fg_float = colors.fg

	colors.error = colors.red1
	colors.warning = colors.yellow
	colors.info = colors.blue2
	colors.hint = colors.teal

	colors.delta = {
		add = util.darken(colors.green2, 0.45),
		delete = util.darken(colors.red1, 0.45),
	}

	config.options.on_colors(colors)
	if opts.transform and config.is_day() then
		util.invert_colors(colors)
	end

	return colors
end

return M
