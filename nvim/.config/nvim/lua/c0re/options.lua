vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.o.inccommand = 'split'
vim.o.cursorline = false
-- vim.opt.guicursor = ""
vim.o.confirm = true
vim.opt.fillchars = { eob = " " }
vim.o.showmode = true
vim.opt.termguicolors = true

if vim.g.neovide then
	vim.g.neovide_opacity = 0.8
	vim.g.neovide_normal_opacity = 0.8
end
