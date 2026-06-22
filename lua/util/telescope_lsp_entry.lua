--- Custom Telescope entry maker for LSP location pickers (references, definitions, etc.)
local make_entry = require 'telescope.make_entry'
local utils = require 'telescope.utils'

local M = {}

local function get_filename_fn()
  local bufnr_name_cache = {}
  return function(bufnr)
    bufnr = utils.if_nil(bufnr, 0)
    local cached = bufnr_name_cache[bufnr]
    if cached then
      return cached
    end

    local name = vim.api.nvim_buf_get_name(bufnr)
    bufnr_name_cache[bufnr] = name
    return name
  end
end

local function clean_entry_text(text, trim_text)
  if not text then
    return ''
  end

  if trim_text then
    text = vim.trim(text)
  end

  return text:gsub('.* | ', '')
end

function M.gen_from_lsp_location(opts)
  opts = vim.tbl_extend('force', {
    show_line = true,
    path_display = { shorten = { len = 5 } },
    trim_text = true,
  }, opts or {})

  local disable_devicons = opts.disable_devicons
  local get_filename = get_filename_fn()

  local make_display = function(entry)
    local icon, icon_hl = utils.get_devicons(entry.filename, disable_devicons)
    local path, path_style = utils.transform_path(opts, entry.filename)
    local coords = string.format(':%d:%d', entry.lnum, entry.col)
    local text = opts.show_line and clean_entry_text(entry.text, opts.trim_text) or ''

    local parts = {}
    if icon ~= '' then
      parts[#parts + 1] = icon
    end
    parts[#parts + 1] = coords

    local display = table.concat(parts, ' ')
    if text ~= '' then
      display = display .. '  ' .. text
    end
    if path and path ~= '' then
      display = display .. '  ' .. path
    end

    local highlights = {}
    local offset = 0

    if icon ~= '' then
      if icon_hl then
        highlights[#highlights + 1] = { { offset, offset + #icon }, icon_hl }
      end
      offset = offset + #icon + 1
    end

    highlights[#highlights + 1] = { { offset, offset + #coords }, 'LineNr' }

    if path and path ~= '' then
      local path_start = #display - #path
      highlights[#highlights + 1] = { { path_start, #display }, 'Comment' }
      if path_style then
        highlights = utils.merge_styles(highlights, path_style, path_start)
      end
    end

    return display, highlights
  end

  return function(entry)
    local filename = utils.if_nil(entry.filename, get_filename(entry.bufnr))

    return make_entry.set_default_entry_mt({
      value = entry,
      ordinal = filename .. ' ' .. (entry.text or ''),
      display = make_display,
      bufnr = entry.bufnr,
      filename = filename,
      lnum = entry.lnum,
      col = entry.col,
      text = entry.text,
      start = entry.start,
      finish = entry.finish,
    }, opts)
  end
end

return M
