-- Minimal Grayscale Theme with Transparent Background for kimuku.nvim
local M = {}

-- Color Palette (grayscale-based)
local colors = {
    bg = 'none',             -- Transparent background
    fg = '#D3D3D3',          -- Light gray for text
    fg_dark = '#A8A8A8',     -- Darker gray for muted text
    keyword = '#B0B0B0',     -- Grayish white for keywords
    string = '#B0B0B0',      -- Light gray for strings
    comment = '#707070',     -- Dark gray for comments
    func = '#B0B0B0',        -- Functions same as keywords
    number = '#D3D3D3',      -- Numbers same as fg
    operator = '#D3D3D3',    -- Operators same as fg
    type = '#B0B0B0',        -- Types same as keywords
    variable = '#A8A8A8',    -- Variables same as muted text
    status_line = 'none',    -- Transparent status line
    status_text = '#A8A8A8', -- Muted text for status line
    line_nr = '#707070',     -- Dark gray for line numbers
    cursor_line = '#2A2A2A', -- Slight gray background for cursor line
    selection = '#444444',   -- Darker gray for selection highlight
    diff_add = '#4F4F4F',    -- Dark greenish gray for additions
    diff_delete = '#8B4F4F', -- Dark red for deletions
    diff_change = '#6F6F6F', -- Slightly lighter gray for changes
    diff_text = '#4F4F6F',   -- Blue-tinged gray for diff text
    error = '#FF5C5C',       -- Red for errors
    warn = '#FFB84D',        -- Soft orange for warnings
    info = '#7F7F7F',        -- Soft gray for info
    hint = '#A8A8A8',        -- Hints same as muted text
}

function M.setup()
    -- Reset highlights
    vim.cmd('highlight clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end

    -- Set colorscheme name
    vim.g.colors_name = 'kimuku'

    -- Define highlight groups
    local highlights = {
        -- Editor UI
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = colors.bg },
        SignColumn = { bg = colors.bg },
        EndOfBuffer = { fg = colors.bg },
        Cursor = { fg = colors.bg, bg = colors.fg },
        CursorLine = { bg = colors.cursor_line },
        CursorLineNr = { fg = colors.fg, bold = true },
        LineNr = { fg = colors.line_nr },
        Visual = { bg = colors.selection },
        Pmenu = { fg = colors.fg, bg = colors.bg },
        StatusLine = { fg = colors.status_text, bg = colors.status_line },
        StatusLineNC = { fg = colors.fg_dark, bg = colors.status_line },
        Comment = { fg = colors.comment, italic = true },
        Constant = { fg = colors.number },
        String = { fg = colors.string },
        Identifier = { fg = colors.variable },
        Function = { fg = colors.func },
        Keyword = { fg = colors.keyword },
        Type = { fg = colors.type },
        DiffAdd = { bg = colors.diff_add },
        DiffDelete = { bg = colors.diff_delete },
        DiffChange = { bg = colors.diff_change },
        DiffText = { bg = colors.diff_text },
        DiagnosticError = { fg = colors.error },
        DiagnosticWarn = { fg = colors.warn },
        DiagnosticInfo = { fg = colors.info },
        DiagnosticHint = { fg = colors.hint },
        DiagnosticUnderlineError = { sp = colors.error, undercurl = true },
        DiagnosticUnderlineWarn = { sp = colors.warn, undercurl = true },
        DiagnosticUnderlineInfo = { sp = colors.info, undercurl = true },
        DiagnosticUnderlineHint = { sp = colors.hint, undercurl = true },
        ['@keyword'] = { link = 'Keyword' },
        ['@string'] = { link = 'String' },
        ['@function'] = { link = 'Function' },
    }

    -- Apply highlights
    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

return M
