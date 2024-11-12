return {
    'preservim/nerdtree',
    config = function()
        vim.keymap.set("n", "<leader>pv", ":NERDTreeExplore<CR>")
    end
}
