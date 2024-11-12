return {
    "crispgm/nvim-go",
    config = function()
        require('go').setup({
            tags_name = 'json',
            tags_options = {}
        })
        vim.keymap.set('n', '<leader>gtj', ':GoAddTags json<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>gty', ':GoAddTags yaml<CR>', { noremap = true, silent = true })
    end
}

