return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
            },
        })

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

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
