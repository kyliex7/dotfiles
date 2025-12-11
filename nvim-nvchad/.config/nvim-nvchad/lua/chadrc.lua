---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

M.nvdash = { load_on_startup = true }
M.ui = {
  statusline = {
    separator_style = "block",
  }
}

return M
