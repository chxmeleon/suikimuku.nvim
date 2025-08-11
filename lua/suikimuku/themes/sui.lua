-- 翠 (Sui) - Digital Aquarium Theme
-- Deep ocean depths with bioluminescent electric accents

local colors = require("suikimuku.core.colors")
local M = {}

-- Theme metadata
M.info = {
    name = "翠 (Sui) - Digital Aquarium",
    description = "Deep ocean depths with bioluminescent electric accents",
    philosophy = "Immersive underwater coding environment with electric blue highlights and aquatic color harmony",
    aesthetic = "underwater_digital",
    color_temperature = "cool_aquatic",
    contrast_level = "medium",
    ideal_time = "evening",
    ideal_environment = {"focused_coding", "contemplative_work", "immersive_sessions"}
}

-- Theme-specific color palette
function M.get_colors()
    return colors.get('sui', 'legacy')
end

-- Extended color families for plugin support
function M.get_extended_colors()
    return colors.get('sui', 'family')
end

-- Theme-specific highlight group overrides
function M.get_highlights(theme_colors, config)
    local highlights = {}
    
    -- Enhanced highlights for Digital Aquarium theme
    highlights.Normal = { fg = theme_colors.fg.primary, bg = theme_colors.bg.primary }
    highlights.NormalFloat = { fg = theme_colors.fg.primary, bg = theme_colors.bg.float }
    
    -- Cursor and selection - bioluminescent effects
    highlights.Cursor = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func }
    highlights.CursorLine = { bg = theme_colors.bg.secondary }
    highlights.CursorColumn = { bg = theme_colors.bg.secondary }
    highlights.Visual = { bg = theme_colors.bg.highlight }
    highlights.VisualNOS = { bg = theme_colors.bg.highlight }
    
    -- Line numbers with oceanic depth
    highlights.LineNr = { fg = theme_colors.fg.subtle }
    highlights.CursorLineNr = { fg = theme_colors.syntax.func, bold = true }
    highlights.SignColumn = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.primary }
    
    -- Search with electric highlights
    highlights.Search = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.const }
    highlights.IncSearch = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func }
    highlights.Substitute = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.special }
    
    -- Syntax highlighting - aquatic life
    highlights.Comment = { fg = theme_colors.fg.subtle, italic = true }
    highlights.Constant = { fg = theme_colors.syntax.const } -- Coral orange
    highlights.String = { fg = theme_colors.syntax.string } -- Kelp green
    highlights.Character = { fg = theme_colors.syntax.string }
    highlights.Number = { fg = theme_colors.syntax.const }
    highlights.Boolean = { fg = theme_colors.syntax.const }
    highlights.Float = { fg = theme_colors.syntax.const }
    
    highlights.Identifier = { fg = theme_colors.fg.primary }
    highlights.Function = { fg = theme_colors.syntax.func } -- Electric jellyfish
    
    highlights.Statement = { fg = theme_colors.syntax.keyword } -- Ocean mystery
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
    
    highlights.Type = { fg = theme_colors.syntax.type } -- Aqua mint
    highlights.StorageClass = { fg = theme_colors.syntax.keyword }
    highlights.Structure = { fg = theme_colors.syntax.type }
    highlights.Typedef = { fg = theme_colors.syntax.type }
    
    highlights.Special = { fg = theme_colors.syntax.special }
    highlights.SpecialChar = { fg = theme_colors.syntax.special }
    highlights.Tag = { fg = theme_colors.syntax.func }
    highlights.Delimiter = { fg = theme_colors.fg.secondary }
    highlights.SpecialComment = { fg = theme_colors.syntax.special, italic = true }
    highlights.Debug = { fg = theme_colors.diag.warn }
    
    -- UI Elements - underwater interface
    highlights.StatusLine = { fg = theme_colors.fg.primary, bg = theme_colors.bg.secondary }
    highlights.StatusLineNC = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.secondary }
    highlights.TabLine = { fg = theme_colors.fg.secondary, bg = theme_colors.bg.secondary }
    highlights.TabLineFill = { bg = theme_colors.bg.secondary }
    highlights.TabLineSel = { fg = theme_colors.fg.primary, bg = theme_colors.bg.primary }
    
    -- Popup menus - floating kelp
    highlights.Pmenu = { fg = theme_colors.fg.primary, bg = theme_colors.bg.float }
    highlights.PmenuSel = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func }
    highlights.PmenuSbar = { bg = theme_colors.bg.highlight }
    highlights.PmenuThumb = { bg = theme_colors.syntax.func }
    
    -- Diffs - underwater changes
    highlights.DiffAdd = { fg = theme_colors.syntax.string, bg = colors.manipulate('sui', 'green_primary', 'darken', 40) }
    highlights.DiffChange = { fg = theme_colors.syntax.func, bg = colors.manipulate('sui', 'blue_primary', 'darken', 40) }
    highlights.DiffDelete = { fg = theme_colors.diag.error, bg = colors.manipulate('sui', 'red_primary', 'darken', 40) }
    highlights.DiffText = { fg = theme_colors.syntax.func, bg = colors.manipulate('sui', 'blue_primary', 'darken', 30) }
    
    -- Diagnostics - ocean warnings
    highlights.DiagnosticError = { fg = theme_colors.diag.error }
    highlights.DiagnosticWarn = { fg = theme_colors.diag.warn }
    highlights.DiagnosticInfo = { fg = theme_colors.diag.info }
    highlights.DiagnosticHint = { fg = theme_colors.diag.hint }
    
    -- LSP highlights with aquatic semantics
    highlights.LspReferenceText = { bg = theme_colors.bg.highlight }
    highlights.LspReferenceRead = { bg = theme_colors.bg.highlight }
    highlights.LspReferenceWrite = { bg = theme_colors.bg.highlight, underline = true }
    
    return highlights
end

-- Theme-specific TreeSitter highlights
function M.get_treesitter_highlights(theme_colors, config)
    local highlights = {}
    
    -- TreeSitter with underwater semantics
    highlights["@variable"] = { fg = theme_colors.fg.primary }
    highlights["@variable.builtin"] = { fg = theme_colors.syntax.keyword }
    highlights["@variable.parameter"] = { fg = theme_colors.fg.secondary }
    highlights["@variable.member"] = { fg = theme_colors.syntax.type }
    
    highlights["@constant"] = { fg = theme_colors.syntax.const }
    highlights["@constant.builtin"] = { fg = theme_colors.syntax.const }
    highlights["@constant.macro"] = { fg = theme_colors.syntax.special }
    
    highlights["@module"] = { fg = theme_colors.syntax.type }
    highlights["@module.builtin"] = { fg = theme_colors.syntax.keyword }
    
    highlights["@label"] = { fg = theme_colors.syntax.keyword }
    
    highlights["@string"] = { fg = theme_colors.syntax.string }
    highlights["@string.documentation"] = { fg = theme_colors.syntax.string, italic = true }
    highlights["@string.regexp"] = { fg = theme_colors.syntax.special }
    highlights["@string.escape"] = { fg = theme_colors.syntax.special }
    highlights["@string.special"] = { fg = theme_colors.syntax.special }
    highlights["@string.special.symbol"] = { fg = theme_colors.syntax.special }
    highlights["@string.special.url"] = { fg = theme_colors.syntax.func, underline = true }
    highlights["@string.special.path"] = { fg = theme_colors.syntax.string }
    
    highlights["@character"] = { fg = theme_colors.syntax.string }
    highlights["@character.special"] = { fg = theme_colors.syntax.special }
    
    highlights["@boolean"] = { fg = theme_colors.syntax.const }
    highlights["@number"] = { fg = theme_colors.syntax.const }
    highlights["@number.float"] = { fg = theme_colors.syntax.const }
    
    highlights["@type"] = { fg = theme_colors.syntax.type }
    highlights["@type.builtin"] = { fg = theme_colors.syntax.keyword }
    highlights["@type.definition"] = { fg = theme_colors.syntax.type }
    
    highlights["@attribute"] = { fg = theme_colors.syntax.special }
    highlights["@attribute.builtin"] = { fg = theme_colors.syntax.keyword }
    highlights["@property"] = { fg = theme_colors.syntax.type }
    
    highlights["@function"] = { fg = theme_colors.syntax.func }
    highlights["@function.builtin"] = { fg = theme_colors.syntax.keyword }
    highlights["@function.call"] = { fg = theme_colors.syntax.func }
    highlights["@function.macro"] = { fg = theme_colors.syntax.special }
    
    highlights["@function.method"] = { fg = theme_colors.syntax.func }
    highlights["@function.method.call"] = { fg = theme_colors.syntax.func }
    
    highlights["@constructor"] = { fg = theme_colors.syntax.type }
    
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
    
    -- Markup (for documentation)
    highlights["@markup.strong"] = { bold = true }
    highlights["@markup.italic"] = { italic = true }
    highlights["@markup.strikethrough"] = { strikethrough = true }
    highlights["@markup.underline"] = { underline = true }
    
    highlights["@markup.heading"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@markup.heading.1"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@markup.heading.2"] = { fg = theme_colors.syntax.type, bold = true }
    highlights["@markup.heading.3"] = { fg = theme_colors.syntax.string, bold = true }
    highlights["@markup.heading.4"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@markup.heading.5"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@markup.heading.6"] = { fg = theme_colors.syntax.special, bold = true }
    
    highlights["@markup.quote"] = { fg = theme_colors.fg.muted, italic = true }
    highlights["@markup.math"] = { fg = theme_colors.syntax.special }
    
    highlights["@markup.link"] = { fg = theme_colors.syntax.func, underline = true }
    highlights["@markup.link.label"] = { fg = theme_colors.syntax.func }
    highlights["@markup.link.url"] = { fg = theme_colors.syntax.type, underline = true }
    
    highlights["@markup.raw"] = { fg = theme_colors.syntax.string }
    highlights["@markup.raw.block"] = { fg = theme_colors.syntax.string }
    
    highlights["@markup.list"] = { fg = theme_colors.syntax.special }
    highlights["@markup.list.checked"] = { fg = theme_colors.syntax.string }
    highlights["@markup.list.unchecked"] = { fg = theme_colors.fg.subtle }
    
    -- Tags (HTML/XML)
    highlights["@tag"] = { fg = theme_colors.syntax.func }
    highlights["@tag.builtin"] = { fg = theme_colors.syntax.keyword }
    highlights["@tag.attribute"] = { fg = theme_colors.syntax.type }
    highlights["@tag.delimiter"] = { fg = theme_colors.fg.secondary }
    
    return highlights
end

-- Theme-specific customization hooks
function M.on_colors(colors_table)
    -- Users can override this to customize Sui theme colors
    -- Example: colors_table.bg.primary = "#001122"
end

function M.on_highlights(highlights, colors_table)
    -- Users can override this to customize Sui theme highlights
    -- Example: highlights.Normal = { fg = "#ffffff", bg = "#000000" }
end

-- Theme validation
function M.validate()
    local issues = {}
    
    -- Check if all required colors are available
    local required_colors = {'bg_primary', 'fg_primary', 'blue_primary', 'green_primary'}
    for _, color_name in ipairs(required_colors) do
        if not colors.get('sui', 'hex', color_name) then
            table.insert(issues, "Missing required color: " .. color_name)
        end
    end
    
    return issues
end

return M