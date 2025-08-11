-- 輝 (Ki) - Arctic Sunset Radiance
-- Maximum brightness with arctic sunset purple-pink-blue gradients for ethereal 輝 (radiance)
-- ARCTIC ILLUMINATION: Pure radiant light with aurora-inspired sunset spectrum

-- Direct hex color palette for Arctic Sunset theme with purple-pink-blue gradients

local M = {}

-- Theme transparency philosophy
M.default_transparent = false  -- Arctic radiance needs solid backgrounds for aurora visibility

-- Direct hex color palette for Arctic Sunset theme
M.colors = {
	-- Background colors - Arctic radiance with aurora tints
	bg_primary = '#FAFAFF',        -- Cool arctic white with subtle lavender
	bg_secondary = '#FFFFFF',      -- Pure radiant white - maximum brightness
	bg_float = '#F8F6FF',          -- Soft aurora glow for floating elements
	bg_highlight = '#F5F0FF',      -- Cool radiant selection with purple highlight
	
	-- Foreground colors - High contrast for arctic clarity
	fg_primary = '#1A1A1A',        -- Deep charcoal - maximum contrast for radiance
	fg_secondary = '#3A3A42',      -- Dark cool gray with subtle undertone
	fg_muted = '#65606B',          -- Medium cool gray - muted arctic tone
	fg_subtle = '#9A8FA3',         -- Light cool gray - arctic subtle tones
	
	-- Syntax colors - Arctic sunset gradient spectrum
	func = '#8B5CF6',              -- Deep aurora purple functions - ethereal energy
	keyword = '#E91E63',           -- Sunset magenta keywords - radiant power
	string = '#0891B2',            -- Arctic teal strings - crystal clarity
	type = '#C084FC',              -- Aurora lavender types - ethereal structure
	const = '#BE185D',             -- Sunset pink constants - passionate radiance
	special = '#7C3AED',           -- Arctic violet operators - mystical brilliance
	
	-- Diagnostic colors - Arctic clear with cool energy
	error = '#F44336',             -- Bright red for errors
	warn = '#F59E0B',              -- Arctic amber for warnings
	info = '#0EA5E9',              -- Arctic cyan for info
	hint = '#8B5CF6',              -- Aurora purple for hints
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

-- Highlight groups with crystal radiance
function M.highlights(colors, config)
	-- Resolve transparency (Arctic Radiance philosophy: solid backgrounds for aurora visibility)
	local use_transparent = resolve_transparency(config)
	local transparent_bg = use_transparent and 'NONE' or colors.bg_primary
	local transparent_float = use_transparent and 'NONE' or colors.bg_float
	
	return {
		-- Editor base
		Normal = { fg = colors.fg_primary, bg = transparent_bg },
		NormalFloat = { fg = colors.fg_primary, bg = transparent_float },
		NormalNC = { fg = colors.fg_secondary, bg = transparent_bg },
		
		-- Cursor and selection - arctic radiance
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
		
		-- Search - arctic highlights
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
		
		-- Popups - arctic interface
		Pmenu = { fg = colors.fg_primary, bg = colors.bg_float },
		PmenuSel = { fg = colors.bg_primary, bg = colors.func },
		PmenuSbar = { bg = colors.bg_highlight },
		PmenuThumb = { bg = colors.func },
		
		-- Syntax highlighting - arctic sunset spectrum
		Comment = { fg = colors.fg_subtle, italic = true },
		
		-- Constants - arctic energy
		Constant = { fg = colors.const },
		String = { fg = colors.string },
		Character = { fg = colors.string },
		Number = { fg = colors.const },
		Boolean = { fg = colors.const },
		Float = { fg = colors.const },
		
		-- Identifiers
		Identifier = { fg = colors.fg_primary },
		Function = { fg = colors.func },
		
		-- Statements - arctic energy flow
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
		
		-- Types - arctic crystal structures
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
		
		-- Diffs - arctic radiant changes (using arctic bright backgrounds)
		DiffAdd = { fg = colors.string, bg = '#E1F8FF' },     -- Arctic teal background
		DiffChange = { fg = colors.func, bg = '#F3E5F5' },   -- Arctic purple tint
		DiffDelete = { fg = colors.error, bg = '#FFEBEE' },  -- Arctic light red
		DiffText = { fg = colors.func, bg = '#EDE7F6' },     -- Arctic highlighted purple
		
		-- Diagnostics - arctic clarity
		DiagnosticError = { fg = colors.error },
		DiagnosticWarn = { fg = colors.warn },
		DiagnosticInfo = { fg = colors.info },
		DiagnosticHint = { fg = colors.hint },
		
		-- TreeSitter highlights - arctic radiant semantics
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
