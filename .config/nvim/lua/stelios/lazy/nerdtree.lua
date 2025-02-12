return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                natural_order = true,
            },
            keymaps = {
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-t>"] = false,
            },
        })
    end
}

