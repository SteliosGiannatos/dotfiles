return {
    "crispgm/nvim-go",
    config = function()
        require('go').setup({
            tags_name = 'json',
            tags_options = {}
        })
        vim.keymap.set('n', '<leader>gtt', ':GoAddTags json,xml,yaml,csv<CR>', { noremap = true, silent = true })
        vim.keymap.set('v', '<leader>gtc', ":'<,'>GoClearTags<CR>", { noremap = true, silent = true })
    end
}
