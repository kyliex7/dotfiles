return {
  "rmagatti/auto-session",
	enabled = false,
  lazy = false,
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  },
	config = function()
		require("auto-session").setup({
			auto_save = false,
		})
	end
}
