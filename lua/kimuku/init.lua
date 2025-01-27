-- Minimal Grayscale Theme with Transparent Background

local M = {}

-- Color Palette (grayscale-based)
local colors = {
    bg = "none",             -- Transparent background for general UI
    bg_light = "none",       -- Transparent background for light areas
    bg_darker = "none",      -- Transparent background for darker areas
    fg = "#D3D3D3",          -- Light gray (for text)
    fg_dark = "#A8A8A8",     -- Darker gray (for muted text)

    keyword = "#B0B0B0",     -- Grayish white for keywords
    string = "#B0B0B0",      -- Light gray for strings
    comment = "#707070",     -- Darker gray for comments
    func = "#B0B0B0",        -- Same as keyword and string for functions
    number = "#D3D3D3",      -- Same as fg for numbers
    operator = "#D3D3D3",    -- Same as fg for operators
    type = "#B0B0B0",        -- Same as keyword for types
    decorator = "#A8A8A8",   -- Darker gray for decorators
    variable = "#A8A8A8",    -- Same as decorator for variables

    cursor_line = "#2A2A2A", -- Slight gray background for cursor line
    selection = "#444444",   -- Darker selection highlight
    line_nr = "#707070",     -- Dark gray for line numbers

    diff_add = "#4F4F4F",    -- Dark greenish gray for additions
    diff_delete = "#8B4F4F", -- Dark red for deletions
    diff_change = "#6F6F6F", -- Slightly lighter gray for changes
    diff_text = "#4F4F6F",   -- Blue-tinged gray for diff text

    error = "#FF5C5C",       -- Red for errors
    warn = "#FFB84D",        -- Soft orange for warnings
    info = "#7F7F7F",        -- Soft gray for info
    hint = "#A8A8A8",        -- Same as variable for hints
}

--- Helper function to add alpha transparency
---@param color string # Hex color
---@param alpha number # Alpha value (0.0 to 1.0)
---@return string
local function with_alpha(color, alpha)
    return string.format("%s%02X", color, math.floor(alpha * 255))
end

--- Highlight groups with transparency support
---@return table
local function get_highlights()
    return {
        -- Editor UI
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = colors.bg_light },
        SignColumn = { fg = colors.fg, bg = colors.bg },
        EndOfBuffer = { fg = colors.bg, bg = colors.bg },
        CursorLine = { bg = colors.cursor_line },
        CursorLineNr = { fg = colors.fg, bold = true },
        LineNr = { fg = colors.line_nr },
        Visual = { bg = colors.selection },

        -- Popup Menu
        Pmenu = { fg = colors.fg, bg = colors.bg_light },
        PmenuSel = { fg = colors.fg, bg = colors.selection },
        PmenuSbar = { bg = colors.bg_light },
        PmenuThumb = { bg = colors.fg_dark },

        -- Status Line
        StatusLine = { fg = colors.fg_dark, bg = colors.bg },
        StatusLineNC = { fg = colors.fg_dark, bg = colors.bg },

        -- Syntax Groups
        Comment = { fg = colors.comment, italic = true },
        Constant = { fg = colors.number },
        String = { fg = colors.string },
        Identifier = { fg = colors.variable },
        Function = { fg = colors.func },
        Keyword = { fg = colors.keyword },
        Type = { fg = colors.type },

        -- Diff
        DiffAdd = { bg = with_alpha(colors.diff_add, 0.2) },
        DiffDelete = { bg = with_alpha(colors.diff_delete, 0.2) },
        DiffChange = { bg = with_alpha(colors.diff_change, 0.2) },
        DiffText = { bg = with_alpha(colors.diff_text, 0.2) },

        -- Diagnostics
        DiagnosticError = { fg = colors.error },
        DiagnosticWarn = { fg = colors.warn },
        DiagnosticInfo = { fg = colors.info },
        DiagnosticHint = { fg = colors.hint },
        DiagnosticUnderlineError = { sp = colors.error, undercurl = true },
        DiagnosticUnderlineWarn = { sp = colors.warn, undercurl = true },
    }
end

--- Apply the highlights
---@param highlights table
local function apply_highlights(highlights)
    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

--- Setup the colorscheme
function M.setup()
    vim.cmd("highlight clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    vim.g.colors_name = "kimuku" -- Colorscheme name

    local highlights = get_highlights()
    apply_highlights(highlights)
end

return M
