-- Kimuku (輝無空) Theme System
-- Ki (輝) - Radiance theme: Vibrant and energetic
-- Mu (無) - Void theme: Minimal and focused
-- Ku (空) - Sky theme: Serene and balanced

local M = {}

-- Configuration with defaults
M.config = {
    style = 'ki',      -- 'ki', 'mu', or 'ku'
    transparent = false, -- Enable transparent background
    monochrome = false,  -- Enable grayscale mode
}

-- Color Palettes
M.palettes = {
    -- Ki (輝) - Radiant theme
    ki = {
        bg = {
            primary = '#0B131A',
            secondary = '#1B2329',
            float = '#2A3439',
            highlight = '#3A4757',
        },
        fg = {
            primary = '#FFFDF1',
            secondary = '#E5E3D8',
            muted = '#C4D7F5',
            subtle = '#657876',
        },
        syntax = {
            func = '#338DF9',    -- Bright blue for functions
            keyword = '#F51875', -- Vibrant magenta for keywords
            string = '#96FF65',  -- Energetic green for strings
            type = '#8F65F6',    -- Rich purple for types
            const = '#FD692A',   -- Warm orange for constants
            special = '#1EACB6', -- Cyan for special elements
        },
        diag = {
            error = '#F8404C',
            warn = '#ECD81D',
            info = '#338DF9',
            hint = '#96FF65',
        },
    },

    -- Mu (無) - Void theme
    mu = {
        bg = {
            primary = '#151515',
            secondary = '#1E1E1E',
            float = '#252525',
            highlight = '#303030',
        },
        fg = {
            primary = '#F8F8F8',
            secondary = '#E0E0E0',
            muted = '#B0B0B0',
            subtle = '#808080',
        },
        syntax = {
            func = '#9BA9B5',    -- Subtle blue-gray
            keyword = '#D4D4D4', -- Light gray
            string = '#A8A8A8',  -- Mid gray
            type = '#C0C0C0',    -- Silver gray
            const = '#B8B8B8',   -- Another mid gray
            special = '#949494', -- Darker gray
        },
        diag = {
            error = '#CF6679',
            warn = '#FFB86C',
            info = '#9BA9B5',
            hint = '#A8A8A8',
        },
    },

    -- Ku (空) - Sky theme
    ku = {
        bg = {
            primary = '#1A1B26',
            secondary = '#24283B',
            float = '#2F334D',
            highlight = '#3B4261',
        },
        fg = {
            primary = '#C0CAF5',
            secondary = '#A9B1D6',
            muted = '#9AA5CE',
            subtle = '#565F89',
        },
        syntax = {
            func = '#7AA2F7',    -- Soft blue
            keyword = '#BB9AF7', -- Gentle purple
            string = '#9ECE6A',  -- Calm green
            type = '#7DCFFF',    -- Sky blue
            const = '#FF9E64',   -- Soft orange
            special = '#2AC3DE', -- Light cyan
        },
        diag = {
            error = '#F7768E',
            warn = '#E0AF68',
            info = '#7AA2F7',
            hint = '#9ECE6A',
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
    
    return {
        -- Editor
        Normal = { fg = colors.fg.primary, bg = transparent_bg },
        NormalFloat = { fg = colors.fg.primary, bg = colors.bg.float },
        SignColumn = { bg = transparent_bg },
        LineNr = { fg = colors.fg.subtle },
        CursorLine = { bg = colors.bg.secondary },
        
        -- Syntax
        Function = { fg = colors.syntax.func },
        Keyword = { fg = colors.syntax.keyword },
        String = { fg = colors.syntax.string },
        Type = { fg = colors.syntax.type },
        Constant = { fg = colors.syntax.const },
        Special = { fg = colors.syntax.special },
        Comment = { fg = colors.fg.subtle, italic = true },
        
        -- Diagnostics
        DiagnosticError = { fg = colors.diag.error },
        DiagnosticWarn = { fg = colors.diag.warn },
        DiagnosticInfo = { fg = colors.diag.info },
        DiagnosticHint = { fg = colors.diag.hint },
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
    vim.g.colors_name = 'kimuku'
    
    -- Get colors and highlights
    local colors = M.get_colors()
    local highlights = M.get_highlights(colors)
    
    -- Apply highlights
    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

return M
