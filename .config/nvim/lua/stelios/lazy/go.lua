return {
    "crispgm/nvim-go",
    config = function()
        vim.keymap.set('n', '<leader>gtj', ':GoAddTags json<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>gty', ':GoAddTags yaml<CR>', { noremap = true, silent = true })
    end
}
