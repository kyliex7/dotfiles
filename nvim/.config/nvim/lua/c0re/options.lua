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
vim.o.cursorline = true
vim.o.confirm = false
vim.opt.fillchars = { eob = " " }
vim.o.showmode = false
vim.opt.termguicolors = true
