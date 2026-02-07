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
		enabled = false,
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
					bold = false,
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
	{
		"navarasu/onedark.nvim",
		enabled = true,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				style = "darker", -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				transparent = true, -- Show/hide background
				term_colors = true, -- Change terminal color as per the selected theme style
				cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

				code_style = {
					comments = "none",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},

				-- Custom Highlights --
				colors = {}, -- Override default colors
				highlights = {}, -- Override highlight groups

				-- Plugins Config --
				diagnostics = {
					darker = true, -- darker colors for diagnostic
					undercurl = true, -- use undercurl instead of underline for diagnostics
					background = true, -- use background color for virtual text
				},
			})
			require("onedark").load()
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		enabled = false,
		priority = 1000,
		config = function()
			require("onedarkpro").setup({
				colors = {}, -- Override default colors or create your own
				highlights = {}, -- Override default highlight groups or create your own
				styles = { -- For example, to apply bold and italic, use "bold,italic"
					types = "NONE", -- Style that is applied to types
					methods = "NONE", -- Style that is applied to methods
					numbers = "NONE", -- Style that is applied to numbers
					strings = "NONE", -- Style that is applied to strings
					comments = "NONE", -- Style that is applied to comments
					keywords = "NONE", -- Style that is applied to keywords
					constants = "NONE", -- Style that is applied to constants
					functions = "NONE", -- Style that is applied to functions
					operators = "NONE", -- Style that is applied to operators
					variables = "NONE", -- Style that is applied to variables
					parameters = "NONE", -- Style that is applied to parameters
					conditionals = "NONE", -- Style that is applied to conditionals
					virtual_text = "NONE", -- Style that is applied to virtual text
				},
				options = {
					cursorline = true, -- Use cursorline highlighting?
					transparency = true, -- Use a transparent background?
					highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
				},
			})
			vim.cmd("colorscheme onedark")
		end,
	},
}
