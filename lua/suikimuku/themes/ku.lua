-- 空 (Ku) - Enhanced Vibrant Terminal Theme
-- Electric cyberpunk with high-saturation neon colors

local colors = require("suikimuku.core.colors")
local M = {}

-- Theme metadata
M.info = {
    name = "空 (Ku) - Enhanced Vibrant Terminal",
    description = "Electric cyberpunk with high-saturation neon colors",
    philosophy = "Deep space with electric neon highlights, cyberpunk terminal harmony",
    aesthetic = "cyberpunk_electric",
    color_temperature = "varied_electric",
    contrast_level = "high",
    ideal_time = "night",
    ideal_environment = {"terminal_workflows", "coding_sessions", "cyberpunk_aesthetics"}
}

-- Theme-specific color palette
function M.get_colors()
    return colors.get('ku', 'legacy')
end

-- Extended color families for plugin support  
function M.get_extended_colors()
    return colors.get('ku', 'family')
end

-- Theme-specific highlight group overrides
function M.get_highlights(theme_colors, config)
    local highlights = {}
    
    -- Enhanced highlights for Vibrant Terminal theme
    highlights.Normal = { fg = theme_colors.fg.primary, bg = theme_colors.bg.primary }
    highlights.NormalFloat = { fg = theme_colors.fg.primary, bg = theme_colors.bg.float }
    
    -- Cursor and selection - electric highlights
    highlights.Cursor = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func }
    highlights.CursorLine = { bg = theme_colors.bg.secondary }
    highlights.CursorColumn = { bg = theme_colors.bg.secondary }
    highlights.Visual = { bg = theme_colors.bg.highlight }
    highlights.VisualNOS = { bg = theme_colors.bg.highlight }
    
    -- Line numbers with neon glow effect
    highlights.LineNr = { fg = theme_colors.fg.subtle }
    highlights.CursorLineNr = { fg = theme_colors.syntax.func, bold = true }
    highlights.SignColumn = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.primary }
    
    -- Search with electric highlights
    highlights.Search = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.const }
    highlights.IncSearch = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func, bold = true }
    highlights.Substitute = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.special }
    
    -- Syntax highlighting - cyberpunk elements
    highlights.Comment = { fg = theme_colors.fg.subtle, italic = true }
    highlights.Constant = { fg = theme_colors.syntax.const, bold = true } -- Electric orange
    highlights.String = { fg = theme_colors.syntax.string } -- Electric green
    highlights.Character = { fg = theme_colors.syntax.string }
    highlights.Number = { fg = theme_colors.syntax.const, bold = true }
    highlights.Boolean = { fg = theme_colors.syntax.const, bold = true }
    highlights.Float = { fg = theme_colors.syntax.const }
    
    highlights.Identifier = { fg = theme_colors.fg.primary }
    highlights.Function = { fg = theme_colors.syntax.func, bold = true } -- Electric cyan
    
    highlights.Statement = { fg = theme_colors.syntax.keyword, bold = true } -- Neon purple
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
    
    highlights.Type = { fg = theme_colors.syntax.type, bold = true } -- Cyber teal
    highlights.StorageClass = { fg = theme_colors.syntax.keyword, bold = true }
    highlights.Structure = { fg = theme_colors.syntax.type, bold = true }
    highlights.Typedef = { fg = theme_colors.syntax.type, bold = true }
    
    highlights.Special = { fg = theme_colors.syntax.special }
    highlights.SpecialChar = { fg = theme_colors.syntax.special }
    highlights.Tag = { fg = theme_colors.syntax.func, bold = true }
    highlights.Delimiter = { fg = theme_colors.fg.secondary }
    highlights.SpecialComment = { fg = theme_colors.syntax.special, italic = true }
    highlights.Debug = { fg = theme_colors.diag.warn, bold = true }
    
    -- UI Elements - cyberpunk interface
    highlights.StatusLine = { fg = theme_colors.fg.primary, bg = theme_colors.bg.secondary, bold = true }
    highlights.StatusLineNC = { fg = theme_colors.fg.subtle, bg = theme_colors.bg.secondary }
    highlights.TabLine = { fg = theme_colors.fg.secondary, bg = theme_colors.bg.secondary }
    highlights.TabLineFill = { bg = theme_colors.bg.secondary }
    highlights.TabLineSel = { fg = theme_colors.syntax.func, bg = theme_colors.bg.primary, bold = true }
    
    -- Popup menus - neon interface
    highlights.Pmenu = { fg = theme_colors.fg.primary, bg = theme_colors.bg.float }
    highlights.PmenuSel = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func, bold = true }
    highlights.PmenuSbar = { bg = theme_colors.bg.highlight }
    highlights.PmenuThumb = { bg = theme_colors.syntax.func }
    
    -- Diffs - electric changes
    highlights.DiffAdd = { fg = theme_colors.syntax.string, bg = colors.manipulate('ku', 'green_primary', 'darken', 30), bold = true }
    highlights.DiffChange = { fg = theme_colors.syntax.func, bg = colors.manipulate('ku', 'blue_primary', 'darken', 30) }
    highlights.DiffDelete = { fg = theme_colors.diag.error, bg = colors.manipulate('ku', 'red_primary', 'darken', 30) }
    highlights.DiffText = { fg = theme_colors.syntax.func, bg = colors.manipulate('ku', 'blue_primary', 'darken', 20), bold = true }
    
    -- Diagnostics - neon warnings
    highlights.DiagnosticError = { fg = theme_colors.diag.error, bold = true }
    highlights.DiagnosticWarn = { fg = theme_colors.diag.warn, bold = true }
    highlights.DiagnosticInfo = { fg = theme_colors.diag.info }
    highlights.DiagnosticHint = { fg = theme_colors.diag.hint }
    
    -- LSP highlights with electric effects
    highlights.LspReferenceText = { bg = theme_colors.bg.highlight }
    highlights.LspReferenceRead = { bg = theme_colors.bg.highlight }
    highlights.LspReferenceWrite = { bg = theme_colors.bg.highlight, underline = true, bold = true }
    
    -- Terminal-specific enhancements
    highlights.Terminal = { fg = theme_colors.fg.primary, bg = theme_colors.bg.primary }
    highlights.TermCursor = { fg = theme_colors.bg.primary, bg = theme_colors.syntax.func }
    highlights.TermCursorNC = { fg = theme_colors.bg.primary, bg = theme_colors.fg.subtle }
    
    -- Enhanced error visibility
    highlights.Error = { fg = theme_colors.diag.error, bold = true, underline = true }
    highlights.ErrorMsg = { fg = theme_colors.diag.error, bold = true }
    highlights.WarningMsg = { fg = theme_colors.diag.warn, bold = true }
    
    -- Match parentheses with electric highlight
    highlights.MatchParen = { fg = theme_colors.syntax.func, bg = theme_colors.bg.highlight, bold = true }
    
    return highlights
end

-- Theme-specific TreeSitter highlights
function M.get_treesitter_highlights(theme_colors, config)
    local highlights = {}
    
    -- TreeSitter with cyberpunk semantics
    highlights["@variable"] = { fg = theme_colors.fg.primary }
    highlights["@variable.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@variable.parameter"] = { fg = theme_colors.fg.secondary }
    highlights["@variable.member"] = { fg = theme_colors.syntax.type }
    
    highlights["@constant"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@constant.builtin"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@constant.macro"] = { fg = theme_colors.syntax.special, bold = true }
    
    highlights["@module"] = { fg = theme_colors.syntax.type, bold = true }
    highlights["@module.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    
    highlights["@label"] = { fg = theme_colors.syntax.keyword, bold = true }
    
    highlights["@string"] = { fg = theme_colors.syntax.string }
    highlights["@string.documentation"] = { fg = theme_colors.syntax.string, italic = true }
    highlights["@string.regexp"] = { fg = theme_colors.syntax.special, bold = true }
    highlights["@string.escape"] = { fg = theme_colors.syntax.special, bold = true }
    highlights["@string.special"] = { fg = theme_colors.syntax.special }
    highlights["@string.special.symbol"] = { fg = theme_colors.syntax.special, bold = true }
    highlights["@string.special.url"] = { fg = theme_colors.syntax.func, underline = true, bold = true }
    highlights["@string.special.path"] = { fg = theme_colors.syntax.string }
    
    highlights["@character"] = { fg = theme_colors.syntax.string }
    highlights["@character.special"] = { fg = theme_colors.syntax.special, bold = true }
    
    highlights["@boolean"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@number"] = { fg = theme_colors.syntax.const, bold = true }
    highlights["@number.float"] = { fg = theme_colors.syntax.const }
    
    highlights["@type"] = { fg = theme_colors.syntax.type, bold = true }
    highlights["@type.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@type.definition"] = { fg = theme_colors.syntax.type, bold = true }
    
    highlights["@attribute"] = { fg = theme_colors.syntax.special }
    highlights["@attribute.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@property"] = { fg = theme_colors.syntax.type }
    
    highlights["@function"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@function.builtin"] = { fg = theme_colors.syntax.keyword, bold = true }
    highlights["@function.call"] = { fg = theme_colors.syntax.func, bold = true }
    highlights["@function.macro"] = { fg = theme_colors.syntax.special, bold = true }
    
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
    
    highlights["@keyword.directive"] = { fg = theme_colors.syntax.special, bold = true }
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
    
    -- Markup with cyberpunk styling
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

-- Terminal color integration
function M.get_terminal_colors()
    local theme_colors = colors.get('ku', 'legacy')
    
    return {
        terminal_color_0 = theme_colors.bg.primary,        -- black
        terminal_color_1 = theme_colors.diag.error,        -- red
        terminal_color_2 = theme_colors.syntax.string,     -- green
        terminal_color_3 = theme_colors.syntax.const,      -- yellow
        terminal_color_4 = theme_colors.syntax.func,       -- blue
        terminal_color_5 = theme_colors.syntax.keyword,    -- magenta
        terminal_color_6 = theme_colors.syntax.type,       -- cyan
        terminal_color_7 = theme_colors.fg.primary,        -- white
        terminal_color_8 = theme_colors.bg.highlight,      -- bright black
        terminal_color_9 = colors.manipulate('ku', 'red_primary', 'lighten', 20),    -- bright red
        terminal_color_10 = colors.manipulate('ku', 'green_primary', 'lighten', 20), -- bright green
        terminal_color_11 = colors.manipulate('ku', 'orange_primary', 'lighten', 20), -- bright yellow
        terminal_color_12 = colors.manipulate('ku', 'blue_primary', 'lighten', 20),  -- bright blue
        terminal_color_13 = colors.manipulate('ku', 'purple_primary', 'lighten', 20), -- bright magenta
        terminal_color_14 = colors.manipulate('ku', 'teal_primary', 'lighten', 20),  -- bright cyan
        terminal_color_15 = theme_colors.fg.muted,         -- bright white
    }
end

-- Electric glow effects for special elements
function M.add_glow_effects(highlights)
    -- Add subtle glow effects using background colors
    local glow_bg = colors.manipulate('ku', 'bg_primary', 'lighten', 5)
    
    highlights.CursorLine.bg = glow_bg
    highlights.Search.bg = colors.manipulate('ku', 'orange_primary', 'saturate', 20)
    highlights.IncSearch.bg = colors.manipulate('ku', 'blue_primary', 'saturate', 20)
    
    return highlights
end

-- Theme-specific customization hooks
function M.on_colors(colors_table)
    -- Users can override this to customize Ku theme colors
end

function M.on_highlights(highlights, colors_table)
    -- Users can override this to customize Ku theme highlights
    -- Add glow effects if desired
    highlights = M.add_glow_effects(highlights)
end

-- Terminal environment detection
function M.detect_terminal()
    local terminal_info = {
        name = vim.env.TERM_PROGRAM or vim.env.TERM or "unknown",
        version = vim.env.TERM_PROGRAM_VERSION,
        supports_true_color = vim.fn.has("termguicolors") == 1,
        tmux = vim.env.TMUX ~= nil,
        ssh = vim.env.SSH_TTY ~= nil
    }
    
    return terminal_info
end

-- Optimize for terminal environment
function M.optimize_for_terminal()
    local terminal = M.detect_terminal()
    local optimizations = {}
    
    if terminal.name:lower():find("kitty") then
        optimizations.enhanced_cursor = true
        optimizations.bright_colors = true
    elseif terminal.name:lower():find("alacritty") then
        optimizations.performance_mode = true
        optimizations.reduced_transparency = true
    elseif terminal.name:lower():find("wezterm") then
        optimizations.full_features = true
        optimizations.ligatures = true
    end
    
    if terminal.tmux then
        optimizations.tmux_compatibility = true
        optimizations.reduced_effects = true
    end
    
    if terminal.ssh then
        optimizations.network_optimized = true
        optimizations.minimal_effects = true
    end
    
    return optimizations
end

-- Theme validation
function M.validate()
    local issues = {}
    
    -- Check if all required colors are available
    local required_colors = {'bg_primary', 'fg_primary', 'blue_primary', 'green_primary'}
    for _, color_name in ipairs(required_colors) do
        if not colors.get('ku', 'hex', color_name) then
            table.insert(issues, "Missing required color: " .. color_name)
        end
    end
    
    -- Check terminal compatibility
    local terminal = M.detect_terminal()
    if not terminal.supports_true_color then
        table.insert(issues, "Terminal does not support true colors - theme may not display correctly")
    end
    
    return issues
end

return M