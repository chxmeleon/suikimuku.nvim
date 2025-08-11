-- 無 (Mu) - WCAG AAA Grayscale Theme
-- High-contrast monochrome with subtle gray variations

local colors = require("suikimuku.core.colors")
local M = {}

-- Theme metadata
M.info = {
    name = "無 (Mu) - WCAG AAA Grayscale",
    description = "High-contrast monochrome with subtle gray variations",
    philosophy = "Maximum readability with zero color distractions",
    aesthetic = "high_contrast_monochrome",
    color_temperature = "neutral",
    contrast_level = "maximum",
    ideal_time = "anytime",
    ideal_environment = {"accessibility_focus", "colorblind_friendly", "distraction_free"}
}

-- Theme-specific color palette
function M.get_colors()
    return colors.get('mu', 'legacy')
end

-- Extended color families for plugin support
function M.get_extended_colors()
    return colors.get('mu', 'family')
end

-- Theme-specific highlight group overrides
function M.get_highlights(theme_colors, config)
    local highlights = {}
    
    -- Enhanced highlights for WCAG AAA theme
    highlights.Normal = { fg = theme_colors.fg.primary, bg = theme_colors.bg.primary }
    highlights.NormalFloat = { fg = theme_colors.fg.primary, bg = theme_colors.bg.float }
    
    -- Cursor and selection - maximum contrast
    highlights.Cursor = { fg = theme_colors.bg.primary, bg = theme_colors.fg.primary }
    highlights.CursorLine = { bg = theme_colors.bg.secondary }
    highlights.CursorColumn = { bg = theme_colors.bg.secondary }
    highlights.Visual = { bg = theme_colors.bg.highlight }
    highlights.VisualNOS = { bg = theme_colors.bg.highlight }
    
    -- Line numbers with high contrast
    highlights.LineNr = { fg = theme_colors.fg.subtle }
    highlights.CursorLineNr = { fg = theme_colors.fg.primary, bold = true }
    highlights.SignColumn = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.primary }
    
    -- Search with maximum contrast
    highlights.Search = { fg = theme_colors.bg.primary, bg = theme_colors.fg.primary }
    highlights.IncSearch = { fg = theme_colors.bg.primary, bg = theme_colors.fg.muted, bold = true }
    highlights.Substitute = { fg = theme_colors.bg.primary, bg = theme_colors.fg.secondary }
    
    -- Syntax highlighting - grayscale hierarchy
    highlights.Comment = { fg = theme_colors.fg.subtle, italic = true }
    highlights.Constant = { fg = theme_colors.syntax.const, bold = true } -- Medium gray, bold
    highlights.String = { fg = theme_colors.syntax.string } -- Light gray
    highlights.Character = { fg = theme_colors.syntax.string }
    highlights.Number = { fg = theme_colors.syntax.const, bold = true }
    highlights.Boolean = { fg = theme_colors.syntax.const, bold = true }
    highlights.Float = { fg = theme_colors.syntax.const, bold = true }
    
    highlights.Identifier = { fg = theme_colors.fg.primary }
    highlights.Function = { fg = theme_colors.syntax.func, bold = true } -- White, bold
    
    highlights.Statement = { fg = theme_colors.syntax.keyword, bold = true } -- Gray, bold
    highlights.Conditional = { fg = theme_colors.syntax.keyword, bold = true }
    highlights.Repeat = { fg = theme_colors.syntax.keyword, bold = true }
    highlights.Label = { fg = theme_colors.syntax.keyword, bold = true }
    highlights.Operator = { fg = theme_colors.syntax.special }
    highlights.Keyword = { fg = theme_colors.syntax.keyword, bold = true }
    highlights.Exception = { fg = theme_colors.syntax.keyword, bold = true }
    
    highlights.PreProc = { fg = theme_colors.syntax.special }
    highlights.Include = { fg = theme_colors.syntax.func, bold = true }
    highlights.Define = { fg = theme_colors.syntax.keyword, bold = true }
    highlights.Macro = { fg = theme_colors.syntax.special }
    highlights.PreCondit = { fg = theme_colors.syntax.keyword, bold = true }
    
    highlights.Type = { fg = theme_colors.syntax.type, bold = true } -- Light gray, bold
    highlights.StorageClass = { fg = theme_colors.syntax.keyword, bold = true }
    highlights.Structure = { fg = theme_colors.syntax.type, bold = true }
    highlights.Typedef = { fg = theme_colors.syntax.type, bold = true }
    
    highlights.Special = { fg = theme_colors.syntax.special }
    highlights.SpecialChar = { fg = theme_colors.syntax.special }
    highlights.Tag = { fg = theme_colors.syntax.func, bold = true }
    highlights.Delimiter = { fg = theme_colors.fg.secondary }
    highlights.SpecialComment = { fg = theme_colors.syntax.special, italic = true }
    highlights.Debug = { fg = theme_colors.diag.warn, bold = true }
    
    -- UI Elements - high contrast interface
    highlights.StatusLine = { fg = theme_colors.fg.primary, bg = theme_colors.bg.secondary, bold = true }
    highlights.StatusLineNC = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.secondary }
    highlights.TabLine = { fg = theme_colors.fg.secondary, bg = theme_colors.bg.secondary }
    highlights.TabLineFill = { bg = theme_colors.bg.secondary }
    highlights.TabLineSel = { fg = theme_colors.fg.primary, bg = theme_colors.bg.primary, bold = true }
    
    -- Popup menus - maximum contrast
    highlights.Pmenu = { fg = theme_colors.fg.primary, bg = theme_colors.bg.float }
    highlights.PmenuSel = { fg = theme_colors.bg.primary, bg = theme_colors.fg.primary, bold = true }
    highlights.PmenuSbar = { bg = theme_colors.bg.highlight }
    highlights.PmenuThumb = { bg = theme_colors.fg.secondary }
    
    -- Diffs - grayscale differences (using bold/underline for distinction)
    highlights.DiffAdd = { fg = theme_colors.fg.primary, bg = theme_colors.bg.secondary, bold = true }
    highlights.DiffChange = { fg = theme_colors.fg.primary, bg = theme_colors.bg.highlight }
    highlights.DiffDelete = { fg = theme_colors.bg.primary, bg = theme_colors.fg.subtle, strikethrough = true }
    highlights.DiffText = { fg = theme_colors.fg.primary, bg = theme_colors.bg.highlight, bold = true, underline = true }
    
    -- Diagnostics - using text formatting for distinction
    highlights.DiagnosticError = { fg = theme_colors.diag.error, bold = true, underline = true }
    highlights.DiagnosticWarn = { fg = theme_colors.diag.warn, bold = true }
    highlights.DiagnosticInfo = { fg = theme_colors.diag.info }
    highlights.DiagnosticHint = { fg = theme_colors.diag.hint, italic = true }
    
    -- LSP highlights with high contrast
    highlights.LspReferenceText = { bg = theme_colors.bg.highlight }
    highlights.LspReferenceRead = { bg = theme_colors.bg.highlight, underline = true }
    highlights.LspReferenceWrite = { bg = theme_colors.bg.highlight, bold = true, underline = true }
    
    -- Error handling - maximum visibility
    highlights.Error = { fg = theme_colors.fg.primary, bg = theme_colors.bg.primary, bold = true, underline = true }
    highlights.ErrorMsg = { fg = theme_colors.fg.primary, bold = true }
    highlights.WarningMsg = { fg = theme_colors.fg.secondary, bold = true }
    
    -- Folding - clear hierarchy
    highlights.Folded = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.secondary, italic = true }
    highlights.FoldColumn = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.primary }
    
    -- Spelling - text-based indicators
    highlights.SpellBad = { underline = true, undercurl = true }
    highlights.SpellCap = { underline = true }
    highlights.SpellLocal = { underline = true }
    highlights.SpellRare = { underline = true }
    
    return highlights
end

-- Theme-specific TreeSitter highlights
function M.get_treesitter_highlights(theme_colors, config)
    local highlights = {}
    
    -- TreeSitter with accessibility focus
    highlights["@variable"] = { fg = theme_colors.fg.primary }
    highlights["@variable.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@variable.parameter"] = { fg = theme_colors.fg.secondary }
    highlights["@variable.member"] = { fg = theme_colors.syntax.type }
    
    highlights["@constant"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@constant.builtin"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@constant.macro"] = { fg = theme_colors.syntax.special }
    
    highlights["@module"] = { fg = theme_colors.syntax.type, bold = true }
    highlights["@module.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    
    highlights["@label"] = { fg = theme_colors.syntax.keyword, bold = true }
    
    highlights["@string"] = { fg = theme_colors.syntax.string }
    highlights["@string.documentation"] = { fg = theme_colors.syntax.string, italic = true }
    highlights["@string.regexp"] = { fg = theme_colors.syntax.special, bold = true }
    highlights["@string.escape"] = { fg = theme_colors.syntax.special, bold = true }
    highlights["@string.special"] = { fg = theme_colors.syntax.special }
    highlights["@string.special.symbol"] = { fg = theme_colors.syntax.special }
    highlights["@string.special.url"] = { fg = theme_colors.syntax.func, underline = true, bold = true }
    highlights["@string.special.path"] = { fg = theme_colors.syntax.string }
    
    highlights["@character"] = { fg = theme_colors.syntax.string }
    highlights["@character.special"] = { fg = theme_colors.syntax.special }
    
    highlights["@boolean"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@number"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@number.float"] = { fg = theme_colors.syntax.const, bold = true }
    
    highlights["@type"] = { fg = theme_colors.syntax.type, bold = true }
    highlights["@type.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@type.definition"] = { fg = theme_colors.syntax.type, bold = true }
    
    highlights["@attribute"] = { fg = theme_colors.syntax.special }
    highlights["@attribute.builtin"] = { fg = theme_colors.syntax.keyword }
    highlights["@property"] = { fg = theme_colors.syntax.type }
    
    highlights["@function"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@function.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@function.call"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@function.macro"] = { fg = theme_colors.syntax.special }
    
    highlights["@function.method"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@function.method.call"] = { fg = theme_colors.syntax.func, bold = true }
    
    highlights["@constructor"] = { fg = theme_colors.syntax.type, bold = true }
    
    highlights["@operator"] = { fg = theme_colors.syntax.special }
    
    highlights["@keyword"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@keyword.coroutine"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@keyword.function"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@keyword.operator"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@keyword.import"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@keyword.repeat"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@keyword.return"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@keyword.debug"] = { fg = theme_colors.diag.warn, bold = true }
    highlights["@keyword.exception"] = { fg = theme_colors.diag.error, bold = true }
    
    highlights["@keyword.conditional"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@keyword.conditional.ternary"] = { fg = theme_colors.syntax.keyword, bold = true }
    
    highlights["@keyword.directive"] = { fg = theme_colors.syntax.special }
    highlights["@keyword.directive.define"] = { fg = theme_colors.syntax.keyword, bold = true }
    
    highlights["@punctuation.delimiter"] = { fg = theme_colors.fg.secondary }
    highlights["@punctuation.bracket"] = { fg = theme_colors.fg.secondary }
    highlights["@punctuation.special"] = { fg = theme_colors.syntax.special }
    
    highlights["@comment"] = { fg = theme_colors.fg.subtle, italic = true }
    highlights["@comment.documentation"] = { fg = theme_colors.fg.subtle, italic = true }
    
    highlights["@comment.error"] = { fg = theme_colors.diag.error, bold = true }
    highlights["@comment.warning"] = { fg = theme_colors.diag.warn, bold = true }
    highlights["@comment.todo"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@comment.note"] = { fg = theme_colors.diag.info, bold = true }
    
    -- Markup with accessibility focus
    highlights["@markup.strong"] = { bold = true }
    highlights["@markup.italic"] = { italic = true }
    highlights["@markup.strikethrough"] = { strikethrough = true }
    highlights["@markup.underline"] = { underline = true }
    
    highlights["@markup.heading"] = { fg = theme_colors.fg.primary, bold = true }
    highlights["@markup.heading.1"] = { fg = theme_colors.fg.primary, bold = true, underline = true }
    highlights["@markup.heading.2"] = { fg = theme_colors.fg.primary, bold = true }
    highlights["@markup.heading.3"] = { fg = theme_colors.fg.secondary, bold = true }
    highlights["@markup.heading.4"] = { fg = theme_colors.fg.secondary, bold = true }
    highlights["@markup.heading.5"] = { fg = theme_colors.fg.subtle, bold = true }
    highlights["@markup.heading.6"] = { fg = theme_colors.fg.subtle, bold = true }
    
    highlights["@markup.quote"] = { fg = theme_colors.fg.muted, italic = true }
    highlights["@markup.math"] = { fg = theme_colors.syntax.special }
    
    highlights["@markup.link"] = { fg = theme_colors.syntax.func, underline = true, bold = true }
    highlights["@markup.link.label"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@markup.link.url"] = { fg = theme_colors.syntax.type, underline = true }
    
    highlights["@markup.raw"] = { fg = theme_colors.syntax.string }
    highlights["@markup.raw.block"] = { fg = theme_colors.syntax.string }
    
    highlights["@markup.list"] = { fg = theme_colors.syntax.special }
    highlights["@markup.list.checked"] = { fg = theme_colors.syntax.string, bold = true }
    highlights["@markup.list.unchecked"] = { fg = theme_colors.fg.subtle }
    
    return highlights
end

-- WCAG AAA compliance validation
function M.validate_accessibility()
    local issues = {}
    local warnings = {}
    
    -- Check contrast ratios (simplified check)
    local theme_colors = colors.get('mu', 'legacy')
    
    -- All foreground colors should be high contrast against background
    local bg_luminance = M.get_relative_luminance(theme_colors.bg.primary)
    
    for category, color_group in pairs(theme_colors) do
        if type(color_group) == "table" then
            for name, color in pairs(color_group) do
                local fg_luminance = M.get_relative_luminance(color)
                local contrast_ratio = M.calculate_contrast_ratio(bg_luminance, fg_luminance)
                
                if contrast_ratio < 7 then -- WCAG AAA requires 7:1
                    table.insert(issues, string.format("Low contrast: %s.%s (%.1f:1)", category, name, contrast_ratio))
                elseif contrast_ratio < 4.5 then -- WCAG AA minimum
                    table.insert(warnings, string.format("Below AAA standard: %s.%s (%.1f:1)", category, name, contrast_ratio))
                end
            end
        end
    end
    
    return {
        issues = issues,
        warnings = warnings,
        wcag_aaa_compliant = #issues == 0
    }
end

-- Helper function to calculate relative luminance
function M.get_relative_luminance(hex_color)
    -- Convert hex to RGB
    local r = tonumber(hex_color:sub(2, 3), 16) / 255
    local g = tonumber(hex_color:sub(4, 5), 16) / 255
    local b = tonumber(hex_color:sub(6, 7), 16) / 255
    
    -- Apply sRGB gamma correction
    local function gamma_correct(c)
        if c <= 0.03928 then
            return c / 12.92
        else
            return math.pow((c + 0.055) / 1.055, 2.4)
        end
    end
    
    r = gamma_correct(r)
    g = gamma_correct(g)
    b = gamma_correct(b)
    
    -- Calculate relative luminance
    return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

-- Helper function to calculate contrast ratio
function M.calculate_contrast_ratio(l1, l2)
    local lighter = math.max(l1, l2)
    local darker = math.min(l1, l2)
    return (lighter + 0.05) / (darker + 0.05)
end

-- Theme-specific customization hooks
function M.on_colors(colors_table)
    -- Users can override this to customize Mu theme colors
    -- Note: Customizations should maintain WCAG AAA compliance
end

function M.on_highlights(highlights, colors_table)
    -- Users can override this to customize Mu theme highlights
    -- Note: Should preserve accessibility features
end

-- Theme validation
function M.validate()
    local issues = {}
    
    -- Check if all required colors are available
    local required_colors = {'bg_primary', 'fg_primary'}
    for _, color_name in ipairs(required_colors) do
        if not colors.get('mu', 'hex', color_name) then
            table.insert(issues, "Missing required color: " .. color_name)
        end
    end
    
    -- Add accessibility validation
    local accessibility = M.validate_accessibility()
    for _, issue in ipairs(accessibility.issues) do
        table.insert(issues, issue)
    end
    
    return issues
end

return M