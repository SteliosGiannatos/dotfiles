return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- fix: telescope picker for harpoon list
        local function toggleTelescopeHarpoon(harpoonFiles)
            local conf = require("telescope.config").values
            local filePaths = {}
            for _, item in ipairs(harpoonFiles.items) do
                table.insert(filePaths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = filePaths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        -- fix: open telescope picker instead of default quick menu
        vim.keymap.set("n", "<leader>e", function() toggleTelescopeHarpoon(harpoon:list()) end)

        vim.keymap.set("n", "<C-h>", function()
            harpoon:list():select(1)
            vim.cmd("normal! zz")
        end)
        vim.keymap.set("n", "<C-j>", function()
            harpoon:list():select(2)
            vim.cmd("normal! zz")
        end)
        vim.keymap.set("n", "<C-k>", function()
            harpoon:list():select(3)
            vim.cmd("normal! zz")
        end)
        vim.keymap.set("n", "<C-l>", function()
            harpoon:list():select(4)
            vim.cmd("normal! zz")
        end)
    end,
}
