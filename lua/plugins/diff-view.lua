local function toggle_diffview()
  local diffview_open = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match 'DiffviewFiles' or buf_name:match 'Diffview' then
      diffview_open = true
      break
    end
  end

  if diffview_open then
    vim.cmd 'DiffviewClose'
  else
    vim.cmd 'DiffviewOpen'
  end
end

return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
  config = function()
    vim.keymap.set('n', '<leader>dv', toggle_diffview, { noremap = true, silent = true, desc = 'Toggle Diffview' })
  end,
}
