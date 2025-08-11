-- SuiKimuku (翠輝無空) v3.0 - Simple OKLCH Architecture
-- Four themes with mathematical color precision and Japanese aesthetic philosophy
--
-- 翠 (Sui) - Digital Aquarium: oceanic depth with teal luminescence
-- 輝 (Ki) - Crystal Light: pristine clarity with radiant precision
-- 無 (Mu) - WCAG Grayscale: maximum contrast monochrome accessibility
-- 空 (Ku) - Enhanced Terminal: electric vibrancy in cosmic void

local M = {}

-- Configuration with defaults
M.config = {
	style = 'ku', -- Default theme
	transparent = nil, -- Let themes decide their own transparency philosophy
	opacity = 0.64,
}

-- Load a specific theme
function M.load(style)
	if style then
		M.config.style = style
	end
	
	-- Validate style
	local valid_styles = {'sui', 'ki', 'mu', 'ku'}
	local is_valid = false
	for _, valid_style in ipairs(valid_styles) do
		if M.config.style == valid_style then
			is_valid = true
			break
		end
	end
	
	if not is_valid then
		vim.notify('SuiKimuku: Invalid style "' .. M.config.style .. '". Using default "ku".', vim.log.levels.WARN)
		M.config.style = 'ku'
	end
	
	-- Clear existing highlights
	vim.cmd('highlight clear')
	if vim.fn.exists('syntax_on') then
		vim.cmd('syntax reset')
	end
	
	-- Set colorscheme name
	vim.g.colors_name = 'suikimuku'
	
	-- Load the theme module with error handling
	local ok, theme_module = pcall(require, 'suikimuku.themes.' .. M.config.style)
	if not ok then
		vim.notify('SuiKimuku: Failed to load theme "' .. M.config.style .. '": ' .. tostring(theme_module), vim.log.levels.ERROR)
		return
	end
	
	-- Validate theme module structure
	if not theme_module.colors or not theme_module.highlights then
		vim.notify('SuiKimuku: Theme "' .. M.config.style .. '" is missing required colors or highlights function', vim.log.levels.ERROR)
		return
	end
	
	-- Generate highlights with error handling
	local colors = theme_module.colors
	local ok_highlights, highlights = pcall(theme_module.highlights, colors, M.config)
	if not ok_highlights then
		vim.notify('SuiKimuku: Failed to generate highlights for "' .. M.config.style .. '": ' .. tostring(highlights), vim.log.levels.ERROR)
		return
	end
	
	-- Apply highlights
	for group, settings in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

-- Setup function
function M.setup(user_config)
	-- Merge user config with defaults (with error handling)
	if user_config then
		local ok, merged = pcall(vim.tbl_deep_extend, 'force', M.config, user_config)
		if ok then
			M.config = merged
		else
			vim.notify('SuiKimuku: Invalid user config, using defaults: ' .. tostring(merged), vim.log.levels.WARN)
		end
	end
	
	-- Load the colorscheme
	M.load()
end

-- Get current colors (for external integrations)
function M.get_colors()
	local ok, theme_module = pcall(require, 'suikimuku.themes.' .. M.config.style)
	if not ok then
		vim.notify('SuiKimuku: Failed to load theme for get_colors(): ' .. tostring(theme_module), vim.log.levels.ERROR)
		return {}
	end
	return theme_module.colors or {}
end

-- Simple user commands
vim.api.nvim_create_user_command('SuikimukyLoad', function(opts)
	local style = opts.args ~= '' and opts.args or M.config.style
	M.load(style)
end, {
	nargs = '?',
	complete = function()
		return {'sui', 'ki', 'mu', 'ku'}
	end,
	desc = 'Load SuiKimuku theme'
})

return M