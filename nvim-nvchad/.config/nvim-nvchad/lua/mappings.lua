require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map('i', '<M-p>', '<left>', { noremap = true })
map('i', '<M-n>', '<right>', { noremap = true })
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map("v", "<leader>j", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<leader>k", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = '[Y]ank to system clipboard' })
map({ 'n', 'v' }, '<leader>Y', '"+Y', { desc = '[Y]ank line to system clipboard' })
map({ 'n', 'v' }, '<leader>p', '"+p', { desc = '[P]aste from system clipboard' })
map({ 'n', 'v' }, '<leader>P', '"+P', { desc = '[P]aste before from system clipboard' })
map({ 'n', 'v' }, '<leader>d', '"_d', { desc = '[D]elete without yanking' })
map('n', '<leader>a', ':Nvdash<CR>', { desc = 'Open d[a]shboard' })
map('n', '<leader>tt', require('base46').toggle_transparency, { desc = 'Toggle transparency' })
