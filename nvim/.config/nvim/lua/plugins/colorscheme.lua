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
		enabled = false,
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
	{
		"rose-pine/neovim",
		enabled = true,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = true,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},

				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",
				},

				palette = {
					-- Override the builtin palette per variant
					-- moon = {
					--     base = '#18191a',
					--     overlay = '#363738',
					-- },
				},

				-- NOTE: Highlight groups are extended (merged) by default. Disable this
				-- per group via `inherit = false`
				highlight_groups = {
					-- Comment = { fg = "foam" },
					-- StatusLine = { fg = "love", bg = "love", blend = 15 },
					-- VertSplit = { fg = "muted", bg = "muted" },
					-- Visual = { fg = "base", bg = "text", inherit = false },
				},

				before_highlight = function(group, highlight, palette)
					-- Disable all undercurls
					-- if highlight.undercurl then
					--     highlight.undercurl = false
					-- end
					--
					-- Change palette colour
					-- if highlight.fg == palette.pine then
					--     highlight.fg = palette.foam
					-- end
				end,
			})

			vim.cmd("colorscheme rose-pine-main")
		end,
	},
}
