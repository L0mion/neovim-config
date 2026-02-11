return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                registries = {
                    'github:mason-org/mason-registry',
                    'github:Crashdummyy/mason-registry',
                }
            })
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'clangd',
                    'ts_ls',
                    'cssls',
                    'html',
                    'powershell_es'
                }
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('clangd')
            vim.lsp.enable('ts_ls')
            vim.lsp.enable('cssls')
            vim.lsp.enable('html')
            vim.lsp.config('powershell_es', {
                bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/"
            })
        end
    },
    {
        'seblyng/roslyn.nvim',
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        ft = { 'cs', 'razor' },
        opts = {}
    }
}
