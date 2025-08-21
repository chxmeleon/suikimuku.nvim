-- 翠 (Sui) - Taiwan Mountain Jade
-- Sophisticated jade green environment with muted gray undertones
-- LIGHT THEME: Taiwan mountain aesthetics with natural jade sophistication

local M = {}

-- Theme transparency philosophy
M.default_transparent = false  -- Light themes work well with transparency

-- Direct hex color palette for Taiwan Mountain Jade theme
M.colors = {
	-- Background colors - Taiwan mountain jade with sophisticated natural tones
	bg_primary = '#A7D2B5',        -- Medium jade primary background
	bg_secondary = '#B1C090',      -- Sage olive secondary background
	bg_float = '#8CC49F',          -- Deep Taiwan jade float background
	bg_highlight = '#9ECDAA',      -- Light jade highlight background
	
	-- Foreground colors - High contrast Taiwan jade mountain text
	fg_primary = '#0D2418',        -- Very deep forest green for maximum contrast
	fg_secondary = '#1A3629',      -- Rich dark jade secondary text
	fg_muted = '#2D4A3D',          -- Medium depth muted text
	fg_subtle = '#4A6B5C',         -- Subtle text with good readability
	
	-- Blue Family - Ocean depths for functions and info
	blue_primary = '#0066CC',      -- Bright ocean blue for main functions
	blue_dark = '#003d7a',         -- Deep ocean for builtin functions
	blue_light = '#3399FF',        -- Light ocean for function calls
	blue_bright = '#66B3FF',       -- Bright ocean for special functions
	
	-- Teal Family - Jade waters for types and operators
	teal_primary = '#006666',      -- Deep jade-teal for types
	teal_dark = '#003d3d',         -- Dark jade for builtin types
	teal_light = '#00A0A0',        -- Light jade for type annotations
	teal_bright = '#33CCCC',       -- Bright jade for special types
	
	-- Green Family - Forest harmony for strings and hints
	green_primary = '#008B00',     -- Forest green for strings
	green_dark = '#005200',        -- Deep forest for raw strings
	green_light = '#33CC33',       -- Light forest for string escapes
	green_bright = '#66FF66',      -- Bright forest for special strings
	
	-- Purple Family - Mountain flowers for keywords
	purple_primary = '#8B00FF',    -- Vibrant purple for keywords
	purple_dark = '#5200B3',       -- Deep purple for storage keywords
	purple_light = '#B366FF',      -- Light purple for conditional keywords
	purple_bright = '#CC99FF',     -- Bright purple for special keywords
	
	-- Orange Family - Autumn leaves for constants and warnings
	orange_primary = '#FF7F00',    -- Bright orange for constants
	orange_dark = '#CC4C00',       -- Deep orange for builtin constants
	orange_light = '#FF9933',      -- Light orange for number constants
	orange_bright = '#FFB366',     -- Bright orange for special constants
	
	-- Red Family - Mountain sunset for errors and diagnostics
	red_primary = '#CC0000',       -- Bright red for errors
	red_dark = '#990000',          -- Deep red for critical errors
	red_light = '#FF3333',         -- Light red for warnings
	red_bright = '#FF6666',        -- Bright red for error highlights
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
		Cursor = { fg = colors.bg_primary, bg = colors.blue_primary },
		CursorLine = { bg = colors.bg_secondary },
		CursorColumn = { bg = colors.bg_secondary },
		CursorLineNr = { fg = colors.blue_primary, bold = true },
		LineNr = { fg = colors.fg_subtle },
		SignColumn = { bg = transparent_bg },
		ColorColumn = { bg = colors.bg_secondary },
		
		-- Visual selection
		Visual = { bg = colors.bg_highlight },
		VisualNOS = { bg = colors.bg_highlight },
		
		-- Search - Taiwan jade highlights
		Search = { fg = colors.bg_primary, bg = colors.orange_primary },
		IncSearch = { fg = colors.bg_primary, bg = colors.blue_primary },
		Substitute = { fg = colors.bg_primary, bg = colors.teal_primary },
		
		-- Window elements
		StatusLine = { fg = colors.fg_primary, bg = colors.bg_secondary },
		StatusLineNC = { fg = colors.fg_subtle, bg = colors.bg_secondary },
		TabLine = { fg = colors.fg_secondary, bg = colors.bg_secondary },
		TabLineFill = { bg = colors.bg_primary },
		TabLineSel = { fg = colors.fg_primary, bg = colors.bg_highlight },
		WinSeparator = { fg = colors.bg_highlight },
		
		-- Popups - Taiwan jade floating elements
		Pmenu = { fg = colors.fg_primary, bg = colors.bg_float },
		PmenuSel = { fg = colors.bg_primary, bg = colors.blue_primary },
		PmenuSbar = { bg = colors.bg_highlight },
		PmenuThumb = { bg = colors.blue_primary },
		
		-- Syntax highlighting - Taiwan mountain elements
		Comment = { fg = colors.fg_subtle, italic = true },
		
		-- Constants - Taiwan jade elements with rich color families
		Constant = { fg = colors.orange_primary },
		String = { fg = colors.green_primary },
		Character = { fg = colors.green_light },
		Number = { fg = colors.orange_light },
		Boolean = { fg = colors.orange_bright },
		Float = { fg = colors.orange_light },
		
		-- Identifiers - Enhanced with color families
		Identifier = { fg = colors.fg_primary },
		Function = { fg = colors.blue_primary },
		
		-- Statements - Taiwan jade flow control with purple family
		Statement = { fg = colors.purple_primary },
		Conditional = { fg = colors.purple_light },
		Repeat = { fg = colors.purple_light },
		Label = { fg = colors.purple_dark },
		Operator = { fg = colors.teal_light },
		Keyword = { fg = colors.purple_primary },
		Exception = { fg = colors.purple_bright },
		
		-- PreProcessor - Enhanced with teal and purple families
		PreProc = { fg = colors.teal_light },
		Include = { fg = colors.blue_light },
		Define = { fg = colors.purple_light },
		Macro = { fg = colors.teal_bright },
		PreCondit = { fg = colors.purple_light },
		
		-- Types - Taiwan jade structural elements with teal family
		Type = { fg = colors.teal_primary },
		StorageClass = { fg = colors.purple_dark },
		Structure = { fg = colors.teal_light },
		Typedef = { fg = colors.teal_bright },
		
		-- Special elements - Enhanced with multiple families
		Special = { fg = colors.teal_light },
		SpecialChar = { fg = colors.green_bright },
		Tag = { fg = colors.blue_light },
		Delimiter = { fg = colors.fg_secondary },
		SpecialComment = { fg = colors.teal_bright, italic = true },
		Debug = { fg = colors.orange_light },
		
		-- Diffs - change indicators using rich color families
		DiffAdd = { fg = colors.green_primary, bg = '#E8F2E8' },     -- Taiwan jade addition
		DiffChange = { fg = colors.blue_primary, bg = '#E8F0F2' },   -- Muted jade-blue change
		DiffDelete = { fg = colors.red_primary, bg = '#F2E8E8' },    -- Light red deletion
		DiffText = { fg = colors.blue_bright, bg = '#F0F2F5' },      -- Taiwan jade highlighted text
		
		-- Diagnostics - Taiwan mountain feedback with red/orange families
		DiagnosticError = { fg = colors.red_primary },
		DiagnosticWarn = { fg = colors.orange_primary },
		DiagnosticInfo = { fg = colors.blue_primary },
		DiagnosticHint = { fg = colors.green_primary },
		
		-- TreeSitter highlights - Taiwan jade semantics with rich families
		['@variable'] = { fg = colors.fg_primary },
		['@variable.builtin'] = { fg = colors.purple_bright },
		['@variable.parameter'] = { fg = colors.fg_secondary },
		['@variable.member'] = { fg = colors.teal_light },
		
		['@constant'] = { fg = colors.orange_primary },
		['@constant.builtin'] = { fg = colors.orange_bright },
		['@constant.macro'] = { fg = colors.orange_light },
		
		['@string'] = { fg = colors.green_primary },
		['@string.escape'] = { fg = colors.green_bright },
		['@string.special'] = { fg = colors.green_light },
		
		['@character'] = { fg = colors.green_light },
		['@number'] = { fg = colors.orange_light },
		['@boolean'] = { fg = colors.orange_bright },
		['@float'] = { fg = colors.orange_light },
		
		['@function'] = { fg = colors.blue_primary },
		['@function.builtin'] = { fg = colors.blue_bright },
		['@function.call'] = { fg = colors.blue_light },
		['@function.macro'] = { fg = colors.blue_dark },
		['@method'] = { fg = colors.blue_primary },
		['@method.call'] = { fg = colors.blue_light },
		
		['@constructor'] = { fg = colors.teal_bright },
		['@parameter'] = { fg = colors.fg_secondary },
		
		['@keyword'] = { fg = colors.purple_primary },
		['@keyword.function'] = { fg = colors.purple_light },
		['@keyword.operator'] = { fg = colors.purple_bright },
		['@keyword.return'] = { fg = colors.purple_light },
		['@keyword.import'] = { fg = colors.blue_light },
		
		['@type'] = { fg = colors.teal_primary },
		['@type.builtin'] = { fg = colors.teal_bright },
		
		['@property'] = { fg = colors.teal_light },
		['@field'] = { fg = colors.teal_light },
		
		['@operator'] = { fg = colors.teal_light },
		['@punctuation.delimiter'] = { fg = colors.fg_secondary },
		['@punctuation.bracket'] = { fg = colors.fg_secondary },
		['@punctuation.special'] = { fg = colors.teal_bright },
		
		['@comment'] = { fg = colors.fg_subtle, italic = true },
		['@comment.todo'] = { fg = colors.blue_bright, bold = true },
		['@comment.note'] = { fg = colors.blue_primary, bold = true },
		['@comment.warning'] = { fg = colors.orange_primary, bold = true },
		['@comment.error'] = { fg = colors.red_primary, bold = true },
		
		-- Markup elements
		['@markup.heading'] = { fg = colors.blue_primary, bold = true },
		['@markup.strong'] = { bold = true },
		['@markup.italic'] = { italic = true },
		['@markup.underline'] = { underline = true },
		['@markup.strikethrough'] = { strikethrough = true },
		['@markup.link'] = { fg = colors.blue_light, underline = true },
		['@markup.link.url'] = { fg = colors.teal_primary, underline = true },
		['@markup.raw'] = { fg = colors.green_primary },
		['@markup.quote'] = { fg = colors.fg_muted, italic = true },
		['@markup.list'] = { fg = colors.teal_light },
		
		-- Tags (HTML/XML) 
		['@tag'] = { fg = colors.blue_light },
		['@tag.attribute'] = { fg = colors.teal_light },
		['@tag.delimiter'] = { fg = colors.fg_secondary },
	}
end

return M
