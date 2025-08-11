-- 翠 (Sui) - Taiwan Mountain Jade
-- Sophisticated jade green environment with muted gray undertones
-- LIGHT THEME: Taiwan mountain aesthetics with natural jade sophistication

-- Direct hex color palette for Taiwan Mountain Jade theme inspired by Taiwan mountain jade

local M = {}

-- Theme transparency philosophy
M.default_transparent = false  -- Light themes work well with transparency

-- Direct hex color palette for Taiwan Mountain Jade theme
M.colors = {
	-- Background colors - Taiwan mountain jade with sophisticated natural tones
	bg_primary = '#8CC49F',        -- Deep Taiwan jade primary background
	bg_secondary = '#B1C090',      -- Sage olive secondary background
	bg_float = '#A7D2B5',          -- Medium jade float background
	bg_highlight = '#9ECDAA',      -- Light jade highlight background
	
	-- Foreground colors - High contrast Taiwan jade mountain text
	fg_primary = '#0D2418',        -- Very deep forest green for maximum contrast
	fg_secondary = '#1A3629',      -- Rich dark jade secondary text
	fg_muted = '#2D4A3D',          -- Medium depth muted text
	fg_subtle = '#4A6B5C',         -- Subtle text with good readability
	
	-- Syntax colors - High contrast Taiwan mountain jade palette
	func = '#1A4D66',              -- Deep ocean blue for functions
	keyword = '#4A3366',           -- Rich purple for keywords
	string = '#1A4D1A',            -- Deep forest green for strings
	type = '#1A5555',              -- Rich jade-teal for types
	const = '#B8601A',             -- Rich amber orange for constants
	special = '#2D7373',           -- Sophisticated jade-teal for operators
	
	-- Diagnostic colors - High contrast Taiwan mountain diagnostics
	error = '#B33333',             -- Deep rose red for errors
	warn = '#B8601A',              -- Rich amber for warnings
	info = '#1A4D66',              -- Deep ocean blue for info
	hint = '#1A4D1A',              -- Deep forest green for hints
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

-- Highlight groups with Taiwan mountain jade semantics  
function M.highlights(colors, config)
	-- Resolve transparency (Taiwan Mountain Jade philosophy: transparency enhances natural depth)
	local use_transparent = resolve_transparency(config)
	local transparent_bg = use_transparent and 'NONE' or colors.bg_primary
	local transparent_float = use_transparent and 'NONE' or colors.bg_float
	
	return {
		-- Editor base
		Normal = { fg = colors.fg_primary, bg = transparent_bg },
		NormalFloat = { fg = colors.fg_primary, bg = transparent_float },
		NormalNC = { fg = colors.fg_secondary, bg = transparent_bg },
		
		-- Cursor and selection - Taiwan jade highlights
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
		
		-- Search - Taiwan jade highlights
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
		
		-- Popups - Taiwan jade floating elements
		Pmenu = { fg = colors.fg_primary, bg = colors.bg_float },
		PmenuSel = { fg = colors.bg_primary, bg = colors.func },
		PmenuSbar = { bg = colors.bg_highlight },
		PmenuThumb = { bg = colors.func },
		
		-- Syntax highlighting - Taiwan mountain elements
		Comment = { fg = colors.fg_subtle, italic = true },
		
		-- Constants - Taiwan jade elements
		Constant = { fg = colors.const },
		String = { fg = colors.string },
		Character = { fg = colors.string },
		Number = { fg = colors.const },
		Boolean = { fg = colors.const },
		Float = { fg = colors.const },
		
		-- Identifiers
		Identifier = { fg = colors.fg_primary },
		Function = { fg = colors.func },
		
		-- Statements - Taiwan jade flow control
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
		
		-- Types - Taiwan jade structural elements
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
		
		-- Diffs - change indicators (using Taiwan jade backgrounds)
		DiffAdd = { fg = colors.string, bg = '#E8F2E8' },     -- Taiwan jade addition
		DiffChange = { fg = colors.func, bg = '#E8F0F2' },   -- Muted jade-blue change
		DiffDelete = { fg = colors.error, bg = '#F2E8E8' },  -- Light red deletion
		DiffText = { fg = colors.func, bg = '#F0F2F5' },     -- Taiwan jade highlighted text
		
		-- Diagnostics - Taiwan mountain feedback
		DiagnosticError = { fg = colors.error },
		DiagnosticWarn = { fg = colors.warn },
		DiagnosticInfo = { fg = colors.info },
		DiagnosticHint = { fg = colors.hint },
		
		-- TreeSitter highlights - Taiwan jade semantics
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
