local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = '',
        -- section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { { 'mode', right_padding = 2 } },
        lualine_b = {
          {
            'filename',
            file_status = true,
            newfile_status = true,
            path = 0,
          },
          {
            'branch',
            fmt = function(str)
              local max = 20 -- <<< set your limit here
              if not str or str == '' then return '' end
              if vim.fn.strdisplaywidth(str) <= max then return str end
              return vim.fn.strcharpart(str, 0, max) .. '…'
            end,
          }
        },
        lualine_c = {
          '%=',
          function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
          end,
        },
        lualine_x = { 'lsp_status' },
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end
}

-- vim: ts=2 sts=2 sw=2 et
