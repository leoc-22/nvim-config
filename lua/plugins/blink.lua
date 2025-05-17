return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',

    opts = {
      -- https://cmp.saghen.dev/configuration/keymap.html#presets
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true },
      completion = {
        -- https://github.com/Saghen/blink.cmp/discussions/157
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        }
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
