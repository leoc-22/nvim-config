return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = function()
      local autoformat = require('config.autoformat')

      local function to_lookup(value)
        if value == nil then
          return {}
        end
        if vim.islist(value) then
          local map = {}
          for _, ft in ipairs(value) do
            map[ft] = true
          end
          return map
        end
        return value
      end

      local disabled_filetypes = to_lookup(autoformat.disabled_filetypes or autoformat.disable_filetypes)
      local lsp_fallback_disabled = to_lookup(autoformat.disable_lsp_fallback_filetypes or
        autoformat.lsp_fallback_disabled_filetypes)
      local timeout_ms = autoformat.timeout_ms or 500
      local formatters_by_ft = autoformat.formatters_by_ft

      return {
        notify_on_error = false,
        format_on_save = function(bufnr)
          if autoformat.enabled == false or vim.g.disable_autoformat == true then
            return
          end

          local filetype = vim.bo[bufnr].filetype

          if vim.b[bufnr].disable_autoformat == true or disabled_filetypes[filetype] then
            return
          end

          return {
            timeout_ms = timeout_ms,
            lsp_format = lsp_fallback_disabled[filetype] and 'never' or 'fallback',
          }
        end,
        formatters_by_ft = formatters_by_ft,
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
