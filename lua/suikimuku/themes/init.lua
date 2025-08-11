-- Theme Manager for Suikimuku.nvim
-- Coordinates theme loading, validation, and provides theme-specific utilities

local colors = require("suikimuku.core.colors")
local M = {}

-- Available themes with metadata
M.themes = {
    sui = {
        name = "翠 (Sui) - Digital Aquarium",
        description = "Deep ocean depths with bioluminescent electric accents",
        philosophy = "Immersive underwater coding environment with electric blue highlights",
        default_transparent = false,
        color_temperature = "cool",
        primary_colors = {"teal", "blue", "green"},
        ideal_for = {"deep focus", "contemplative coding", "aquatic aesthetics"}
    },
    ki = {
        name = "輝 (Ki) - Crystal Radiant Light",  
        description = "Pure crystal clarity with cool luminous highlights",
        philosophy = "Morning light through crystal, maximum clarity with gentle warmth",
        default_transparent = false,
        color_temperature = "cool_light",
        primary_colors = {"blue", "purple", "teal"},
        ideal_for = {"bright environments", "focused work", "minimal distractions"}
    },
    mu = {
        name = "無 (Mu) - WCAG AAA Grayscale",
        description = "High-contrast monochrome with subtle gray variations", 
        philosophy = "Maximum readability with zero color distractions",
        default_transparent = false,
        color_temperature = "neutral",
        primary_colors = {"gray"},
        ideal_for = {"accessibility", "colorblind users", "distraction-free coding"}
    },
    ku = {
        name = "空 (Ku) - Enhanced Vibrant Terminal",
        description = "Electric cyberpunk with high-saturation neon colors",
        philosophy = "Deep space with electric neon highlights, cyberpunk terminal harmony",
        default_transparent = true,
        color_temperature = "varied_electric", 
        primary_colors = {"cyan", "purple", "green", "orange"},
        ideal_for = {"terminal workflows", "vibrant aesthetics", "high contrast"]
    }
}

-- Theme-specific defaults and overrides
M.defaults = {
    sui = {
        transparent = false,
        opacity = 1.0,
        contrast = "normal",
        variant = "standard"
    },
    ki = {
        transparent = false,
        opacity = 1.0,
        contrast = "high",
        variant = "standard"
    },
    mu = {
        transparent = false,
        opacity = 1.0,
        contrast = "maximum",
        variant = "standard"
    },
    ku = {
        transparent = true,
        opacity = 0.85,
        contrast = "high",
        variant = "standard"
    }
}

-- Load theme-specific module
function M.load_theme(theme_name)
    local theme_module_path = "suikimuku.themes." .. theme_name
    local ok, theme_module = pcall(require, theme_module_path)
    
    if not ok then
        -- Fallback to core colors if theme module doesn't exist
        return {
            colors = colors.get(theme_name, 'legacy'),
            metadata = M.themes[theme_name] or {}
        }
    end
    
    return theme_module
end

-- Get theme metadata
function M.get_theme_info(theme_name)
    return M.themes[theme_name] or {}
end

-- Get all available theme names
function M.get_available_themes()
    local theme_names = {}
    for name, _ in pairs(M.themes) do
        table.insert(theme_names, name)
    end
    return theme_names
end

-- Validate theme name
function M.validate_theme(theme_name)
    return M.themes[theme_name] ~= nil
end

-- Get theme defaults
function M.get_defaults(theme_name)
    return vim.deepcopy(M.defaults[theme_name] or {})
end

-- Get theme-appropriate settings
function M.get_theme_settings(theme_name, user_config)
    local defaults = M.get_defaults(theme_name)
    local theme_info = M.get_theme_info(theme_name)
    
    -- Merge user config with theme defaults
    local settings = vim.tbl_deep_extend("force", defaults, user_config or {})
    
    -- Apply theme-specific overrides if transparency not explicitly set
    if user_config.transparent == nil then
        settings.transparent = theme_info.default_transparent or false
    end
    
    return settings
end

-- Generate theme variants (future expansion)
function M.get_variants(theme_name)
    -- Currently only standard variant, but could include:
    -- - "soft" (reduced contrast)
    -- - "bright" (enhanced contrast)  
    -- - "minimal" (fewer colors)
    -- - "saturated" (higher chroma)
    return {"standard"}
end

-- Theme switching utilities
function M.setup_theme_switching()
    -- Create theme switching commands
    vim.api.nvim_create_user_command('SuikimukuTheme', function(opts)
        local theme = opts.args
        if M.validate_theme(theme) then
            require('suikimuku').setup({ style = theme })
            vim.notify("Switched to " .. M.themes[theme].name, vim.log.levels.INFO)
        else
            vim.notify("Unknown theme: " .. theme, vim.log.levels.ERROR)
        end
    end, {
        nargs = 1,
        complete = function()
            return M.get_available_themes()
        end,
        desc = "Switch Suikimuku theme"
    })
    
    -- Create cycle command
    vim.api.nvim_create_user_command('SuikimukuCycle', function()
        local current = vim.g.suikimuku_current_theme or 'sui'
        local themes = M.get_available_themes()
        local current_idx = 1
        
        for i, theme in ipairs(themes) do
            if theme == current then
                current_idx = i
                break
            end
        end
        
        local next_idx = (current_idx % #themes) + 1
        local next_theme = themes[next_idx]
        
        require('suikimuku').setup({ style = next_theme })
        vim.notify("Cycled to " .. M.themes[next_theme].name, vim.log.levels.INFO)
    end, {
        desc = "Cycle through Suikimuku themes"
    })
end

-- Theme analysis and recommendations
function M.analyze_environment()
    local analysis = {
        time_of_day = tonumber(os.date("%H")),
        terminal_colors = vim.fn.has("termguicolors") == 1,
        background = vim.o.background,
        environment = "unknown"
    }
    
    -- Simple environment detection
    if vim.env.SSH_TTY then
        analysis.environment = "ssh"
    elseif vim.env.TMUX then
        analysis.environment = "tmux"
    elseif vim.env.TERM_PROGRAM then
        analysis.environment = vim.env.TERM_PROGRAM:lower()
    end
    
    return analysis
end

function M.recommend_theme()
    local env = M.analyze_environment()
    local recommendations = {}
    
    -- Time-based recommendations
    if env.time_of_day >= 6 and env.time_of_day < 18 then
        table.insert(recommendations, {theme = "ki", reason = "Daytime - bright environment"})
    else
        table.insert(recommendations, {theme = "sui", reason = "Evening - immersive coding"})
    end
    
    -- Environment-based recommendations  
    if env.environment == "ssh" or env.environment == "tmux" then
        table.insert(recommendations, {theme = "ku", reason = "Terminal environment"})
    end
    
    -- Accessibility recommendation
    table.insert(recommendations, {theme = "mu", reason = "Maximum accessibility"})
    
    return recommendations
end

-- Theme compatibility checks
function M.check_compatibility(theme_name)
    local issues = {}
    local warnings = {}
    
    -- Check terminal color support
    if vim.fn.has("termguicolors") == 0 then
        table.insert(warnings, "termguicolors not enabled - colors may not display correctly")
    end
    
    -- Check theme-specific requirements
    if theme_name == "ku" and not vim.env.TERM_PROGRAM then
        table.insert(warnings, "Ku theme optimized for modern terminal emulators")
    end
    
    if theme_name == "ki" and vim.o.background == "dark" then
        table.insert(warnings, "Ki theme designed for light backgrounds")
    end
    
    return {
        issues = issues,
        warnings = warnings,
        compatible = #issues == 0
    }
end

-- Theme export utilities (for future external theme generation)
function M.export_theme(theme_name, format)
    format = format or "neovim"
    
    if format == "neovim" then
        return colors.get(theme_name, 'legacy')
    elseif format == "terminal" then
        -- Export as terminal colors
        local theme_colors = colors.get(theme_name, 'hex')
        return {
            background = theme_colors.bg_primary,
            foreground = theme_colors.fg_primary,
            black = theme_colors.bg_primary,
            red = theme_colors.red_primary,
            green = theme_colors.green_primary,
            yellow = theme_colors.orange_primary,
            blue = theme_colors.blue_primary,
            magenta = theme_colors.purple_primary,
            cyan = theme_colors.teal_primary,
            white = theme_colors.fg_primary,
            -- Bright variants
            bright_black = theme_colors.bg_highlight,
            bright_red = theme_colors.red_bright,
            bright_green = theme_colors.green_bright,
            bright_yellow = theme_colors.orange_bright,
            bright_blue = theme_colors.blue_bright,
            bright_magenta = theme_colors.purple_bright,
            bright_cyan = theme_colors.teal_bright,
            bright_white = theme_colors.fg_muted
        }
    else
        error("Unknown export format: " .. format)
    end
end

return M