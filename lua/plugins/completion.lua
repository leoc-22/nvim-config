return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',

    opts = {
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true },
      -- https://github.com/Saghen/blink.cmp/discussions/157
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
