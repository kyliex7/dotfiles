-- return {}
return {
	"catgoose/nvim-colorizer.lua",
	enabled = false,
	event = "BufReadPre",
	config = function ()
	require("colorizer").setup()
	end
}

