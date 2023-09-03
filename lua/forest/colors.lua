local util = require("forest.util")

local M = {}

---@class Palette
M.default = {
	none = "NONE",
	bg_dark = "#222a2a",
	bg = "#384545",
	bg_highlight = "#5c7070",
	terminal_black = "#738c8c",
	fg = "#c4ffcc",
	fg_dark = "#a0eeb0",
	fg_gutter = "#678e7e",
	dark3 = "#738c8c",
	comment = "#364b43",
	dark5 = "#9dffaf",
	blue0 = "#348b4a",
	blue = "#45ba62",
	cyan = "#a2ffd1",
	blue1 = "#4dff4d",
	blue2 = "#00cc00",
	blue5 = "#80ff80",
	blue6 = "#e6ffe6",
	blue7 = "#348d4a",
	magenta = "#bfff80",
	magenta2 = "#ff007c",
	purple = "#4ce600",
	orange = "#ff7e33",
	yellow = "#d2ff4d",
	green = "#aaff00",
	green1 = "#8ae600",
	green2 = "#6be600",
	teal = "#7aff33",
	red = "#f7768e",
	red1 = "#db4b4b",
	git = { change = "#39e600", add = "#99ff33", delete = "#994d00" },
	gitSigns = {
		add = "#86b300",
		change = "#2db300",
		delete = "#e67300",
	},
}

M.night = {
	bg = "#17181c",
	bg_dark = "#0b0e0e",
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
