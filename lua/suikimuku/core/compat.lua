-- Compatibility Layer for Suikimuku.nvim
-- Ensures backward compatibility with existing configurations and APIs

local M = {}

-- Legacy configuration mapping
M.legacy_config_map = {
    -- Old style names to new style names
    style_map = {
        ["suikimuku-sui"] = "sui",
        ["suikimuku-ki"] = "ki", 
        ["suikimuku-mu"] = "mu",
        ["suikimuku-ku"] = "ku",
        -- Legacy short forms
        ["s"] = "sui",
        ["k"] = "ki",
        ["m"] = "mu",
        ["c"] = "ku", -- 'c' for 'command' (ku theme)
    },
    
    -- Legacy option mappings
    option_map = {
        -- Old colorscheme options
        transparent_background = "transparency.background",
        transparent_sidebar = "transparency.sidebar", 
        transparent_float = "transparency.floating_windows",
        italic_comments = "syntax.italic_comments",
        italic_keywords = "syntax.italic_keywords",
        italic_functions = "syntax.italic_functions",
        italic_variables = "syntax.italic_variables",
        bold_functions = "syntax.bold_functions",
        bold_variables = "syntax.bold_variables",
        
        -- Legacy plugin options  
        telescope_style = "plugins.telescope.style",
        nvim_tree_transparency = "plugins.nvim_tree.transparency",
        lualine_integration = "plugins.lualine.theme_integration",
        gitsigns_line_hl = "plugins.gitsigns.line_highlights",
        
        -- Color customization (legacy format)
        colors = "colors.custom",
        color_overrides = "colors.overrides",
    }
}

-- Legacy API functions for backward compatibility
M.legacy_api = {}

-- Get colors in legacy format (for older plugins/configs expecting old structure)
function M.legacy_api.get_colors(style)
    local colors_module = require("suikimuku.core.colors")
    local unified_colors = colors_module.get(style or "sui", "legacy")
    
    -- Convert to legacy format that older integrations might expect
    local legacy_colors = {
        -- Primary colors (legacy names)
        bg = unified_colors.bg.primary,
        fg = unified_colors.fg.primary,
        bg_dark = unified_colors.bg.secondary,
        fg_dark = unified_colors.fg.secondary,
        bg_float = unified_colors.bg.float,
        bg_highlight = unified_colors.bg.highlight,
        
        -- Named colors (legacy format)
        black = unified_colors.bg.primary,
        white = unified_colors.fg.primary,
        red = unified_colors.red.primary,
        green = unified_colors.green.primary, 
        yellow = unified_colors.yellow.primary,
        blue = unified_colors.blue.primary,
        magenta = unified_colors.purple.primary,
        cyan = unified_colors.teal.primary,
        orange = unified_colors.orange.primary,
        
        -- Legacy bright variants
        bright_red = unified_colors.red.bright or unified_colors.red.primary,
        bright_green = unified_colors.green.bright or unified_colors.green.primary,
        bright_yellow = unified_colors.yellow.bright or unified_colors.yellow.primary,
        bright_blue = unified_colors.blue.bright or unified_colors.blue.primary,
        bright_magenta = unified_colors.purple.bright or unified_colors.purple.primary,
        bright_cyan = unified_colors.teal.bright or unified_colors.teal.primary,
        
        -- Legacy terminal colors
        terminal_black = unified_colors.bg.primary,
        terminal_red = unified_colors.red.primary,
        terminal_green = unified_colors.green.primary,
        terminal_yellow = unified_colors.yellow.primary,
        terminal_blue = unified_colors.blue.primary,
        terminal_magenta = unified_colors.purple.primary,
        terminal_cyan = unified_colors.teal.primary,
        terminal_white = unified_colors.fg.primary,
        
        -- Comment and subtle colors
        comment = unified_colors.fg.subtle,
        muted = unified_colors.fg.muted,
        subtle = unified_colors.fg.subtle,
        
        -- Special UI colors
        none = "NONE",
        selection = unified_colors.bg.highlight,
        search = unified_colors.bg.search or unified_colors.bg.highlight,
        menu = unified_colors.bg.float,
    }
    
    return legacy_colors
end

-- Setup colorscheme with legacy configuration format
function M.legacy_api.setup(opts)
    opts = opts or {}
    
    -- Convert legacy options to new format
    local new_config = M.convert_legacy_config(opts)
    
    -- Setup using new configuration system
    local config_module = require("suikimuku.core.config")
    config_module.setup(new_config)
    
    -- Apply colorscheme
    local core = require("suikimuku.core")
    core.load()
end

-- Load colorscheme with legacy style name
function M.legacy_api.load(style_name)
    style_name = style_name or "sui"
    
    -- Convert legacy style name
    local new_style = M.legacy_config_map.style_map[style_name] or style_name
    
    -- Load using new system
    local core = require("suikimuku.core")
    core.load(new_style)
end

-- Get theme colors (legacy function name)
function M.legacy_api.get_theme_colors(style)
    return M.legacy_api.get_colors(style)
end

-- Convert legacy configuration to new format
function M.convert_legacy_config(legacy_config)
    local new_config = {}
    
    -- Convert style name
    if legacy_config.style then
        new_config.style = M.legacy_config_map.style_map[legacy_config.style] or legacy_config.style
    end
    
    -- Convert options using mapping table
    for legacy_key, legacy_value in pairs(legacy_config) do
        local new_path = M.legacy_config_map.option_map[legacy_key]
        
        if new_path then
            -- Set nested value using dot notation path
            M.set_nested_value(new_config, new_path, legacy_value)
        elseif legacy_key ~= "style" then
            -- Pass through unmapped options (might be new format already)
            new_config[legacy_key] = legacy_value
        end
    end
    
    -- Handle special legacy configurations
    if legacy_config.transparent then
        -- Old boolean transparent option
        new_config.transparency = new_config.transparency or {}
        new_config.transparency.background = legacy_config.transparent
        new_config.transparency.sidebar = legacy_config.transparent
        new_config.transparency.floating_windows = legacy_config.transparent
    end
    
    if legacy_config.italic_comments ~= nil then
        new_config.syntax = new_config.syntax or {}
        new_config.syntax.italic_comments = legacy_config.italic_comments
    end
    
    -- Handle legacy plugin configurations
    if legacy_config.plugins then
        new_config.plugins = new_config.plugins or {}
        
        -- Convert legacy plugin configs
        for plugin_name, plugin_config in pairs(legacy_config.plugins) do
            if type(plugin_config) == "boolean" then
                -- Legacy: plugins.telescope = true/false
                new_config.plugins[plugin_name] = { enabled = plugin_config }
            else
                -- Legacy: plugins.telescope = { ... }
                new_config.plugins[plugin_name] = plugin_config
            end
        end
    end
    
    return new_config
end

-- Utility function to set nested values from dot notation
function M.set_nested_value(table, path, value)
    local keys = vim.split(path, ".", { plain = true })
    local current = table
    
    -- Navigate to parent of target key
    for i = 1, #keys - 1 do
        local key = keys[i]
        if current[key] == nil then
            current[key] = {}
        end
        current = current[key]
    end
    
    -- Set the final value
    current[keys[#keys]] = value
end

-- Migration helpers
function M.migration = {}

-- Check if user is using legacy configuration
function M.migration.needs_migration(config)
    if not config then
        return false
    end
    
    -- Check for legacy style names
    if config.style and M.legacy_config_map.style_map[config.style] then
        return true
    end
    
    -- Check for legacy option names
    for legacy_key, _ in pairs(M.legacy_config_map.option_map) do
        if config[legacy_key] ~= nil then
            return true
        end
    end
    
    -- Check for legacy transparent option
    if config.transparent ~= nil then
        return true
    end
    
    return false
end

-- Generate migration suggestions
function M.migration.get_migration_suggestions(legacy_config)
    local suggestions = {}
    local converted = M.convert_legacy_config(legacy_config)
    
    suggestions.converted_config = converted
    suggestions.changes = {}
    
    -- Document specific changes
    if legacy_config.style and M.legacy_config_map.style_map[legacy_config.style] then
        table.insert(suggestions.changes, {
            type = "style_rename",
            old = legacy_config.style,
            new = M.legacy_config_map.style_map[legacy_config.style],
            description = string.format("Style '%s' renamed to '%s'", 
                legacy_config.style, M.legacy_config_map.style_map[legacy_config.style])
        })
    end
    
    for legacy_key, value in pairs(legacy_config) do
        local new_path = M.legacy_config_map.option_map[legacy_key]
        if new_path then
            table.insert(suggestions.changes, {
                type = "option_move", 
                old = legacy_key,
                new = new_path,
                description = string.format("Option '%s' moved to '%s'", legacy_key, new_path)
            })
        end
    end
    
    return suggestions
end

-- Print migration guide for user
function M.migration.print_migration_guide(legacy_config)
    local suggestions = M.migration.get_migration_suggestions(legacy_config)
    
    print("🔄 Suikimuku.nvim Configuration Migration")
    print("========================================")
    print()
    print("Your configuration uses legacy options. Here's how to update:")
    print()
    
    for _, change in ipairs(suggestions.changes) do
        print("• " .. change.description)
    end
    
    print()
    print("Updated configuration:")
    print("require('suikimuku').setup({")
    
    -- Pretty print the converted config
    local function print_table(t, indent)
        indent = indent or "  "
        for k, v in pairs(t) do
            if type(v) == "table" then
                print(indent .. k .. " = {")
                print_table(v, indent .. "  ")
                print(indent .. "},")
            elseif type(v) == "string" then
                print(indent .. k .. " = '" .. v .. "',")
            else
                print(indent .. k .. " = " .. tostring(v) .. ",")
            end
        end
    end
    
    print_table(suggestions.converted_config)
    print("})")
    print()
end

-- Automatic migration (with user consent)
function M.migration.auto_migrate(legacy_config, opts)
    opts = opts or {}
    
    if not M.migration.needs_migration(legacy_config) then
        return legacy_config -- No migration needed
    end
    
    if opts.show_guide then
        M.migration.print_migration_guide(legacy_config)
    end
    
    if opts.warn then
        print("⚠️  Warning: Using legacy Suikimuku configuration format.")
        print("   Consider updating to the new format for better features.")
        print("   Set `show_migration_guide = true` to see update instructions.")
        print()
    end
    
    return M.convert_legacy_config(legacy_config)
end

-- Legacy command compatibility
M.commands = {}

-- Legacy colorscheme command support
function M.commands.setup_legacy_commands()
    -- Support old :colorscheme suikimuku-* commands
    local legacy_schemes = {
        "suikimuku-sui",
        "suikimuku-ki", 
        "suikimuku-mu",
        "suikimuku-ku"
    }
    
    for _, scheme in ipairs(legacy_schemes) do
        local style = M.legacy_config_map.style_map[scheme]
        if style then
            vim.api.nvim_create_user_command(
                "colorscheme " .. scheme,
                function()
                    M.legacy_api.load(style)
                end,
                { desc = "Load " .. scheme .. " colorscheme (legacy)" }
            )
        end
    end
end

-- Deprecation warnings
M.deprecation = {}

-- Issue deprecation warning for legacy functions
function M.deprecation.warn(old_function, new_function, version)
    version = version or "v2.0"
    local message = string.format(
        "⚠️  DEPRECATED: %s is deprecated and will be removed in %s. Use %s instead.", 
        old_function, version, new_function
    )
    print(message)
end

-- Track usage of deprecated features
M.deprecation.usage_log = {}

function M.deprecation.log_usage(feature)
    M.deprecation.usage_log[feature] = (M.deprecation.usage_log[feature] or 0) + 1
end

-- Get deprecation report
function M.deprecation.get_report()
    if vim.tbl_count(M.deprecation.usage_log) == 0 then
        return "No deprecated features detected."
    end
    
    local report = "Deprecated feature usage:\n"
    for feature, count in pairs(M.deprecation.usage_log) do
        report = report .. string.format("  • %s: used %d times\n", feature, count)
    end
    
    return report
end

-- Initialize compatibility layer
function M.init()
    -- Make legacy API available globally for backward compatibility  
    _G.suikimuku_legacy = M.legacy_api
    
    -- Setup legacy commands if needed
    M.commands.setup_legacy_commands()
end

-- Health check for compatibility issues
function M.health_check()
    local health = {
        issues = {},
        warnings = {},
        info = {}
    }
    
    -- Check for legacy global variables
    if _G.suikimuku_config then
        table.insert(health.warnings, "Found legacy global 'suikimuku_config'. Consider using require('suikimuku').setup() instead.")
    end
    
    -- Check for deprecated usage
    if vim.tbl_count(M.deprecation.usage_log) > 0 then
        table.insert(health.warnings, "Deprecated features in use. Run :lua print(require('suikimuku.core.compat').deprecation.get_report()) for details.")
    end
    
    table.insert(health.info, "Compatibility layer initialized successfully")
    
    return health
end

return M