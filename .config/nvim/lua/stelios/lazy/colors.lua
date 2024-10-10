function ColorMyPencils(color)
    color = color or "catppuccin-mocha"
    vim.cmd.colorscheme(color)
end
return {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
        vim.cmd('colorscheme catppuccin')

        ColorMyPencils()
    end
}
