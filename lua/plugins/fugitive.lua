return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G', 'Gdiffsplit', 'Gvdiffsplit', 'Gedit', 'Gread', 'Gwrite', 'Ggrep', 'GMove', 'GRename', 'GDelete' },
  keys = {
    { '<leader>hc', '<cmd>Gvdiffsplit!<CR>', desc = 'git [c]onflict vertical 3-way diff' },
    { '<leader>ho', '<cmd>diffget //2<CR>', desc = 'git conflict take [o]urs' },
    { '<leader>ht', '<cmd>diffget //3<CR>', desc = 'git conflict take [t]heirs' },
  },
  config = function()
    local function resize_fugitive_windows()
      local height = math.max(8, math.floor(vim.o.lines * 0.25))
      local width = math.max(30, math.floor(vim.o.columns * 0.25))

      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == 'fugitive' then
          if vim.api.nvim_win_get_width(win) < vim.o.columns then
            pcall(vim.api.nvim_win_set_width, win, width)
          else
            pcall(vim.api.nvim_win_set_height, win, height)
          end
        end
      end
    end

    vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter', 'VimResized' }, {
      group = vim.api.nvim_create_augroup('fugitive-resize', { clear = true }),
      callback = function()
        vim.schedule(resize_fugitive_windows)
      end,
    })
  end,
}
