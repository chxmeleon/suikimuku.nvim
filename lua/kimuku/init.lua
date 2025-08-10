-- SuiKimuku (翠輝無空) Theme System
-- Sui (翠) - Atmospheric Teal Garden: Multi-palette fusion with cinematic depth
-- Ki (輝) - Crystal Radiant Light: Cool, crisp, luminous radiance
-- Mu (無) - WCAG AAA Grayscale: Maximum contrast monochrome
-- Ku (空) - Terminal Solarized: Perfect harmony with terminal colors

local M = {}

-- Configuration with defaults
M.config = {
    style = 'ku',        -- 'sui', 'ki', 'mu', or 'ku'
    transparent = false, -- Enable transparent background
    opacity = 0.64,      -- Background opacity when transparent (0.0-1.0)
    monochrome = false,  -- Force grayscale mode (overrides style)
}

-- Color Palettes
M.palettes = {
    -- Sui (翠) - Atmospheric Teal Garden
    sui = {
        bg = {
            primary = '#0A1B1A',
            secondary = '#0F2A28',
            float = '#1A3E3B',
            highlight = '#2A5651',
        },
        fg = {
            primary = '#A7DBD8',
            secondary = '#7BBAB1',
            muted = '#C8E6F5',
            subtle = '#7BBAB1',
        },
        syntax = {
            func = '#69D2E7',    -- Ethereal light blue
            keyword = '#EC4899', -- Bright magenta
            string = '#52C489',  -- Emerald growth
            type = '#87CEEB',    -- Sky blue
            const = '#F38630',   -- Warm orange
            special = '#A7DBD8', -- Aqua mint
        },
        diag = {
            error = '#F38630',
            warn = '#FA6900',
            info = '#69D2E7',
            hint = '#52C489',
        },
    },

    -- Ki (輝) - Crystal Radiant Light
    ki = {
        bg = {
            primary = '#FAFCFF',
            secondary = '#F0F9FF',
            float = '#E1F5FE',
            highlight = '#CBD5E1',
        },
        fg = {
            primary = '#475569',
            secondary = '#64748B',
            muted = '#334155',
            subtle = '#64748B',
        },
        syntax = {
            func = '#3B82F6',    -- Bright blue
            keyword = '#8B5CF6', -- Purple
            string = '#10B981',  -- Emerald green
            type = '#06B6D4',    -- Cyan
            const = '#F97316',   -- Orange
            special = '#475569', -- Cool gray
        },
        diag = {
            error = '#E11D48',
            warn = '#F97316',
            info = '#3B82F6',
            hint = '#10B981',
        },
    },

    -- Mu (無) - WCAG AAA High-Contrast Grayscale
    mu = {
        bg = {
            primary = '#000000',
            secondary = '#1A1A1A',
            float = '#2D2D2D',
            highlight = '#404040',
        },
        fg = {
            primary = '#CCCCCC',
            secondary = '#808080',
            muted = '#E6E6E6',
            subtle = '#808080',
        },
        syntax = {
            func = '#FFFFFF',    -- Pure white for maximum contrast
            keyword = '#E0E0E0', -- Near white
            string = '#B8B8B8',  -- Light gray
            type = '#D4D4D4',    -- Very light gray
            const = '#A0A0A0',   -- Medium light gray
            special = '#909090', -- Medium gray
        },
        diag = {
            error = '#FFFFFF',   -- Maximum visibility
            warn = '#E0E0E0',
            info = '#B8B8B8',
            hint = '#A0A0A0',
        },
    },

    -- Ku (空) - Terminal Solarized Dark
    ku = {
        bg = {
            primary = '#000F10',
            secondary = '#073642',
            float = '#114555',
            highlight = '#203047',
        },
        fg = {
            primary = '#839496',
            secondary = '#586E75',
            muted = '#93A1A1',
            subtle = '#586E75',
        },
        syntax = {
            func = '#268BD2',    -- Solarized blue
            keyword = '#D33682', -- Solarized magenta
            string = '#859900',  -- Solarized green
            type = '#B58900',    -- Solarized yellow
            const = '#CB4B16',   -- Solarized orange
            special = '#74B6B6', -- Solarized cyan
        },
        diag = {
            error = '#DC322F',   -- Solarized red
            warn = '#DDD389',    -- Bright yellow
            info = '#268BD2',    -- Solarized blue
            hint = '#859900',    -- Solarized green
        },
    },
}

-- Convert colors to grayscale
local function to_grayscale(color)
    local r = tonumber(color:sub(2,3), 16)
    local g = tonumber(color:sub(4,5), 16)
    local b = tonumber(color:sub(6,7), 16)
    local gray = math.floor((r * 0.299 + g * 0.587 + b * 0.114))
    return string.format("#%02x%02x%02x", gray, gray, gray)
end

-- Get active color palette based on configuration
function M.get_colors()
    local palette = M.palettes[M.config.style]
    local colors = vim.deepcopy(palette)
    
    -- Apply monochrome if enabled
    if M.config.monochrome then
        for category, values in pairs(colors) do
            if type(values) == "table" then
                for name, color in pairs(values) do
                    colors[category][name] = to_grayscale(color)
                end
            end
        end
    end
    
    return colors
end

-- Generate highlight groups
function M.get_highlights(colors)
    local transparent_bg = M.config.transparent and "NONE" or colors.bg.primary
    local transparent_float = M.config.transparent and "NONE" or colors.bg.float
    
    return {
        -- Editor
        Normal = { fg = colors.fg.primary, bg = transparent_bg },
        NormalFloat = { fg = colors.fg.primary, bg = transparent_float },
        NormalNC = { fg = colors.fg.secondary, bg = transparent_bg },
        SignColumn = { bg = transparent_bg },
        LineNr = { fg = colors.fg.subtle },
        CursorLine = { bg = colors.bg.secondary },
        CursorLineNr = { fg = colors.syntax.func, bold = true },
        ColorColumn = { bg = colors.bg.secondary },
        Visual = { bg = colors.bg.highlight },
        VisualNOS = { bg = colors.bg.highlight },
        
        -- Window elements
        StatusLine = { fg = colors.fg.primary, bg = colors.bg.secondary },
        StatusLineNC = { fg = colors.fg.subtle, bg = colors.bg.secondary },
        TabLine = { fg = colors.fg.subtle, bg = colors.bg.secondary },
        TabLineFill = { bg = colors.bg.primary },
        TabLineSel = { fg = colors.fg.primary, bg = colors.bg.highlight },
        WinSeparator = { fg = colors.bg.highlight },
        
        -- Syntax highlighting
        Function = { fg = colors.syntax.func },
        ['@function'] = { fg = colors.syntax.func },
        ['@function.call'] = { fg = colors.syntax.func },
        ['@method'] = { fg = colors.syntax.func },
        ['@method.call'] = { fg = colors.syntax.func },
        
        Keyword = { fg = colors.syntax.keyword },
        ['@keyword'] = { fg = colors.syntax.keyword },
        ['@keyword.function'] = { fg = colors.syntax.keyword },
        ['@keyword.operator'] = { fg = colors.syntax.keyword },
        
        String = { fg = colors.syntax.string },
        ['@string'] = { fg = colors.syntax.string },
        ['@string.escape'] = { fg = colors.syntax.special },
        
        Type = { fg = colors.syntax.type },
        ['@type'] = { fg = colors.syntax.type },
        ['@type.builtin'] = { fg = colors.syntax.type },
        
        Constant = { fg = colors.syntax.const },
        ['@constant'] = { fg = colors.syntax.const },
        ['@constant.builtin'] = { fg = colors.syntax.const },
        Number = { fg = colors.syntax.const },
        Boolean = { fg = colors.syntax.const },
        
        Special = { fg = colors.syntax.special },
        ['@punctuation'] = { fg = colors.syntax.special },
        ['@operator'] = { fg = colors.syntax.special },
        
        Comment = { fg = colors.fg.subtle, italic = true },
        ['@comment'] = { fg = colors.fg.subtle, italic = true },
        
        -- Variables
        Identifier = { fg = colors.fg.primary },
        ['@variable'] = { fg = colors.fg.primary },
        ['@parameter'] = { fg = colors.fg.muted },
        
        -- Diagnostics
        DiagnosticError = { fg = colors.diag.error },
        DiagnosticWarn = { fg = colors.diag.warn },
        DiagnosticInfo = { fg = colors.diag.info },
        DiagnosticHint = { fg = colors.diag.hint },
        
        -- Git signs
        GitSignsAdd = { fg = colors.syntax.string },
        GitSignsChange = { fg = colors.diag.warn },
        GitSignsDelete = { fg = colors.diag.error },
        
        -- Search
        Search = { fg = colors.bg.primary, bg = colors.syntax.func },
        IncSearch = { fg = colors.bg.primary, bg = colors.syntax.const },
        
        -- Popups
        Pmenu = { fg = colors.fg.primary, bg = colors.bg.float },
        PmenuSel = { fg = colors.bg.primary, bg = colors.syntax.func },
        PmenuSbar = { bg = colors.bg.highlight },
        PmenuThumb = { bg = colors.fg.subtle },
    }
end

-- Setup function
function M.setup(user_config)
    -- Merge user config with defaults
    if user_config then
        M.config = vim.tbl_deep_extend("force", M.config, user_config)
    end
    
    -- Clear existing highlights
    vim.cmd('highlight clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end
    
    -- Set colorscheme name
    vim.g.colors_name = 'suikimuku'
    
    -- Get colors and highlights
    local colors = M.get_colors()
    local highlights = M.get_highlights(colors)
    
    -- Apply highlights
    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return M
