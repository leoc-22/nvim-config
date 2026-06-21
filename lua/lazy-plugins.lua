-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'NMAC427/guess-indent.nvim',

  --   require 'plugins/cmp'
  require 'plugins.gitsigns',
  require 'plugins.which-key',
  require 'plugins.fff',
  require 'plugins.glance',
  require 'plugins.telescope',
  require 'plugins.lspconfig',
  require 'plugins.conform',
  require 'plugins.catppuccin',
  -- require 'plugins.kanagawa',
  require 'plugins.todo-comments',
  require 'plugins.mini',
  require 'plugins.treesitter',
  require 'plugins.blink',
  require 'plugins.oil',
  require 'plugins.markview',
  require 'plugins.dropbar',
  require 'plugins.lualine',
  require 'plugins.fugitive',
  require 'plugins.lsp-lines',
  require 'plugins.trouble',
  require 'plugins.indent-blankline',
  require 'plugins.context',
  require 'plugins.undotree',
  require 'plugins.harpoon',
  require 'plugins.harpoon-files',
  require 'plugins.no-neck-pain',
  require 'plugins.colorful-winsep'
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
