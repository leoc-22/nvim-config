return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,

  config = function()
    require('catppuccin').setup({
      flavour = 'mocha',
      background = {
        light = 'latte',
        dark = 'mocha',
      },
      integrations = {
        blink_cmp = {
          style = 'bordered',
        },
        gitsigns = true,
        treesitter = true,
        dropbar = {
          enabled = true,
          color_mode = true,
        },
      },
      highlight_overrides = {
        mocha = function()
          return {
            LineNr = { fg = 'gray' },
            CursorLineNr = { fg = 'white' },
            CursorLine = { bg = '#45475a' },
            -- fff preview + grep matches use IncSearch; mantle fg reads as black
            IncSearch = { bg = '#89dceb', fg = '#11111b' },
            Search = { bg = '#89b4fa', fg = '#11111b' },
          }
        end,
      },
    })

    vim.cmd.colorscheme 'catppuccin-nvim'
  end,
}

-- vim: ts=2 sts=2 sw=2 et
