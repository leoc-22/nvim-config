vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without yanking replaced text' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = 'Open diagnostic [E]rror float' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')

vim.keymap.set('n', '<C-a>', 'gg<S-v>G', { noremap = true })
vim.keymap.set('v', '<C-a>', '<Nop>', { noremap = true })

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

vim.keymap.set('n', '<space>tt', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 10)
end)

local typos = { 'W', 'Wq', 'WQ', 'Wqa', 'WQa', 'WQA', 'WqA', 'Q', 'Qa', 'QA' }
for _, cmd in ipairs(typos) do
  vim.keymap.set('ca', cmd, cmd:lower())
end

-- vim: ts=2 sts=2 sw=2 et
