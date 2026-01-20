return {
	"saghen/blink.cmp",
	enabled = false,
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				-- uncommend these to enable rounded corners on bilnk.cmp completions
				-- window = {
				-- 	border = "rounded",
				-- 	winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				-- },
			},
			menu = {
				-- border = "rounded",
				-- draw = { gap = 2 },
				-- winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
			},
		},

		signature = {
			enabled = true,
			-- window = {
			-- 	border = "rounded",
			-- },
		},

		keymap = {
			preset = "default",
			["<C-u>"] = { "scroll_signature_up", "fallback" },
			["<C-d>"] = { "scroll_signature_down", "fallback" },
			["<C-e>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = {
			nerd_font_variant = "normal",
		},
	},
}
