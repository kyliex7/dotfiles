return {
	"echasnovski/mini.nvim",
	enabled = true,
	config = function()
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.tabline").setup({
			show_icons = false,
			format = function(buf_id, label)
				return "  " .. label .. " " .. "│"
			end,
		})

		require("mini.indentscope").setup({
			draw = {
				delay = 100,
				priority = 2,
			},
			options = {
				border = "top",
			},
			symbol = "▎",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "alpha", "dashboard", "fzf", "help", "lazy", "mason" },
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
		local od_white = "#abb2bf"
		local od_grey = "#5c6370"
		local od_dark = "NONE"

		vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = od_white, bg = od_dark, bold = true })
		vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = od_grey, bg = od_dark })
		vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = od_grey, bg = od_dark })
		vim.api.nvim_set_hl(0, "MiniTablineFill", { bg = od_dark })

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
