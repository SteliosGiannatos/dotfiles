return {
    'nvim-telescope/telescope.nvim',
    version = '0.1.6',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<c-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        local telescope = require("telescope")
        local telescopeConfig = require("telescope.config")


        local vimgrepArguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
        table.insert(vimgrepArguments, "--hidden")
        table.insert(vimgrepArguments, "--glob")
        table.insert(vimgrepArguments, "!**/.git/*")

        telescope.setup({
            defaults = {
                vimgrep_arguments = vimgrepArguments,
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
        })
    end
}
