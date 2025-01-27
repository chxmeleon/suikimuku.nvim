local kimuku = {}

-- Define grayscale colorscheme
kimuku.setup = function()
  vim.cmd("hi clear") -- Clear existing highlights
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark" -- Set background (can also be "light")
  vim.g.colors_name = "kimuku" -- Name the colorscheme

  -- Define grayscale color palette
  local palette = {
    bg = "#1c1c1c",     -- Dark background
    fg = "#dcdcdc",     -- Light foreground
    gray = "#808080",   -- Mid-gray
    light_gray = "#c0c0c0",
    dark_gray = "#505050",
    black = "#000000",
    white = "#ffffff",
  }

  -- Apply highlights (examples below, customize as needed)
  vim.cmd("hi Normal guibg=" .. palette.bg .. " guifg=" .. palette.fg) -- Main background and text
  vim.cmd("hi Comment guifg=" .. palette.gray .. " gui=italic") -- Comments in gray, italic
  vim.cmd("hi Keyword guifg=" .. palette.light_gray .. " gui=bold") -- Keywords in light gray, bold
  vim.cmd("hi String guifg=" .. palette.dark_gray) -- Strings in darker gray
  vim.cmd("hi Function guifg=" .. palette.white .. " gui=bold") -- Functions in white, bold
  vim.cmd("hi Type guifg=" .. palette.light_gray) -- Types in light gray
  vim.cmd("hi Error guifg=" .. palette.white .. " guibg=" .. palette.gray) -- Errors with white text on gray background
  vim.cmd("hi LineNr guifg=" .. palette.gray) -- Line numbers in gray
  vim.cmd("hi CursorLineNr guifg=" .. palette.white .. " gui=bold") -- Current line number in white, bold
  vim.cmd("hi Visual guibg=" .. palette.dark_gray) -- Visual mode background
  vim.cmd("hi StatusLine guibg=" .. palette.black .. " guifg=" .. palette.white) -- Status line
end

return kimuku
