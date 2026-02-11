-- Highlight, edit, and navigate code
return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').setup({
            ensure_installed = {
                'bash',
                'c',
                'c_sharp',
                'cpp',
                'diff',
                'h',
                'html',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'query',
                'razor',
                'vim',
                'vimdoc'
            },
            highlight = {
                enable = true
            }
        })
    end
}
