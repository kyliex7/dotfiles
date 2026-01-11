return {
	{
		"sainnhe/gruvbox-material",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_italic = false
			vim.o.background = "dark"
			vim.g.gruvbox_material_background = "hard"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"oskarnurm/koda.nvim",
		enabled = true,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("koda").setup({
				transparent = false,

				-- Style to be applied to different syntax groups.
				-- Common use case would be to set either `italic = true` or `bold = true` for a desired group.
				-- See `:help nvim_set_hl` for more valid values.
				styles = {
					functions = { bold = false },
					keywords = {},
					comments = {},
					strings = {},
					constants = {}, -- includes numbers, booleans
				},
				colors = {
					highlight = "#268bd2",
				},
			})
			vim.cmd("colorscheme koda")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
			})
			vim.cmd("colorscheme tokyonight")
		end,
	},
}
