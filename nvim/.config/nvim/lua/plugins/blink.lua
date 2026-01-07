return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
		completion = {
        menu = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
        documentation = {
          window = {
            border = "rounded",
          },
        },
			},
		signature = {
			enabled = true,
			window = {
				border = 'rounded' 
			}
		},
    keymap = { 
			['<C-u>'] = { 'scroll_signature_up', 'fallback' },
			['<C-d>'] = { 'scroll_signature_down', 'fallback' },
  		preset = 'default' 
		},
    appearance = {
      nerd_font_variant = 'normal'
    },

    completion = { documentation = { auto_show = true } },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
