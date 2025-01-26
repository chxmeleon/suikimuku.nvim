-- Minimal Grayscale Theme with Transparent Background for Neovim

local M = {}

-- Color Palette (grayscale-based)
local colors = {
    -- Base colors (using transparent backgrounds)
    bg = 'none',             -- Transparent background for general UI
    bg_light = 'none',       -- Transparent background for light areas
    bg_darker = 'none',      -- Transparent background for darker areas
    fg = '#D3D3D3',          -- Light gray (for text)
    fg_dark = '#A8A8A8',     -- Darker gray (for muted text)
    
    -- Syntax colors (minimal contrast)
    keyword = '#B0B0B0',     -- Grayish white for keywords
    string = '#B0B0B0',      -- Light gray for strings
    comment = '#707070',     -- Darker gray for comments
    func = '#B0B0B0',        -- Same as keyword and string for functions
    number = '#D3D3D3',      -- Same as fg for numbers
    operator = '#D3D3D3',    -- Same as fg for operators
    type = '#B0B0B0',        -- Same as keyword for types
    decorator = '#A8A8A8',   -- Darker gray for decorators
    variable = '#A8A8A8',    -- Same as decorator for variables
    
    -- UI colors (transparent backgrounds)
    status_line = 'none',    -- Transparent status line
    status_text = '#A8A8A8', -- Muted text for status line
    line_nr = '#707070',     -- Dark gray for line numbers
    cursor_line = '#2A2A2A', -- Slight gray background for cursor line
    selection = '#444444',   -- Darker selection highlight
    pmenu = 'none',          -- Transparent popup menu background
    
    -- Diff colors (subtle color differences)
    diff_add = '#4F4F4F',     -- Dark greenish gray for additions
    diff_delete = '#8B4F4F',  -- Dark red for deletions
    diff_change = '#6F6F6F',  -- Slightly lighter gray for changes
    diff_text = '#4F4F6F',    -- Blue-tinged gray for diff text
    
    -- Diagnostic colors
    error = '#FF5C5C',        -- Red for errors (still visible)
    warn = '#FFB84D',         -- Soft orange for warnings
    info = '#7F7F7F',         -- Soft gray for info
    hint = '#A8A8A8',         -- Same as variable for hints
}

function M.setup()
    -- Reset all highlights
    vim.cmd('highlight clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end
    
    -- Set colorscheme name
    vim.g.colors_name = 'minimal_grayscale_transparent'
    
    -- Helper function for transparency
    local function with_alpha(color, alpha)
        return string.format('%s%02x', color, math.floor(alpha * 255))
    end
    
    -- Define highlight groups with transparent backgrounds
    local highlights = {
        -- Editor UI
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = colors.bg_light },
        SignColumn = { fg = colors.fg, bg = colors.bg },
        EndOfBuffer = { fg = colors.bg, bg = colors.bg },
        NormalNC = { fg = colors.fg_dark, bg = colors.bg },
        Cursor = { fg = colors.bg, bg = colors.fg },
        CursorLine = { bg = colors.cursor_line },
        CursorLineNr = { fg = colors.fg, bold = true },
        LineNr = { fg = colors.line_nr },
        Visual = { bg = colors.selection },
        VisualNOS = { bg = colors.selection },
        
        -- Popup Menu
        Pmenu = { fg = colors.fg, bg = colors.pmenu },
        PmenuSel = { fg = colors.fg, bg = colors.selection },
        PmenuSbar = { bg = colors.bg_light },
        PmenuThumb = { bg = colors.fg_dark },
        
        -- Status Line
        StatusLine = { fg = colors.status_text, bg = colors.status_line },
        StatusLineNC = { fg = colors.fg_dark, bg = colors.status_line },
        
        -- Syntax Groups
        Comment = { fg = colors.comment, italic = true },
        Constant = { fg = colors.number },
        String = { fg = colors.string },
        Character = { fg = colors.string },
        Number = { fg = colors.number },
        Boolean = { fg = colors.number },
        Float = { fg = colors.number },
        
        Identifier = { fg = colors.variable },
        Function = { fg = colors.func },
        Statement = { fg = colors.keyword },
        Conditional = { fg = colors.keyword },
        Repeat = { fg = colors.keyword },
        Label = { fg = colors.keyword },
        Operator = { fg = colors.operator },
        Keyword = { fg = colors.keyword },
        Exception = { fg = colors.keyword },
        
        PreProc = { fg = colors.decorator },
        Include = { fg = colors.keyword },
        Define = { fg = colors.keyword },
        Macro = { fg = colors.decorator },
        PreCondit = { fg = colors.decorator },
        
        Type = { fg = colors.type },
        StorageClass = { fg = colors.keyword },
        Structure = { fg = colors.type },
        Typedef = { fg = colors.type },
        
        Special = { fg = colors.operator },
        SpecialChar = { fg = colors.string },
        Tag = { fg = colors.type },
        Delimiter = { fg = colors.fg },
        SpecialComment = { fg = colors.comment, italic = true },
        Debug = { fg = colors.warn },
        
        -- Diffs
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
        DiagnosticUnderlineInfo = { sp = colors.info, undercurl = true },
        DiagnosticUnderlineHint = { sp = colors.hint, undercurl = true },
        
        -- TreeSitter highlights
        ['@keyword'] = { link = 'Keyword' },
        ['@string'] = { link = 'String' },
        ['@function'] = { link = 'Function' },
        ['@function.call'] = { link = 'Function' },
        ['@method'] = { link = 'Function' },
        ['@constructor'] = { fg = colors.type },
        ['@parameter'] = { fg = colors.variable },
        ['@number'] = { link = 'Number' },
        ['@boolean'] = { link = 'Boolean' },
        ['@type'] = { link = 'Type' },
        ['@property'] = { fg = colors.variable },
        ['@field'] = { fg = colors.variable },
        ['@attribute'] = { fg = colors.decorator },
        ['@namespace'] = { fg = colors.type, italic = true },
        
        -- LSP Semantic tokens
        ['@lsp.type.class'] = { link = '@type' },
        ['@lsp.type.decorator'] = { link = '@attribute' },
        ['@lsp.type.enum'] = { link = '@type' },
        ['@lsp.type.function'] = { link = '@function' },
        ['@lsp.type.interface'] = { link = '@type' },
        ['@lsp.type.namespace'] = { link = '@namespace' },
        ['@lsp.type.parameter'] = { link = '@parameter' },
        ['@lsp.type.property'] = { link = '@property' },
        ['@lsp.type.variable'] = { link = '@variable' },
        
        -- Markdown
        markdownH1 = { fg = colors.keyword, bold = true },
        markdownH2 = { fg = colors.keyword, bold = true },
        markdownH3 = { fg = colors.keyword, bold = true },
        markdownH4 = { fg = colors.keyword, bold = true },
        markdownH5 = { fg = colors.keyword, bold = true },
        markdownH6 = { fg = colors.keyword, bold = true },
        markdownCode = { fg = colors.string },
        markdownCodeBlock = { fg = colors.string },
        markdownQuote = { fg = colors.comment, italic = true },
    }
    
    -- Set all highlights
    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

-- Return the module
return M
