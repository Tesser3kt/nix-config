-- [[ Subscript Typst snippets ]]
local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Check if in math mode
local mathzone = require("typst-mathzone")

-- Get visual selection text
local get_visual = function(args, parent)
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else -- If SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

return {
  -- Digit subscripts
  s(
    {
      trig = "([A-Za-z]+[%)%]}]?)(%d)",
      priority = 100,
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
      dscr = "Auto digit subscript"
    },
    fmta("<>_<>", {
      f(function(_,snip)
        return snip.captures[1]
      end),
      f(function(_,snip)
        return snip.captures[2]
      end),
    }),
    { condition = mathzone.in_typst_math }
  ),
  s(
    {
      trig = "([A-Za-z]+[%)%]}]?)_(%d%d)",
      priority = 200,
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
      dscr = "Auto multiple digit subscript"
    },
    fmta("<>_(<>)}", {
      f(function(_,snip)
        return snip.captures[1]
      end),
      f(function(_,snip)
        return snip.captures[2]
      end),
    }),
    { condition = mathzone.in_typst_math }
  ),

  -- Index subscripts
  s(
    {
      trig = "([A-Za-z]+[%)%]}]?)ii",
      priority = 100,
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
      dscr = "Auto i subscript"
    },
    fmta("<>_i", {
      f(function(_,snip)
        return snip.captures[1]
      end),
    }),
    { condition = mathzone.in_typst_math }
  ),
  s(
    {
      trig = "([A-Za-z]+[%)%]}]?)jj",
      priority = 100,
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
      dscr = "Auto j subscript"
    },
    fmta("<>_j", {
      f(function(_,snip)
        return snip.captures[1]
      end),
    }),
    { condition = mathzone.in_typst_math }
  ),
  s(
    {
      trig = "([A-Za-z]+[%)%]}]?)kk",
      priority = 100,
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
      dscr = "Auto k subscript"
    },
    fmta("<>_k", {
      f(function(_,snip)
        return snip.captures[1]
      end),
    }),
    { condition = mathzone.in_typst_math }
  ),
  s(
    {
      trig = "([A-Za-z]+[%)%]}]?)ll",
      priority = 100,
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
      dscr = "Auto l subscript"
    },
    fmta("<>_l", {
      f(function(_,snip)
        return snip.captures[1]
      end),
    }),
    { condition = mathzone.in_typst_math }
  ),
  s(
    {
      trig = "([A-Za-z]+[%)%]}]?)mm",
      priority = 100,
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
      dscr = "Auto m subscript"
    },
    fmta("<>_m", {
      f(function(_,snip)
        return snip.captures[1]
      end),
    }),
    { condition = mathzone.in_typst_math }
  ),
  s(
    {
      trig = "([A-Za-z]+[%)%]}]?)nn",
      priority = 100,
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
      dscr = "Auto n subscript"
    },
    fmta("<>_n", {
      f(function(_,snip)
        return snip.captures[1]
      end),
    }),
    { condition = mathzone.in_typst_math }
  ),

  -- General subscript
  s(
    {
      trig = "__",
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "General subscript"
    },
    fmta("_(<>)<>", { i(1), i(0) }),
    { condition = mathzone.in_typst_math }
  ),

  -- Restriction
  s(
    {
      trig = "(%a+)|\\",
      wordTrig = false,
      regTrig = true,
      snippetType = "autosnippet",
      dscr = "Restriction"
    },
    fmta("<>_(|<>)<>", { 
      f(function(_,snip)
        return snip.captures[1]
      end),
      i(1), 
      i(0) 
    }),
    { condition = mathzone.in_typst_math }
  ),
}
