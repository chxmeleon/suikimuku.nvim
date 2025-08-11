-- 輝 (Ki) - Crystal Radiant Light Theme  
-- Pure crystal clarity with cool luminous highlights

local colors = require("suikimuku.core.colors")
local M = {}

-- Theme metadata
M.info = {
    name = "輝 (Ki) - Crystal Radiant Light",
    description = "Pure crystal clarity with cool luminous highlights",
    philosophy = "Morning light through crystal, maximum clarity with gentle warmth",
    aesthetic = "crystalline_light",
    color_temperature = "cool_luminous",
    contrast_level = "high",
    ideal_time = "daytime",
    ideal_environment = {"bright_rooms", "focused_work", "minimal_distractions"}
}

-- Theme-specific color palette
function M.get_colors()
    return colors.get('ki', 'legacy')
end

-- Extended color families for plugin support
function M.get_extended_colors()
    return colors.get('ki', 'family')
end

-- Theme-specific highlight group overrides
function M.get_highlights(theme_colors, config)
    local highlights = {}
    
    -- Enhanced highlights for Crystal Light theme
    highlights.Normal = { fg = theme_colors.fg.primary, bg = theme_colors.bg.primary }
    highlights.NormalFloat = { fg = theme_colors.fg.primary, bg = theme_colors.bg.float }
    
    -- Cursor and selection - crystal clarity
    highlights.Cursor = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func }
    highlights.CursorLine = { bg = theme_colors.bg.secondary }
    highlights.CursorColumn = { bg = theme_colors.bg.secondary }
    highlights.Visual = { bg = theme_colors.bg.highlight }
    highlights.VisualNOS = { bg = theme_colors.bg.highlight }
    
    -- Line numbers with crystal precision
    highlights.LineNr = { fg = theme_colors.fg.subtle }
    highlights.CursorLineNr = { fg = theme_colors.syntax.func, bold = true }
    highlights.SignColumn = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.primary }
    
    -- Search with luminous highlights
    highlights.Search = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.const }
    highlights.IncSearch = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func }
    highlights.Substitute = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.special }
    
    -- Syntax highlighting - crystal elements
    highlights.Comment = { fg = theme_colors.fg.subtle, italic = true }
    highlights.Constant = { fg = theme_colors.syntax.const } -- Crystal orange
    highlights.String = { fg = theme_colors.syntax.string } -- Crystal green
    highlights.Character = { fg = theme_colors.syntax.string }
    highlights.Number = { fg = theme_colors.syntax.const }
    highlights.Boolean = { fg = theme_colors.syntax.const }
    highlights.Float = { fg = theme_colors.syntax.const }
    
    highlights.Identifier = { fg = theme_colors.fg.primary }
    highlights.Function = { fg = theme_colors.syntax.func } -- Crystal blue
    
    highlights.Statement = { fg = theme_colors.syntax.keyword } -- Crystal purple
    highlights.Conditional = { fg = theme_colors.syntax.keyword }
    highlights.Repeat = { fg = theme_colors.syntax.keyword }
    highlights.Label = { fg = theme_colors.syntax.keyword }
    highlights.Operator = { fg = theme_colors.syntax.special }
    highlights.Keyword = { fg = theme_colors.syntax.keyword }
    highlights.Exception = { fg = theme_colors.syntax.keyword }
    
    highlights.PreProc = { fg = theme_colors.syntax.special }
    highlights.Include = { fg = theme_colors.syntax.func }
    highlights.Define = { fg = theme_colors.syntax.keyword }
    highlights.Macro = { fg = theme_colors.syntax.special }
    highlights.PreCondit = { fg = theme_colors.syntax.keyword }
    
    highlights.Type = { fg = theme_colors.syntax.type } -- Crystal teal
    highlights.StorageClass = { fg = theme_colors.syntax.keyword }
    highlights.Structure = { fg = theme_colors.syntax.type }
    highlights.Typedef = { fg = theme_colors.syntax.type }
    
    highlights.Special = { fg = theme_colors.syntax.special }
    highlights.SpecialChar = { fg = theme_colors.syntax.special }
    highlights.Tag = { fg = theme_colors.syntax.func }
    highlights.Delimiter = { fg = theme_colors.fg.secondary }
    highlights.SpecialComment = { fg = theme_colors.syntax.special, italic = true }
    highlights.Debug = { fg = theme_colors.diag.warn }
    
    -- UI Elements - crystal interface
    highlights.StatusLine = { fg = theme_colors.fg.primary, bg = theme_colors.bg.secondary }
    highlights.StatusLineNC = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.secondary }
    highlights.TabLine = { fg = theme_colors.fg.secondary, bg = theme_colors.bg.secondary }
    highlights.TabLineFill = { bg = theme_colors.bg.secondary }
    highlights.TabLineSel = { fg = theme_colors.fg.primary, bg = theme_colors.bg.primary, bold = true }
    
    -- Popup menus - crystalline clarity
    highlights.Pmenu = { fg = theme_colors.fg.primary, bg = theme_colors.bg.float }
    highlights.PmenuSel = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func }
    highlights.PmenuSbar = { bg = theme_colors.bg.highlight }
    highlights.PmenuThumb = { bg = theme_colors.syntax.func }
    
    -- Diffs - crystal changes
    highlights.DiffAdd = { fg = theme_colors.syntax.string, bg = colors.manipulate('ki', 'green_primary', 'lighten', 30) }
    highlights.DiffChange = { fg = theme_colors.syntax.func, bg = colors.manipulate('ki', 'blue_primary', 'lighten', 30) }
    highlights.DiffDelete = { fg = theme_colors.diag.error, bg = colors.manipulate('ki', 'red_primary', 'lighten', 30) }
    highlights.DiffText = { fg = theme_colors.syntax.func, bg = colors.manipulate('ki', 'blue_primary', 'lighten', 20) }
    
    -- Diagnostics - crystal warnings
    highlights.DiagnosticError = { fg = theme_colors.diag.error }
    highlights.DiagnosticWarn = { fg = theme_colors.diag.warn }
    highlights.DiagnosticInfo = { fg = theme_colors.diag.info }
    highlights.DiagnosticHint = { fg = theme_colors.diag.hint }
    
    -- LSP highlights with crystalline clarity
    highlights.LspReferenceText = { bg = theme_colors.bg.highlight }
    highlights.LspReferenceRead = { bg = theme_colors.bg.highlight }
    highlights.LspReferenceWrite = { bg = theme_colors.bg.highlight, underline = true }
    
    return highlights
end

-- Theme-specific TreeSitter highlights
function M.get_treesitter_highlights(theme_colors, config)
    local highlights = {}
    
    -- TreeSitter with crystal semantics
    highlights["@variable"] = { fg = theme_colors.fg.primary }
    highlights["@variable.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@variable.parameter"] = { fg = theme_colors.fg.secondary }
    highlights["@variable.member"] = { fg = theme_colors.syntax.type }
    
    highlights["@constant"] = { fg = theme_colors.syntax.const }
    highlights["@constant.builtin"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@constant.macro"] = { fg = theme_colors.syntax.special }
    
    highlights["@module"] = { fg = theme_colors.syntax.type }
    highlights["@module.builtin"] = { fg = theme_colors.syntax.keyword }
    
    highlights["@label"] = { fg = theme_colors.syntax.keyword }
    
    highlights["@string"] = { fg = theme_colors.syntax.string }
    highlights["@string.documentation"] = { fg = theme_colors.syntax.string, italic = true }
    highlights["@string.regexp"] = { fg = theme_colors.syntax.special }
    highlights["@string.escape"] = { fg = theme_colors.syntax.special, bold = true }
    highlights["@string.special"] = { fg = theme_colors.syntax.special }
    highlights["@string.special.symbol"] = { fg = theme_colors.syntax.special }
    highlights["@string.special.url"] = { fg = theme_colors.syntax.func, underline = true }
    highlights["@string.special.path"] = { fg = theme_colors.syntax.string }
    
    highlights["@character"] = { fg = theme_colors.syntax.string }
    highlights["@character.special"] = { fg = theme_colors.syntax.special }
    
    highlights["@boolean"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@number"] = { fg = theme_colors.syntax.const }
    highlights["@number.float"] = { fg = theme_colors.syntax.const }
    
    highlights["@type"] = { fg = theme_colors.syntax.type }
    highlights["@type.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@type.definition"] = { fg = theme_colors.syntax.type, bold = true }
    
    highlights["@attribute"] = { fg = theme_colors.syntax.special }
    highlights["@attribute.builtin"] = { fg = theme_colors.syntax.keyword }
    highlights["@property"] = { fg = theme_colors.syntax.type }
    
    highlights["@function"] = { fg = theme_colors.syntax.func }
    highlights["@function.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@function.call"] = { fg = theme_colors.syntax.func }
    highlights["@function.macro"] = { fg = theme_colors.syntax.special }
    
    highlights["@function.method"] = { fg = theme_colors.syntax.func }
    highlights["@function.method.call"] = { fg = theme_colors.syntax.func }
    
    highlights["@constructor"] = { fg = theme_colors.syntax.type, bold = true }
    
    highlights["@operator"] = { fg = theme_colors.syntax.special }
    
    highlights["@keyword"] = { fg = theme_colors.syntax.keyword }
    highlights["@keyword.coroutine"] = { fg = theme_colors.syntax.keyword }
    highlights["@keyword.function"] = { fg = theme_colors.syntax.keyword }
    highlights["@keyword.operator"] = { fg = theme_colors.syntax.keyword }
    highlights["@keyword.import"] = { fg = theme_colors.syntax.func }
    highlights["@keyword.repeat"] = { fg = theme_colors.syntax.keyword }
    highlights["@keyword.return"] = { fg = theme_colors.syntax.keyword }
    highlights["@keyword.debug"] = { fg = theme_colors.diag.warn }
    highlights["@keyword.exception"] = { fg = theme_colors.diag.error }
    
    highlights["@keyword.conditional"] = { fg = theme_colors.syntax.keyword }
    highlights["@keyword.conditional.ternary"] = { fg = theme_colors.syntax.keyword }
    
    highlights["@keyword.directive"] = { fg = theme_colors.syntax.special }
    highlights["@keyword.directive.define"] = { fg = theme_colors.syntax.keyword }
    
    highlights["@punctuation.delimiter"] = { fg = theme_colors.fg.secondary }
    highlights["@punctuation.bracket"] = { fg = theme_colors.fg.secondary }
    highlights["@punctuation.special"] = { fg = theme_colors.syntax.special }
    
    highlights["@comment"] = { fg = theme_colors.fg.subtle, italic = true }
    highlights["@comment.documentation"] = { fg = theme_colors.fg.subtle, italic = true }
    
    highlights["@comment.error"] = { fg = theme_colors.diag.error, bold = true }
    highlights["@comment.warning"] = { fg = theme_colors.diag.warn, bold = true }
    highlights["@comment.todo"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@comment.note"] = { fg = theme_colors.diag.info, bold = true }
    
    return highlights
end

-- Theme-specific customization hooks
function M.on_colors(colors_table)
    -- Users can override this to customize Ki theme colors
end

function M.on_highlights(highlights, colors_table)
    -- Users can override this to customize Ki theme highlights
end

-- Theme validation
function M.validate()
    local issues = {}
    
    -- Check if all required colors are available
    local required_colors = {'bg_primary', 'fg_primary', 'blue_primary', 'green_primary'}
    for _, color_name in ipairs(required_colors) do
        if not colors.get('ki', 'hex', color_name) then
            table.insert(issues, "Missing required color: " .. color_name)
        end
    end
    
    return issues
end

return M