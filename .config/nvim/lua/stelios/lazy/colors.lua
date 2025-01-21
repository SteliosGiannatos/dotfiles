function ColorMyPencils(color)
    color = color or "catppuccin-mocha"
    vim.cmd.colorscheme(color)
    vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
    vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")
end

return {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
        vim.cmd('colorscheme catppuccin')

        ColorMyPencils()
    end
}
