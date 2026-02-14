local map = vim.keymap.set
map("i", "jk", "<ESC>")
map("i", "<M-h>", "<left>", { noremap = true })
map("i", "<M-l>", "<right>", { noremap = true })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("v", "<leader>j", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<leader>k", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
map({ "n", "v" }, "<leader>Y", '"+Y', { desc = "[Y]ank line to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })
map({ "n", "v" }, "<leader>P", '"+P', { desc = "[P]aste before from system clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "[D]elete without yanking" })
map("n", "<leader>e", function()
	vim.cmd("Ex")
end, { desc = "NetRW" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
-- autosession (disabled temporarily)
-- map("n", "<leader>Ss", function()
-- 	vim.cmd("AutoSession search")
-- end, { desc = "[S]earch [s]aved sessions" })
-- map("n", "<leader>Sd", function()
-- 	vim.cmd("AutoSession deletePicker")
-- end, { desc = "[S]earch [d]eletepicker" })
-- map("n", "<leader>SS", function()
-- 	vim.cmd("AutoSession save")
-- end, { desc = "[S]ave [S]ession" })
--
local function insert_comment(direction)
  local cs = vim.bo.commentstring
  if cs == "" or cs == nil then
    print("No commentstring set for this filetype")
    return
  end
  
  -- Extract the prefix (part before %s) and clean up whitespace
  local comment_prefix = cs:gsub("%%s.*", ""):gsub("%s+$", "") .. " "
  
  -- Execute the 'o' or 'O' command to create a new line
  vim.cmd("normal! " .. direction)
  
  -- Insert the comment character
  vim.api.nvim_put({comment_prefix}, "c", true, true)
  
  -- Enter insert mode at the end of the line
  vim.cmd("startinsert!")
end

vim.keymap.set("n", "gco", function() insert_comment("o") end, { desc = "Insert comment below" })
vim.keymap.set("n", "gcO", function() insert_comment("O") end, { desc = "Insert comment above" })


-- vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
-- vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
-- vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
-- vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
-- vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
-- vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
-- vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
-- vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')
