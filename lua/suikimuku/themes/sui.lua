-- 翠 (Sui) - Garden Sage
-- Light green coding environment with natural harmony
-- LIGHT THEME: Works beautifully with transparency for a fresh, airy feel

-- Direct hex color palette for Garden Sage light theme inspired by green gradient website

local M = {}

-- Theme transparency philosophy
M.default_transparent = true  -- Light themes work well with transparency

-- Direct hex color palette for Garden Sage theme
M.colors = {
	-- Background colors - Light sage green harmony
	bg_primary = '#F2F8F2',        -- Very light sage white
	bg_secondary = '#E8F4E8',      -- Light sage background
	bg_float = '#DEF0DE',          -- Medium sage float
	bg_highlight = '#D4ECD4',      -- Sage green highlight
	
	-- Foreground colors - Forest green text
	fg_primary = '#2D5A2D',        -- Dark forest green primary text
	fg_secondary = '#3A6B3A',      -- Medium forest green secondary text
	fg_muted = '#5C8A5C',          -- Muted forest green
	fg_subtle = '#7A9A7A',         -- Light forest green subtle
	
	-- Syntax colors - Natural coding palette
	func = '#1E6B7A',              -- Deep teal blue for functions
	keyword = '#5A4FCF',           -- Purple for keywords
	string = '#2E7D32',            -- Forest green for strings
	type = '#1565C0',              -- Royal blue for types
	const = '#E65100',             -- Orange for constants
	special = '#388E3C',           -- Fresh green for operators
	
	-- Diagnostic colors - Natural warnings
	error = '#C62828',             -- Deep red for errors
	warn = '#F57C00',              -- Orange for warnings
	info = '#1976D2',              -- Blue for info
	hint = '#388E3C',              -- Green for hints
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

-- Highlight groups with natural garden semantics  
function M.highlights(colors, config)
	-- Resolve transparency (Garden Sage philosophy: transparency enhances the airy feel)
	local use_transparent = resolve_transparency(config)
	local transparent_bg = use_transparent and 'NONE' or colors.bg_primary
	local transparent_float = use_transparent and 'NONE' or colors.bg_float
	
	return {
		-- Editor base
		Normal = { fg = colors.fg_primary, bg = transparent_bg },
		NormalFloat = { fg = colors.fg_primary, bg = transparent_float },
		NormalNC = { fg = colors.fg_secondary, bg = transparent_bg },
		
		-- Cursor and selection - natural highlights
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
		
		-- Search - bright highlights
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
		
		-- Popups - floating elements
		Pmenu = { fg = colors.fg_primary, bg = colors.bg_float },
		PmenuSel = { fg = colors.bg_primary, bg = colors.func },
		PmenuSbar = { bg = colors.bg_highlight },
		PmenuThumb = { bg = colors.func },
		
		-- Syntax highlighting - natural elements
		Comment = { fg = colors.fg_subtle, italic = true },
		
		-- Constants - vibrant elements
		Constant = { fg = colors.const },
		String = { fg = colors.string },
		Character = { fg = colors.string },
		Number = { fg = colors.const },
		Boolean = { fg = colors.const },
		Float = { fg = colors.const },
		
		-- Identifiers
		Identifier = { fg = colors.fg_primary },
		Function = { fg = colors.func },
		
		-- Statements - flow control
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
		
		-- Types - structural elements
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
		
		-- Diffs - change indicators (using light backgrounds for light theme)
		DiffAdd = { fg = colors.string, bg = '#E8F5E8' },     -- Light green addition
		DiffChange = { fg = colors.func, bg = '#E8F0F5' },   -- Light blue change
		DiffDelete = { fg = colors.error, bg = '#F5E8E8' },  -- Light red deletion
		DiffText = { fg = colors.func, bg = '#F0F5FA' },     -- Highlighted blue text
		
		-- Diagnostics - code feedback
		DiagnosticError = { fg = colors.error },
		DiagnosticWarn = { fg = colors.warn },
		DiagnosticInfo = { fg = colors.info },
		DiagnosticHint = { fg = colors.hint },
		
		-- TreeSitter highlights - natural semantics
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