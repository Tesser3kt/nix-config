local M = {}

-- Detect if cursor is inside Typst math ($...$ or $[ ... ]$)
M.in_typst_math = function()
  if vim.bo.filetype ~= "typst" then return false end

  -- Try Tree-sitter first
  local ok, parser = pcall(vim.treesitter.get_parser, 0, "typst")
  if ok and parser then
    local node = vim.treesitter.get_node({buf=0})
    while node do
      local t = node:type()
      -- Future-proof: check common math node names
      if t == "math" or t == "math_inline" or t == "math_block" then
        return true
      end
      node = node:parent()
    end
  end

  -- Fallback (see option 2 below)
  return M.in_typst_math_fallback()
end

-- Heuristic fallback (regex; also used if TS missing)
M.in_typst_math_fallback = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  local line = vim.api.nvim_get_current_line()

  -- Inline $...$
  local before = line:sub(1, col)
  local after  = line:sub(col + 1)
  local n_before = select(2, before:gsub("%$", ""))
  local n_after  = select(2, after:gsub("%$", ""))
  if (n_before % 2 == 1) and (n_after % 2 == 1) then
    return true
  end

  -- Block $[ ... ]$ (search surrounding lines)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  local open_seen = false
  for r = row, 0, -1 do
    if lines[r + 1]:find("%]%$") then break end
    if lines[r + 1]:find("%$%[") then open_seen = true; break end
  end
  if open_seen then
    for r = row, #lines - 1 do
      if lines[r + 1]:find("%]%$") then return true end
      if lines[r + 1]:find("%$%[") and r ~= row then return true end
    end
  end

  return false
end

return M

