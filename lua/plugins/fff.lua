return {
  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      require('fff.download').download_or_build_binary()
    end,
    lazy = false,
    config = function(_, opts)
      require('fff').setup(opts)
      require('util.fff_preview_hl').setup()
    end,
    opts = {
      prompt_vim_mode = false,
      layout = {
        height = 0.9,
        width = 0.7,
        -- prompt_position = 'top', -- or 'top'
        -- preview_position = 'bottom',
        preview_size = 0.6,
      },
      preview = {
        line_numbers = true,
        wrap_lines = true,
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
