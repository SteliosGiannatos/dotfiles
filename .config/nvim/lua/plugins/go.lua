return {
    "crispgm/nvim-go",
    config = function()
        require('go').setup({
            tags_name = 'json',
            tags_options = {}
        })

        -- Add tags in both normal and visual mode
        vim.keymap.set({ 'n', 'v' }, '<leader>gtt', function()
            if vim.fn.mode() == 'v' then
                -- For visual mode, apply the command to the selected range
                vim.cmd("'<,'>GoAddTags json,xml,yaml,csv")
            else
                -- For normal mode, apply to the current line or file
                vim.cmd("GoAddTags json,xml,yaml,csv")
            end
        end, { noremap = true, silent = true })

        -- Clear tags in both normal and visual mode
        vim.keymap.set({ 'n', 'v' }, '<leader>gtc', function()
            if vim.fn.mode() == 'v' then
                -- For visual mode, apply the command to the selected range
                vim.cmd("'<,'>GoClearTags")
            else
                -- For normal mode, apply to the current line or file
                vim.cmd("GoClearTags")
            end
        end, { noremap = true, silent = true })
    end
}

