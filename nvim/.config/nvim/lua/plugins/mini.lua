return {
	"echasnovski/mini.nvim",
	enabled = true,
	config = function()
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.tabline").setup({
			show_icons = true,
			format = function(buf_id, label)
				local suffix = vim.bo[buf_id].modified and " ●" or ""
				return MiniTabline.default_format(buf_id, label) .. suffix
			end,
		})
		require("mini.indentscope").setup({
			options = {
				border = "top",
			},
			symbol = "│",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "alpha", "dashboard", "fzf", "help", "lazy", "mason" },
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})

local dark_bg  = "#131318"
local black    = "#181a1f"
local green    = "#98c379"
local grey     = "#5c6370"

vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { fg = green, bg = dark_bg, italic = true })
vim.api.nvim_set_hl(0, 'MiniTablineHidden', { fg = grey, bg = black })
vim.api.nvim_set_hl(0, 'MiniTablineVisible', { fg = grey, bg = black })
vim.api.nvim_set_hl(0, 'MiniTablineFill', { bg = black })

		-- require("mini.pairs").setup()
		-- require('mini.animte').setup()
		-- require("mini.statusline").setup({
		-- 	content = {
		-- 		active = function()
		-- 			-- 1. Filename (Relative path)
		-- 			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
		--
		-- 			-- 2. Location (Line number : Column)
		-- 			local location = MiniStatusline.section_location({ trunc_width = 75 })
		--
		-- 			-- 3. Search Count (Shows 1/5 when searching)
		-- 			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
		--
		-- 			return MiniStatusline.combine_groups({
		-- 				{ hl = "MiniStatuslineFilename", strings = { filename } },
		-- 				"%=", -- Push everything following to the right
		-- 				{ hl = mode_hl, strings = { search, location } },
		-- 			})
		-- 		end,
		-- 	},
		-- 	use_icons = true,
		-- 	set_vim_settings = false,
		-- })

		vim.keymap.set("n", "<leader>x", function()
			local bd = require("mini.bufremove").delete
			if vim.bo.modified then
				local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
				if choice == 1 then -- Yes
					vim.cmd.write()
					bd(0)
				elseif choice == 2 then -- No
					bd(0, true)
				end
			else
				bd(0)
			end
		end, { noremap = true, silent = true, desc = "Delete Buffer" })

		vim.keymap.set("n", "<leader>bd", function()
			require("mini.bufremove").delete(0, true)
		end, { noremap = true, silent = true, desc = "Delete Buffer (Force)" })
	end,
}
