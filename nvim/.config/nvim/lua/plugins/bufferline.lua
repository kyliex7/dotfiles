return {
	enabled = false,
	"akinsho/bufferline.nvim",
	event = "ColorScheme",
	config = function()
		require("bufferline").setup()
	end,
}
