local M = {}

local function python_executable()
  if vim.env.VIRTUAL_ENV then
    for _, name in ipairs({ 'python3', 'python' }) do
      local candidate = vim.env.VIRTUAL_ENV .. '/bin/' .. name
      if vim.uv.fs_stat(candidate) then
        return candidate
      end
    end
  end

  return 'python3'
end

local jedi_script = [=[
import json
import sys

try:
    import jedi
except ImportError:
    print(json.dumps({"error": "no_jedi"}))
    sys.exit(0)

path = sys.argv[1]
row = int(sys.argv[2])
col = int(sys.argv[3])
code = sys.stdin.read()

script = jedi.Script(code=code, path=path)
helps = script.help(row, col)
if not helps:
    print(json.dumps({"found": False}))
else:
    h = helps[0]
    doc = (h.docstring() or "").strip()
    if doc:
        print(json.dumps({"found": True, "doc": doc, "name": h.full_name or h.name}))
    else:
        print(json.dumps({"found": False}))
]=]

local warned_no_jedi = false

local function show_doc(doc, title)
  local lines = vim.split(doc, '\n', { plain = true })
  vim.lsp.util.open_floating_preview(lines, 'markdown', {
    border = 'rounded',
    title = title,
    title_pos = 'center',
    max_width = math.min(88, vim.o.columns - 8),
    max_height = math.min(30, vim.o.lines - 8),
  })
end

function M.hover()
  if vim.bo.filetype ~= 'python' then
    return vim.lsp.buf.hover()
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local path = vim.api.nvim_buf_get_name(bufnr)
  if path == '' then
    path = 'untitled.py'
  end
  local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n')

  vim.system(
    { python_executable(), '-c', jedi_script, path, tostring(row), tostring(col) },
    { stdin = content, text = true },
    function(result)
      vim.schedule(function()
        if result.code ~= 0 or not result.stdout or result.stdout == '' then
          return vim.lsp.buf.hover()
        end

        local ok, data = pcall(vim.json.decode, result.stdout)
        if not ok or not data then
          return vim.lsp.buf.hover()
        end

        if data.error == 'no_jedi' then
          if not warned_no_jedi then
            warned_no_jedi = true
            vim.notify(
              'Python hover: install jedi (`pip install jedi`) for readable stdlib docs',
              vim.log.levels.WARN
            )
          end
          return vim.lsp.buf.hover()
        end

        if data.found and data.doc and data.doc ~= '' then
          return show_doc(data.doc, data.name or 'docs')
        end

        vim.lsp.buf.hover()
      end)
    end
  )
end

return M
