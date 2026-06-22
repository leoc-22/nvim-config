--- fff.nvim preview hardcodes CursorLine / IncSearch for match-line highlighting.
--- extmark line_hl_group always flattens syntax to near-black text, even with a
--- bg-only group. Convert line highlights to a full-line hl_group span instead.
local M = {}

local PREVIEW_LINE = 'FFFPreviewLine'
local PREVIEW_LINE_NR = 'FFFPreviewLineNr'
local PREVIEW_MATCH = 'FFFPreviewMatch'

local function apply_highlight_groups()
  vim.api.nvim_set_hl(0, PREVIEW_LINE, { bg = '#45475a' })
  vim.api.nvim_set_hl(0, PREVIEW_LINE_NR, { fg = '#f5e0dc', bg = '#45475a', bold = true })
  vim.api.nvim_set_hl(0, PREVIEW_MATCH, { bg = '#89dceb', fg = '#11111b', bold = true })
end

local function line_byte_length(buf, row)
  local lines = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)
  return math.max(#(lines[1] or ''), 1)
end

local function remap_extmark_opts(opts)
  if type(opts) ~= 'table' then
    return opts
  end

  local mapped = vim.deepcopy(opts)

  if mapped.line_hl_group then
    mapped._fff_line_bg = true
    mapped.line_hl_group = nil
  end

  if mapped.number_hl_group == 'CursorLineNr' then
    mapped.number_hl_group = PREVIEW_LINE_NR
  end

  if mapped.hl_group == 'IncSearch' then
    mapped.hl_group = PREVIEW_MATCH
  end

  return mapped
end

local function add_line_background(set_extmark, buf, ns, row, priority)
  set_extmark(buf, ns, row, 0, {
    hl_group = PREVIEW_LINE,
    end_col = line_byte_length(buf, row),
    priority = (priority or 1000) - 2,
    hl_mode = 'combine',
  })
end

local function patch_extmark_highlights(fn, bufnr, location, namespace)
  local set_extmark = vim.api.nvim_buf_set_extmark

  vim.api.nvim_buf_set_extmark = function(buf, ns, row, col, opts)
    if ns == namespace and type(opts) == 'table' then
      opts = remap_extmark_opts(opts)
      if opts._fff_line_bg then
        opts._fff_line_bg = nil
        add_line_background(set_extmark, buf, ns, row, opts.priority)
      end
    end
    return set_extmark(buf, ns, row, col, opts)
  end

  local ok, result = pcall(fn, bufnr, location, namespace)
  vim.api.nvim_buf_set_extmark = set_extmark

  if not ok then
    error(result)
  end

  return result
end

function M.setup()
  apply_highlight_groups()

  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('fff-preview-hl', { clear = true }),
    callback = apply_highlight_groups,
    desc = 'Restore fff preview highlight groups after colorscheme change',
  })

  local location_utils = require('fff.location_utils')
  if location_utils._fff_preview_hl_patched then
    return
  end
  location_utils._fff_preview_hl_patched = true

  local highlight_location = location_utils.highlight_location

  function location_utils.highlight_location(bufnr, location, namespace)
    return patch_extmark_highlights(highlight_location, bufnr, location, namespace)
  end
end

return M
