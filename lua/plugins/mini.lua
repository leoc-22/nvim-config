return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
      require('mini.pairs').setup()

      require('mini.files').setup {
        windows = {
          preview = true,
          max_number = 3,
          width_focus = 25,
          width_preview = 50,
        },
      }

      vim.keymap.set('n', '<C-e>', require('mini.files').open, { desc = 'Open file explorer (mini.files)' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
