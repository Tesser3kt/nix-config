-- lua/typst_mathzone.lua
local M = {}

-- True iff cursor is inside Typst math:
--   1) $[ ... ]$   (block)
--   2) $ ... $     (plain-dollar block that may span lines)
--   3) $...$       (inline, possibly wrapped across lines)
M.in_typst_math = function()
  if vim.bo.filetype ~= "typst" then return false end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local function cut_at_comment(s, upto)
    -- consider only text up to 'upto' and before // comment
    s = s:sub(1, upto)
    local cpos = s:find("//", 1, true)
    if cpos then s = s:sub(1, cpos - 1) end
    return s
  end

  local block_depth = 0   -- nesting count of $[ ... ]$
  local dollar_parity = 0 -- parity of plain '$' (not part of $[ or ]$)

  for i = 0, row do
    local line = lines[i + 1] or ""
    local upto = (i == row) and col or #line
    line = cut_at_comment(line, upto)

    local j = 1
    while j <= #line do
      local a = line:sub(j, j + 1)
      if a == "$[" then
        block_depth = block_depth + 1
        j = j + 2
      elseif a == "]$" then
        if block_depth > 0 then block_depth = block_depth - 1 end
        j = j + 2
      else
        local ch = line:sub(j, j)
        if ch == "$" then
          -- count as "plain" $ only if not part of $[ or ]$ (already handled)
          dollar_parity = 1 - dollar_parity
        end
        j = j + 1
      end
    end
  end

  -- Inside a $[ ... ]$ block?
  if block_depth > 0 then return true end

  -- Inside a plain-dollar math region ($ ... $ or wrapped $...$)?
  -- Odd parity up to the cursor means we've seen an opening $ with no closing $ yet.
  return dollar_parity == 1
end

return M

