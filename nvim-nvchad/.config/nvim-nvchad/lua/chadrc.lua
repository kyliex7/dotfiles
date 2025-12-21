---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gruvchad",
	hl_override = {
		Comment = { italic = true },
	},
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  statusline = {
    separator_style = "block",
  }
}

return M
