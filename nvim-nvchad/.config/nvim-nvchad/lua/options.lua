require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorline = true
o.shiftwidth = 2
o.tabstop = 2
o.number = true
o.relativenumber = true
o.confirm = true
vim.api.nvim_set_hl(0, "MyBorderColor", { fg = "#928374" })
