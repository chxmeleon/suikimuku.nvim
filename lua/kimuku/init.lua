local themes = require("kimuku.themes")

local function apply_theme(theme_name, transparent)
  local theme = themes[theme_name]
  if not theme then
    print("Theme not found: " .. theme_name)
    return
  end

  -- Set background transparency if requested
  local background = theme.background
  if transparent then
    background = "none"
  end

  -- Apply the theme using Neovim's API
  vim.cmd("highlight Normal guibg=" .. background .. " guifg=" .. theme.foreground)
  vim.cmd("highlight Cursor guifg=" .. theme.cursor)
  vim.cmd("highlight Statement guifg=" .. theme.primary)
  vim.cmd("highlight Comment guifg=" .. theme.secondary)

  -- Optional: Apply additional highlights
end

-- Expose setup function for user configuration
local function setup(config)
  config = config or {}
  local theme_name = config.theme or "ki" -- Default to high contrast
  local transparent = config.transparent or false
  apply_theme(theme_name, transparent)
end

return {
  setup = setup
}
