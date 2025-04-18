return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
                vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set('i', '<C-s>', function() vim.lsp.buf.signature_help() end, opts)
            end,
        })
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "bashls",   -- bash-language-server
                "gopls",    -- Go
                "jsonls",   -- json-lsp
                "lua_ls",   -- lua-language-server
                "marksman", -- Markdown LSP
                "pyright",  -- Python
                "ts_ls",    -- typescript-language-server
                "html",     -- html-language-server
            },
            automatic_installation = true,
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        capabilities = lsp_capabilities,
                        settings = {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT'
                                },
                                diagnostics = {
                                    globals = { 'vim' },
                                },
                                workspace = {
                                    library = {
                                        vim.env.VIMRUNTIME,
                                    }
                                }
                            }
                        }
                    })
                end,
                jsonls = function()
                    require('lspconfig').jsonls.setup({
                        capabilities = lsp_capabilities,
                        settings = {
                            json = {
                                maxItemsComputed = 1000000, -- Set your desired value here
                            },
                        },
                    })
                end,
            }
        })

        local cmp = require('cmp')
        local luasnip = require("luasnip") -- Added for snippet filetype extension
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        -- Extend HTML snippets to JSX/TSX and docs
        luasnip.filetype_extend("javascriptreact", { "html", "css" })
        luasnip.filetype_extend("typescriptreact", { "html", "css" })
        luasnip.filetype_extend("typescript", { "tsdoc" })
        luasnip.filetype_extend("javascript", { "jsdoc" })
        luasnip.filetype_extend("lua", { "luadoc" })
        luasnip.filetype_extend("python", { "pydoc" })
        luasnip.filetype_extend("rust", { "rustdoc" })
        luasnip.filetype_extend("cs", { "csharpdoc" })
        luasnip.filetype_extend("java", { "javadoc" })
        luasnip.filetype_extend("c", { "cdoc" })
        luasnip.filetype_extend("cpp", { "cppdoc" })
        luasnip.filetype_extend("php", { "phpdoc" })
        luasnip.filetype_extend("kotlin", { "kdoc" })
        luasnip.filetype_extend("ruby", { "rdoc" })
        luasnip.filetype_extend("sh", { "shelldoc" })

        -- this is the function that loads the extra snippets to luasnip
        -- from rafamadriz/friendly-snippets
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
        })
    end
}
