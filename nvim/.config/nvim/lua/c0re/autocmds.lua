vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local asm_group = vim.api.nvim_create_augroup("asm_file_settings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "asm", "gas" },
  group = asm_group,
  desc = "Set GAS assembly comment character to #",
  callback = function()
    vim.opt_local.commentstring = "# %s"
  end,
})
