-- 無 (Mu) - WCAG AAA Grayscale
-- Maximum contrast monochrome for accessibility and distraction-free coding  
-- TRANSPARENT BY DEFAULT: Pure focus without visual distractions

-- Removed OKLCH dependency - using direct hex colors for simplicity and accuracy

local M = {}

-- Theme transparency philosophy
M.default_transparent = true  -- Mu is transparent by default for pure focus

-- Direct hex color palette for WCAG AAA Grayscale theme (from extended-preview.html Mu theme)
M.colors = {
	-- Background colors - Pure monochrome (exact colors from extended-preview.html)
	bg_primary = '#000000',        -- Pure black
	bg_secondary = '#1A1A1A',      -- Dark gray
	bg_float = '#2D2D2D',          -- Medium dark
	bg_highlight = '#404040',      -- Selection gray
	
	-- Foreground colors - High contrast (exact colors from extended-preview.html)
	fg_primary = '#FFFFFF',        -- Pure white text
	fg_secondary = '#E6E6E6',      -- Very light gray
	fg_muted = '#CCCCCC',          -- Light gray
	fg_subtle = '#808080',         -- Medium gray
	
	-- Syntax colors - Monochrome hierarchy (exact colors from extended-preview.html)
	func = '#D4D4D4',              -- Light gray functions (blue-primary in grayscale)
	keyword = '#A0A0A0',           -- Medium-light keywords (purple-primary in grayscale)
	string = '#B8B8B8',            -- Light gray strings (green-primary in grayscale)
	type = '#CCCCCC',              -- Very light types (teal-primary in grayscale)
	const = '#909090',             -- Medium constants (orange-primary in grayscale)
	special = '#909090',           -- Medium operators (same as const)
	
	-- Diagnostic colors - Grayscale warnings (exact colors from extended-preview.html)
	error = '#FFFFFF',             -- Maximum visibility white (red-primary)
	warn = '#E0E0E0',              -- Very light gray (orange-primary)
	info = '#B8B8B8',              -- Light gray (blue-primary)
	hint = '#A0A0A0',              -- Medium light (green-primary)
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

-- Highlight groups with maximum contrast
function M.highlights(colors, config)
	-- Resolve transparency (Mu philosophy: transparent by default for pure focus)
	local use_transparent = resolve_transparency(config)
	local transparent_bg = use_transparent and 'NONE' or colors.bg_primary
	local transparent_float = use_transparent and 'NONE' or colors.bg_float
	
	return {
		-- Editor base
		Normal = { fg = colors.fg_primary, bg = transparent_bg },
		NormalFloat = { fg = colors.fg_primary, bg = transparent_float },
		NormalNC = { fg = colors.fg_secondary, bg = transparent_bg },
		
		-- Cursor and selection - maximum visibility
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
		
		-- Search - high contrast
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
		
		-- Popups - monochrome interface
		Pmenu = { fg = colors.fg_primary, bg = colors.bg_float },
		PmenuSel = { fg = colors.bg_primary, bg = colors.func },
		PmenuSbar = { bg = colors.bg_highlight },
		PmenuThumb = { bg = colors.func },
		
		-- Syntax highlighting - grayscale hierarchy
		Comment = { fg = colors.fg_subtle, italic = true },
		
		-- Constants - monochrome clarity
		Constant = { fg = colors.const },
		String = { fg = colors.string },
		Character = { fg = colors.string },
		Number = { fg = colors.const },
		Boolean = { fg = colors.const },
		Float = { fg = colors.const },
		
		-- Identifiers
		Identifier = { fg = colors.fg_primary },
		Function = { fg = colors.func },
		
		-- Statements - structured gray
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
		
		-- Types - grayscale structure
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
		
		-- Diffs - monochrome changes (using direct hex colors for backgrounds)
		DiffAdd = { fg = colors.string, bg = '#2A2A2A' },     -- Dark gray for add
		DiffChange = { fg = colors.func, bg = '#2A2A2A' },   -- Dark gray for change
		DiffDelete = { fg = colors.error, bg = '#2A2A2A' },  -- Dark gray for delete
		DiffText = { fg = colors.func, bg = '#353535' },     -- Slightly lighter gray for text
		
		-- Diagnostics - maximum visibility
		DiagnosticError = { fg = colors.error },
		DiagnosticWarn = { fg = colors.warn },
		DiagnosticInfo = { fg = colors.info },
		DiagnosticHint = { fg = colors.hint },
		
		-- TreeSitter highlights - accessibility focused
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
