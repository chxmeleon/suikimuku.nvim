-- 輝 (Ki) - Crystal Light
-- Clean, crisp light mode for focused work with radiant precision
-- SOLID BACKGROUND: Crystal clarity requires pristine white foundation

-- Removed OKLCH dependency - using direct hex colors for simplicity and accuracy

local M = {}

-- Theme transparency philosophy
M.default_transparent = false  -- Ki always needs solid background for crystal clarity

-- Direct hex color palette for Crystal Light theme (from extended-preview.html Ki theme)
M.colors = {
	-- Background colors - Crystal clarity (exact colors from extended-preview.html)
	bg_primary = '#FAFCFF',        -- Pure crystal white
	bg_secondary = '#F0F9FF',      -- Light crystal
	bg_float = '#E1F5FE',          -- Floating crystal
	bg_highlight = '#CBD5E1',      -- Selection crystal
	
	-- Foreground colors - Sharp definition (exact colors from extended-preview.html)
	fg_primary = '#475569',        -- Deep slate primary
	fg_secondary = '#64748B',      -- Slate secondary
	fg_muted = '#94A3B8',          -- Light muted
	fg_subtle = '#CBD5E1',         -- Subtle gray
	
	-- Syntax colors - Radiant spectrum (exact colors from extended-preview.html)
	func = '#3B82F6',              -- Bright blue functions (blue-primary)
	keyword = '#8B5CF6',           -- Purple keywords (purple-primary)
	string = '#10B981',            -- Emerald strings (green-primary)
	type = '#06B6D4',              -- Cyan types (teal-primary)
	const = '#F97316',             -- Orange constants (orange-primary)
	special = '#475569',           -- Cool gray operators (fg-primary)
	
	-- Diagnostic colors - Clear warnings (exact colors from extended-preview.html)
	error = '#E11D48',             -- Rose red (red-primary)
	warn = '#F97316',              -- Orange (orange-primary)
	info = '#3B82F6',              -- Bright blue (blue-primary, same as func)
	hint = '#10B981',              -- Emerald (green-primary, same as string)
}

-- Smart transparency resolution
local function resolve_transparency(config)
	-- User explicit choice overrides theme default
	if config.transparent ~= nil then
		return config.transparent
	else
		return M.default_transparent
	end
end

-- Highlight groups with crystal clarity
function M.highlights(colors, config)
	-- Resolve transparency (Ki philosophy: always solid for crystal clarity)
	local use_transparent = resolve_transparency(config)
	local transparent_bg = use_transparent and 'NONE' or colors.bg_primary
	local transparent_float = use_transparent and 'NONE' or colors.bg_float
	
	return {
		-- Editor base
		Normal = { fg = colors.fg_primary, bg = transparent_bg },
		NormalFloat = { fg = colors.fg_primary, bg = transparent_float },
		NormalNC = { fg = colors.fg_secondary, bg = transparent_bg },
		
		-- Cursor and selection - radiant precision
		Cursor = { fg = colors.bg_primary, bg = colors.func },
		CursorLine = { bg = colors.bg_secondary },
		CursorColumn = { bg = colors.bg_secondary },
		CursorLineNr = { fg = colors.func, bold = true },
		LineNr = { fg = colors.fg_subtle },
		SignColumn = { bg = transparent_bg },
		ColorColumn = { bg = colors.bg_secondary },
		
		-- Visual selection
		Visual = { bg = colors.bg_highlight },
		VisualNOS = { bg = colors.bg_highlight },
		
		-- Search - crystal highlights
		Search = { fg = colors.bg_primary, bg = colors.const },
		IncSearch = { fg = colors.bg_primary, bg = colors.func },
		Substitute = { fg = colors.bg_primary, bg = colors.special },
		
		-- Window elements
		StatusLine = { fg = colors.fg_primary, bg = colors.bg_secondary },
		StatusLineNC = { fg = colors.fg_subtle, bg = colors.bg_secondary },
		TabLine = { fg = colors.fg_secondary, bg = colors.bg_secondary },
		TabLineFill = { bg = colors.bg_primary },
		TabLineSel = { fg = colors.fg_primary, bg = colors.bg_highlight },
		WinSeparator = { fg = colors.bg_highlight },
		
		-- Popups - floating crystals
		Pmenu = { fg = colors.fg_primary, bg = colors.bg_float },
		PmenuSel = { fg = colors.bg_primary, bg = colors.func },
		PmenuSbar = { bg = colors.bg_highlight },
		PmenuThumb = { bg = colors.func },
		
		-- Syntax highlighting - radiant spectrum
		Comment = { fg = colors.fg_subtle, italic = true },
		
		-- Constants - crystalline
		Constant = { fg = colors.const },
		String = { fg = colors.string },
		Character = { fg = colors.string },
		Number = { fg = colors.const },
		Boolean = { fg = colors.const },
		Float = { fg = colors.const },
		
		-- Identifiers
		Identifier = { fg = colors.fg_primary },
		Function = { fg = colors.func },
		
		-- Statements - structured light
		Statement = { fg = colors.keyword },
		Conditional = { fg = colors.keyword },
		Repeat = { fg = colors.keyword },
		Label = { fg = colors.keyword },
		Operator = { fg = colors.special },
		Keyword = { fg = colors.keyword },
		Exception = { fg = colors.keyword },
		
		-- PreProcessor
		PreProc = { fg = colors.special },
		Include = { fg = colors.func },
		Define = { fg = colors.keyword },
		Macro = { fg = colors.special },
		PreCondit = { fg = colors.keyword },
		
		-- Types - crystal formations
		Type = { fg = colors.type },
		StorageClass = { fg = colors.keyword },
		Structure = { fg = colors.type },
		Typedef = { fg = colors.type },
		
		-- Special elements
		Special = { fg = colors.special },
		SpecialChar = { fg = colors.special },
		Tag = { fg = colors.func },
		Delimiter = { fg = colors.fg_secondary },
		SpecialComment = { fg = colors.special, italic = true },
		Debug = { fg = colors.warn },
		
		-- Diffs - crystal changes (using direct hex colors for backgrounds)
		DiffAdd = { fg = colors.string, bg = '#E0F2F1' },     -- Light green crystal
		DiffChange = { fg = colors.func, bg = '#E3F2FD' },   -- Light blue crystal
		DiffDelete = { fg = colors.error, bg = '#FFEBEE' },  -- Light red crystal
		DiffText = { fg = colors.func, bg = '#BBDEFB' },     -- Highlighted blue crystal
		
		-- Diagnostics - clear indicators
		DiagnosticError = { fg = colors.error },
		DiagnosticWarn = { fg = colors.warn },
		DiagnosticInfo = { fg = colors.info },
		DiagnosticHint = { fg = colors.hint },
		
		-- TreeSitter highlights - crystal semantics
		['@variable'] = { fg = colors.fg_primary },
		['@variable.builtin'] = { fg = colors.keyword },
		['@variable.parameter'] = { fg = colors.fg_secondary },
		['@variable.member'] = { fg = colors.type },
		
		['@constant'] = { fg = colors.const },
		['@constant.builtin'] = { fg = colors.const },
		['@constant.macro'] = { fg = colors.special },
		
		['@string'] = { fg = colors.string },
		['@string.escape'] = { fg = colors.special },
		['@string.special'] = { fg = colors.special },
		
		['@character'] = { fg = colors.string },
		['@number'] = { fg = colors.const },
		['@boolean'] = { fg = colors.const },
		['@float'] = { fg = colors.const },
		
		['@function'] = { fg = colors.func },
		['@function.builtin'] = { fg = colors.keyword },
		['@function.call'] = { fg = colors.func },
		['@function.macro'] = { fg = colors.special },
		['@method'] = { fg = colors.func },
		['@method.call'] = { fg = colors.func },
		
		['@constructor'] = { fg = colors.type },
		['@parameter'] = { fg = colors.fg_secondary },
		
		['@keyword'] = { fg = colors.keyword },
		['@keyword.function'] = { fg = colors.keyword },
		['@keyword.operator'] = { fg = colors.keyword },
		['@keyword.return'] = { fg = colors.keyword },
		['@keyword.import'] = { fg = colors.func },
		
		['@type'] = { fg = colors.type },
		['@type.builtin'] = { fg = colors.keyword },
		
		['@property'] = { fg = colors.type },
		['@field'] = { fg = colors.type },
		
		['@operator'] = { fg = colors.special },
		['@punctuation.delimiter'] = { fg = colors.fg_secondary },
		['@punctuation.bracket'] = { fg = colors.fg_secondary },
		['@punctuation.special'] = { fg = colors.special },
		
		['@comment'] = { fg = colors.fg_subtle, italic = true },
		['@comment.todo'] = { fg = colors.func, bold = true },
		['@comment.note'] = { fg = colors.info, bold = true },
		['@comment.warning'] = { fg = colors.warn, bold = true },
		['@comment.error'] = { fg = colors.error, bold = true },
		
		-- Markup elements
		['@markup.heading'] = { fg = colors.func, bold = true },
		['@markup.strong'] = { bold = true },
		['@markup.italic'] = { italic = true },
		['@markup.underline'] = { underline = true },
		['@markup.strikethrough'] = { strikethrough = true },
		['@markup.link'] = { fg = colors.func, underline = true },
		['@markup.link.url'] = { fg = colors.type, underline = true },
		['@markup.raw'] = { fg = colors.string },
		['@markup.quote'] = { fg = colors.fg_muted, italic = true },
		['@markup.list'] = { fg = colors.special },
		
		-- Tags (HTML/XML)
		['@tag'] = { fg = colors.func },
		['@tag.attribute'] = { fg = colors.type },
		['@tag.delimiter'] = { fg = colors.fg_secondary },
	}
end

return M