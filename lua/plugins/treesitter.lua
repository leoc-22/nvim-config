return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local parsers = {
        'astro',
        'bash',
        'c',
        'diff',
        'go',
        'html',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
      }

      vim.treesitter.language.add('json', { filetype = 'jsonc' })
      require('nvim-treesitter').install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('custom-treesitter-start', { clear = true }),
        pattern = {
          'astro',
          'bash',
          'c',
          'diff',
          'go',
          'html',
          'javascript',
          'json',
          'jsonc',
          'lua',
          'luadoc',
          'markdown',
          'python',
          'query',
          'typescript',
          'typescriptreact',
          'vim',
          'vimdoc',
        },
        callback = function(event)
          pcall(vim.treesitter.start, event.buf)
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
