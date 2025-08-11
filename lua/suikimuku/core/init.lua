-- Suikimuku Core Module
-- Main coordination module for the unified architecture

local M = {}

-- Load the colorscheme with specified style
function M.load(style)
    -- Get the configuration system
    local config_module = require('suikimuku.core.config')
    local colors_module = require('suikimuku.core.colors')
    
    -- Get current configuration
    local config = config_module.get_config()
    
    -- Use provided style or fall back to config style
    local active_style = style or config.style or 'sui'
    
    -- Update config if style was provided
    if style and style ~= config.style then
        config.style = style
        config_module.update_config({ style = style })
    end
    
    -- Clear existing highlights
    vim.cmd('highlight clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end
    
    -- Set colorscheme name
    vim.g.colors_name = 'suikimuku'
    
    -- Get colors for the active style
    local colors = colors_module.get(active_style, 'legacy')
    
    -- Generate base highlights
    local highlights = M.generate_base_highlights(colors, config)
    
    -- Apply base highlights
    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end
    
    -- Load plugin highlights if plugins are enabled
    if config.plugins and config.plugins.auto_detect ~= false then
        local plugins_module = require('suikimuku.plugins')
        local plugin_highlights = plugins_module.generate_all_highlights(colors, config)
        
        -- Apply plugin highlights
        for group, settings in pairs(plugin_highlights) do
            vim.api.nvim_set_hl(0, group, settings)
        end
    end
    
    -- Apply user customizations
    if config.on_highlights then
        local user_highlights = config.on_highlights(highlights, colors)
        if user_highlights then
            for group, settings in pairs(user_highlights) do
                vim.api.nvim_set_hl(0, group, settings)
            end
        end
    end
end

-- Generate base highlight groups (core editor highlights)
function M.generate_base_highlights(colors, config)
    -- Handle transparency
    local use_transparent = false
    if config.transparency then
        if config.transparency.background ~= nil then
            use_transparent = config.transparency.background
        end
    end
    
    local bg_primary = use_transparent and 'NONE' or colors.bg.primary
    local bg_float = use_transparent and 'NONE' or colors.bg.float
    
    return {
        -- Editor fundamentals
        Normal = { fg = colors.fg.primary, bg = bg_primary },
        NormalFloat = { fg = colors.fg.primary, bg = bg_float },
        NormalNC = { fg = colors.fg.secondary, bg = bg_primary },
        
        -- UI elements
        SignColumn = { bg = bg_primary },
        LineNr = { fg = colors.fg.subtle, bg = bg_primary },
        CursorLine = { bg = colors.bg.secondary },
        CursorLineNr = { fg = colors.blue.primary, bold = true, bg = colors.bg.secondary },
        ColorColumn = { bg = colors.bg.secondary },
        
        -- Visual selection
        Visual = { bg = colors.bg.highlight },
        VisualNOS = { bg = colors.bg.highlight },
        
        -- Window elements
        StatusLine = { fg = colors.fg.primary, bg = colors.bg.secondary },
        StatusLineNC = { fg = colors.fg.subtle, bg = colors.bg.secondary },
        TabLine = { fg = colors.fg.subtle, bg = colors.bg.secondary },
        TabLineFill = { bg = colors.bg.primary },
        TabLineSel = { fg = colors.fg.primary, bg = colors.bg.highlight },
        WinSeparator = { fg = colors.bg.highlight },
        
        -- Search
        Search = { fg = colors.bg.primary, bg = colors.yellow.primary },
        IncSearch = { fg = colors.bg.primary, bg = colors.orange.primary },
        Substitute = { fg = colors.bg.primary, bg = colors.red.primary },
        
        -- Messages
        ErrorMsg = { fg = colors.red.primary },
        WarningMsg = { fg = colors.orange.primary },
        MoreMsg = { fg = colors.green.primary },
        Question = { fg = colors.blue.primary },
        
        -- Popup menus
        Pmenu = { fg = colors.fg.primary, bg = colors.bg.float },
        PmenuSel = { fg = colors.bg.primary, bg = colors.blue.primary },
        PmenuSbar = { bg = colors.bg.highlight },
        PmenuThumb = { bg = colors.fg.subtle },
        
        -- Fold
        Folded = { fg = colors.fg.muted, bg = colors.bg.secondary },
        FoldColumn = { fg = colors.fg.subtle, bg = bg_primary },
        
        -- Diff
        DiffAdd = { fg = colors.green.primary, bg = colors.green.dark or colors.bg.highlight },
        DiffChange = { fg = colors.blue.primary, bg = colors.blue.dark or colors.bg.highlight },
        DiffDelete = { fg = colors.red.primary, bg = colors.red.dark or colors.bg.highlight },
        DiffText = { fg = colors.orange.primary, bg = colors.orange.dark or colors.bg.secondary, bold = true },
        
        -- Spelling
        SpellBad = { sp = colors.red.primary, undercurl = true },
        SpellCap = { sp = colors.orange.primary, undercurl = true },
        SpellLocal = { sp = colors.yellow.primary, undercurl = true },
        SpellRare = { sp = colors.purple.primary, undercurl = true },
        
        -- Cursor
        Cursor = { fg = colors.bg.primary, bg = colors.fg.primary },
        lCursor = { fg = colors.bg.primary, bg = colors.fg.primary },
        CursorIM = { fg = colors.bg.primary, bg = colors.fg.primary },
        TermCursor = { fg = colors.bg.primary, bg = colors.fg.primary },
        TermCursorNC = { fg = colors.bg.primary, bg = colors.fg.secondary },
        
        -- Syntax highlighting (base)
        Comment = { fg = colors.fg.subtle, italic = (config.syntax and config.syntax.italic_comments) },
        Constant = { fg = colors.orange.primary },
        String = { fg = colors.green.primary },
        Character = { fg = colors.green.primary },
        Number = { fg = colors.orange.primary },
        Boolean = { fg = colors.orange.primary },
        Float = { fg = colors.orange.primary },
        
        Identifier = { fg = colors.fg.primary },
        Function = { fg = colors.blue.primary, bold = (config.syntax and config.syntax.bold_functions) },
        
        Statement = { fg = colors.purple.primary },
        Conditional = { fg = colors.purple.primary },
        Repeat = { fg = colors.purple.primary },
        Label = { fg = colors.purple.primary },
        Operator = { fg = colors.teal.primary },
        Keyword = { fg = colors.purple.primary },
        Exception = { fg = colors.purple.primary },
        
        PreProc = { fg = colors.purple.primary },
        Include = { fg = colors.purple.primary },
        Define = { fg = colors.purple.primary },
        Macro = { fg = colors.purple.primary },
        PreCondit = { fg = colors.purple.primary },
        
        Type = { fg = colors.teal.primary },
        StorageClass = { fg = colors.teal.primary },
        Structure = { fg = colors.teal.primary },
        Typedef = { fg = colors.teal.primary },
        
        Special = { fg = colors.teal.primary },
        SpecialChar = { fg = colors.orange.primary },
        Tag = { fg = colors.blue.primary },
        Delimiter = { fg = colors.fg.muted },
        SpecialComment = { fg = colors.fg.muted },
        Debug = { fg = colors.red.primary },
        
        Underlined = { underline = true },
        Ignore = { fg = colors.fg.subtle },
        Error = { fg = colors.red.primary },
        Todo = { fg = colors.bg.primary, bg = colors.yellow.primary, bold = true },
        
        -- Diagnostics
        DiagnosticError = { fg = colors.red.primary },
        DiagnosticWarn = { fg = colors.orange.primary },
        DiagnosticInfo = { fg = colors.blue.primary },
        DiagnosticHint = { fg = colors.teal.primary },
        DiagnosticOk = { fg = colors.green.primary },
        
        DiagnosticVirtualTextError = { fg = colors.red.primary, bg = colors.red.dark or colors.bg.secondary },
        DiagnosticVirtualTextWarn = { fg = colors.orange.primary, bg = colors.orange.dark or colors.bg.secondary },
        DiagnosticVirtualTextInfo = { fg = colors.blue.primary, bg = colors.blue.dark or colors.bg.secondary },
        DiagnosticVirtualTextHint = { fg = colors.teal.primary, bg = colors.teal.dark or colors.bg.secondary },
        DiagnosticVirtualTextOk = { fg = colors.green.primary, bg = colors.green.dark or colors.bg.secondary },
        
        DiagnosticUnderlineError = { sp = colors.red.primary, undercurl = true },
        DiagnosticUnderlineWarn = { sp = colors.orange.primary, undercurl = true },
        DiagnosticUnderlineInfo = { sp = colors.blue.primary, undercurl = true },
        DiagnosticUnderlineHint = { sp = colors.teal.primary, undercurl = true },
        DiagnosticUnderlineOk = { sp = colors.green.primary, undercurl = true },
        
        -- TreeSitter
        ['@variable'] = { fg = colors.fg.primary },
        ['@variable.builtin'] = { fg = colors.red.primary },
        ['@variable.parameter'] = { fg = colors.fg.muted },
        ['@variable.member'] = { fg = colors.fg.primary },
        
        ['@constant'] = { fg = colors.orange.primary },
        ['@constant.builtin'] = { fg = colors.orange.primary },
        ['@constant.macro'] = { fg = colors.orange.primary },
        
        ['@module'] = { fg = colors.teal.primary },
        ['@module.builtin'] = { fg = colors.teal.primary },
        ['@label'] = { fg = colors.purple.primary },
        
        ['@string'] = { fg = colors.green.primary },
        ['@string.documentation'] = { fg = colors.green.primary },
        ['@string.regexp'] = { fg = colors.green.bright or colors.green.primary },
        ['@string.escape'] = { fg = colors.teal.primary },
        ['@string.special'] = { fg = colors.teal.primary },
        ['@string.special.symbol'] = { fg = colors.teal.primary },
        ['@string.special.url'] = { fg = colors.blue.primary, underline = true },
        ['@string.special.path'] = { fg = colors.green.primary, underline = true },
        
        ['@character'] = { fg = colors.green.primary },
        ['@character.special'] = { fg = colors.teal.primary },
        
        ['@boolean'] = { fg = colors.orange.primary },
        ['@number'] = { fg = colors.orange.primary },
        ['@number.float'] = { fg = colors.orange.primary },
        
        ['@type'] = { fg = colors.teal.primary },
        ['@type.builtin'] = { fg = colors.teal.primary },
        ['@type.definition'] = { fg = colors.teal.primary },
        
        ['@attribute'] = { fg = colors.purple.primary },
        ['@property'] = { fg = colors.fg.primary },
        
        ['@function'] = { fg = colors.blue.primary },
        ['@function.builtin'] = { fg = colors.blue.primary },
        ['@function.call'] = { fg = colors.blue.primary },
        ['@function.macro'] = { fg = colors.blue.primary },
        
        ['@function.method'] = { fg = colors.blue.primary },
        ['@function.method.call'] = { fg = colors.blue.primary },
        
        ['@constructor'] = { fg = colors.teal.primary },
        ['@operator'] = { fg = colors.teal.primary },
        
        ['@keyword'] = { fg = colors.purple.primary },
        ['@keyword.coroutine'] = { fg = colors.purple.primary },
        ['@keyword.function'] = { fg = colors.purple.primary },
        ['@keyword.operator'] = { fg = colors.teal.primary },
        ['@keyword.import'] = { fg = colors.purple.primary },
        ['@keyword.storage'] = { fg = colors.purple.primary },
        ['@keyword.repeat'] = { fg = colors.purple.primary },
        ['@keyword.return'] = { fg = colors.purple.primary },
        ['@keyword.debug'] = { fg = colors.red.primary },
        ['@keyword.exception'] = { fg = colors.purple.primary },
        
        ['@keyword.conditional'] = { fg = colors.purple.primary },
        ['@keyword.conditional.ternary'] = { fg = colors.teal.primary },
        
        ['@keyword.directive'] = { fg = colors.purple.primary },
        ['@keyword.directive.define'] = { fg = colors.purple.primary },
        
        ['@punctuation.delimiter'] = { fg = colors.fg.muted },
        ['@punctuation.bracket'] = { fg = colors.fg.muted },
        ['@punctuation.special'] = { fg = colors.teal.primary },
        
        ['@comment'] = { fg = colors.fg.subtle, italic = (config.syntax and config.syntax.italic_comments) },
        ['@comment.documentation'] = { fg = colors.fg.muted },
        
        ['@comment.error'] = { fg = colors.red.primary },
        ['@comment.warning'] = { fg = colors.orange.primary },
        ['@comment.todo'] = { fg = colors.yellow.primary, bold = true },
        ['@comment.note'] = { fg = colors.blue.primary },
        
        ['@markup.strong'] = { bold = true },
        ['@markup.italic'] = { italic = true },
        ['@markup.strikethrough'] = { strikethrough = true },
        ['@markup.underline'] = { underline = true },
        
        ['@markup.heading'] = { fg = colors.blue.primary, bold = true },
        ['@markup.heading.1'] = { fg = colors.blue.primary, bold = true },
        ['@markup.heading.2'] = { fg = colors.purple.primary, bold = true },
        ['@markup.heading.3'] = { fg = colors.teal.primary, bold = true },
        ['@markup.heading.4'] = { fg = colors.green.primary, bold = true },
        ['@markup.heading.5'] = { fg = colors.orange.primary, bold = true },
        ['@markup.heading.6'] = { fg = colors.red.primary, bold = true },
        
        ['@markup.quote'] = { fg = colors.fg.muted, italic = true },
        ['@markup.math'] = { fg = colors.blue.primary },
        
        ['@markup.link'] = { fg = colors.blue.primary, underline = true },
        ['@markup.link.label'] = { fg = colors.blue.primary },
        ['@markup.link.url'] = { fg = colors.teal.primary, underline = true },
        
        ['@markup.raw'] = { fg = colors.green.primary },
        ['@markup.raw.block'] = { fg = colors.green.primary },
        
        ['@markup.list'] = { fg = colors.purple.primary },
        ['@markup.list.checked'] = { fg = colors.green.primary },
        ['@markup.list.unchecked'] = { fg = colors.orange.primary },
        
        ['@diff.plus'] = { fg = colors.green.primary },
        ['@diff.minus'] = { fg = colors.red.primary },
        ['@diff.delta'] = { fg = colors.blue.primary },
        
        ['@tag'] = { fg = colors.purple.primary },
        ['@tag.attribute'] = { fg = colors.blue.primary },
        ['@tag.delimiter'] = { fg = colors.fg.muted },
    }
end

-- Get active style
function M.get_active_style()
    local config_module = require('suikimuku.core.config')
    local config = config_module.get_config()
    return config.style or 'sui'
end

-- Reload colorscheme
function M.reload()
    M.load()
end

return M