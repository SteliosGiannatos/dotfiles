return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup()

        -- install parsers
        require("nvim-treesitter").install {
            "vimdoc", "javascript", "typescript", "c", "lua", "rust",
            "jsdoc", "bash", "go", "gomod", "gosum",
        }

        -- enable highlighting for all filetypes with a parser
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
