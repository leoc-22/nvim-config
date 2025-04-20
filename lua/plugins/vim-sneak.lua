return {
  'justinmk/vim-sneak',

  init = function()
    vim.g['sneak#s_next'] = 1 -- happens before plugin code
  end,

  keys = {
    { 'f', '<Plug>Sneak_s', mode = 'n' },
    { 'F', '<Plug>Sneak_S', mode = 'n' },
    { 'f', '<Plug>Sneak_s', mode = 'v' },
    { 'F', '<Plug>Sneak_S', mode = 'v' },
    { 'f', '<Plug>Sneak_s', mode = 'x' },
    { 'F', '<Plug>Sneak_S', mode = 'x' },
  }
}
