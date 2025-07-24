return {
    'numToStr/Comment.nvim',
    event = { "BufReadPost", "BufNewFile" }, -- Lazy load on file open
    config = function()
        require('Comment').setup()

        -- Optional: Map <C-/> to toggle comment
        vim.keymap.set('n', '<C-_>', 'gcc', { noremap = false, desc = 'Toggle comment line' })
        vim.keymap.set('v', '<C-_>', 'gc', { noremap = false, desc = 'Toggle comment block' })
    end
}
