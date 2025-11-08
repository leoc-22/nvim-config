return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add to harpoon' })
    vim.keymap.set('n', '<C-h>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-N>', function()
      harpoon:list():next()
    end)
  end,
}
