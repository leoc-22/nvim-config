-- default to open netrw
vim.keymap.set('n', '<C-e>', ':Explore<CR>')

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')

vim.keymap.set('n', '<C-a>', 'gg<S-v>G', { noremap = true })
vim.keymap.set('v', '<C-a>', '<Nop>', { noremap = true })

-- Disable the default LSP key mappings introduced in Neovim 0.11.0
vim.keymap.del('n', 'grn') -- Disable rename mapping
vim.keymap.del('n', 'grr') -- Disable references mapping
vim.keymap.del('n', 'gri') -- Disable implementation mapping
vim.keymap.del('n', 'gra') -- Disable code action mapping

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Open a new terminal emulator inside Neovim',
  group = vim.api.nvim_create_augroup('custom-term-ope', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- keymap for doing the above
local job_id = 0
vim.keymap.set('n', "<space>tt", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)

  job_id = vim.bo.channel
end)

-- use this after you have brought out the terminal using the above keymap
vim.keymap.set('n', '<space>example', function()
  vim.fn.chansend(job_id, { "echo 'hi'\r\n" })
end)

-- vim: ts=2 sts=2 sw=2 et
