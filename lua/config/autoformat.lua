local M = {}

-- Master switch. Set to false to disable autoformat entirely.
M.enabled = true

-- Override the timeout (in ms) for running formatters.
M.timeout_ms = 500

-- Filetypes that should never autoformat on save.
-- Accepts either a list: { 'javascript', 'typescript' }
-- or a lookup table: { javascript = true, typescript = true }.
M.disabled_filetypes = {
  javascript = true,
}

-- Filetypes where LSP formatting should never run as a fallback.
-- Same accepted formats as disabled_filetypes.
M.disable_lsp_fallback_filetypes = {
  c = true,
  cpp = true,
}

-- Optional: Override Conform's formatter map per filetype.
-- Leave nil to keep defaults from the plugin spec.
M.formatters_by_ft = {
  lua = { 'stylua' },
  -- Conform can also run multiple formatters sequentially
  -- python = { "isort", "black" },
  -- You can use 'stop_after_first' to run the first available formatter from the list
  javascript = { 'prettier', stop_after_first = true },
  typescript = { 'prettier', stop_after_first = true },
  typescriptreact = { 'prettier', stop_after_first = true },
}

return M
