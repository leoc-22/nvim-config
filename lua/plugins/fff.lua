return {
  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      require('fff.download').download_or_build_binary()
    end,
    lazy = false,
    opts = {
      lazy_sync = true,
      prompt_vim_mode = true,
      layout = {
        height = 0.85,
        width = 0.85,
        preview_position = 'right',
        preview_size = 0.5,
      },
      preview = {
        line_numbers = true,
        wrap_lines = false,
        filetypes = {
          markdown = { wrap_lines = true },
          text = { wrap_lines = true },
        },
      },
      git = {
        status_text_color = true,
      },
    },
    keys = {
      {
        '<leader>ff',
        function()
          require('fff').find_files()
        end,
        desc = '[F]FF [F]iles',
      },
      {
        '<leader>fg',
        function()
          require('fff').live_grep()
        end,
        desc = '[F]FF [G]rep',
      },
      {
        '<leader>fc',
        function()
          require('fff').live_grep { query = vim.fn.expand '<cword>' }
        end,
        desc = '[F]FF [C]urrent word',
      },
      {
        '<leader>fz',
        function()
          require('fff').live_grep { grep = { modes = { 'fuzzy', 'plain' } } }
        end,
        desc = '[F]FF fu[Z]zy grep',
      },
      {
        '<leader>fr',
        function()
          require('fff').scan_files()
        end,
        desc = '[F]FF [R]escan files',
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
