return {
  'rebelot/kanagawa.nvim',
  priority = 1000,

  config = function()
    local highlight_bg = '#dcd7ba'
    local highlight_fg = '#1f1f28'

    require('kanagawa').setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {
          fujiGray = '#c8c093',
        },
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function()
        return {
          Visual = { bg = highlight_bg, fg = highlight_fg },
          VisualNOS = { bg = highlight_bg, fg = highlight_fg },
          Search = { bg = highlight_bg, fg = highlight_fg },
          CurSearch = { bg = highlight_bg, fg = highlight_fg },
          IncSearch = { bg = highlight_bg, fg = highlight_fg },
        }
      end,
      theme = 'wave',
      background = {
        dark = 'wave',
        light = 'lotus',
      },
    })

    vim.cmd.colorscheme 'kanagawa'
  end,
}
