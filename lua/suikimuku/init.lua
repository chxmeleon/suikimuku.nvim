-- Suikimuku (翠輝無空) - Unified 4-Theme Architecture v2.0
-- Professional-grade Neovim theming platform with Japanese aesthetic philosophy
-- 
-- Four Themes Representing Natural Elements:
-- • Sui (翠) - Digital Aquarium: oceanic depth with teal luminescence  
-- • Ki (輝) - Crystal Light: pristine clarity with radiant precision
-- • Mu (無) - WCAG Grayscale: maximum contrast monochrome accessibility  
-- • Ku (空) - Enhanced Terminal: electric vibrancy in cosmic void
--
-- Features:
-- • Unified color system with mathematical OKLCH precision
-- • Comprehensive plugin ecosystem support (20+ plugins)  
-- • Advanced configuration with schema validation
-- • Backward compatibility with legacy configurations
-- • Plugin auto-detection and priority-based loading
-- • Theme-specific customization and user hooks
-- • Migration utilities and health checks

local M = {}

-- Version information
M.version = "2.0.0"
M.architecture = "unified"

-- Legacy compatibility flag
local has_legacy_config = false
local legacy_config = nil

-- Initialize core modules
local function init_core_modules()
    -- Initialize compatibility layer first
    local compat = require('suikimuku.core.compat')
    compat.init()
    
    -- Core systems
    M.core = require('suikimuku.core')
    M.config = require('suikimuku.core.config')
    M.colors = require('suikimuku.core.colors')
    M.plugins = require('suikimuku.plugins')
    
    -- Utilities
    M.migration = require('suikimuku.migration')
end

-- Legacy configuration detection and mapping
local function detect_legacy_config(user_config)
    if not user_config then return false, nil end
    
    local compat = require('suikimuku.core.compat')
    
    -- Check if this is a legacy configuration
    has_legacy_config = compat.migration.needs_migration(user_config)
    
    if has_legacy_config then
        -- Convert legacy configuration to new format
        legacy_config = user_config
        local converted = compat.migration.auto_migrate(user_config, {
            show_guide = false,
            warn = true
        })
        return true, converted
    end
    
    return false, user_config
end

-- Main setup function - Entry point for the unified architecture
function M.setup(user_config)
    -- Initialize core modules if not already done
    if not M.core then
        init_core_modules()
    end
    
    -- Handle legacy configuration detection and conversion
    local is_legacy, processed_config = detect_legacy_config(user_config)
    
    if is_legacy then
        -- Show migration information to user
        if processed_config.show_migration_guide then
            local migration_suggestions = M.migration.get_migration_suggestions(legacy_config)
            M.migration.print_migration_guide(legacy_config)
        end
    end
    
    -- Setup configuration system with processed config
    M.config.setup(processed_config)
    
    -- Load the colorscheme
    M.load()
end

-- Load colorscheme with specified style (optional)
function M.load(style)
    -- Initialize core modules if not already done
    if not M.core then
        init_core_modules()
    end
    
    -- Use core loading system
    M.core.load(style)
end

-- Get colors using the new unified system
function M.get_colors(style, format)
    if not M.colors then
        init_core_modules()
    end
    
    return M.colors.get(style, format)
end

-- Get configuration
function M.get_config()
    if not M.config then
        init_core_modules()
    end
    
    return M.config.get_config()
end

-- Get plugin information
function M.get_plugins_info()
    if not M.plugins then
        init_core_modules()
    end
    
    local config = M.get_config()
    return M.plugins.create_status_report(config)
end

-- Health check function
function M.health()
    local health = {
        status = "ok",
        version = M.version,
        architecture = M.architecture,
        issues = {},
        warnings = {},
        info = {}
    }
    
    -- Initialize modules if needed
    if not M.core then
        init_core_modules()
    end
    
    -- Core health checks
    table.insert(health.info, string.format("Suikimuku v%s (%s architecture)", M.version, M.architecture))
    
    -- Configuration health
    local config_health = M.config.health_check()
    for _, issue in ipairs(config_health.issues) do
        table.insert(health.issues, "Config: " .. issue)
        health.status = "error"
    end
    for _, warning in ipairs(config_health.warnings) do
        table.insert(health.warnings, "Config: " .. warning)
        if health.status == "ok" then health.status = "warning" end
    end
    
    -- Compatibility health
    local compat = require('suikimuku.core.compat')
    local compat_health = compat.health_check()
    for _, issue in ipairs(compat_health.issues) do
        table.insert(health.issues, "Compatibility: " .. issue)
        health.status = "error"
    end
    for _, warning in ipairs(compat_health.warnings) do
        table.insert(health.warnings, "Compatibility: " .. warning)
        if health.status == "ok" then health.status = "warning" end
    end
    
    -- Migration health
    local migration_health = M.migration.health_check()
    for _, issue in ipairs(migration_health.issues) do
        table.insert(health.issues, "Migration: " .. issue)
        health.status = "error"
    end
    for _, warning in ipairs(migration_health.warnings) do
        table.insert(health.warnings, "Migration: " .. warning)
        if health.status == "ok" then health.status = "warning" end  
    end
    
    -- Plugin detection health
    local plugin_report = M.get_plugins_info()
    table.insert(health.info, string.format("Detected plugins: %d/%d", plugin_report.total_detected, plugin_report.total_registered))
    table.insert(health.info, string.format("Enabled plugins: %d", plugin_report.total_enabled))
    
    return health
end

-- Development and debugging utilities
M.debug = {}

function M.debug.inspect_config()
    local config = M.get_config()
    print("Current Configuration:")
    print(vim.inspect(config))
end

function M.debug.inspect_colors(style)
    local colors = M.get_colors(style)
    print(string.format("Colors for style '%s':", style or "current"))
    print(vim.inspect(colors))
end

function M.debug.test_plugin(plugin_key, style)
    if not M.plugins then
        init_core_modules()
    end
    
    local result = M.plugins.test_plugin_highlights(plugin_key, style)
    print("Plugin Test Results:")
    print(vim.inspect(result))
    return result
end

function M.debug.validate_plugins()
    if not M.plugins then
        init_core_modules()
    end
    
    local results = {}
    for plugin_key, _ in pairs(M.plugins.registry) do
        local valid, error, warnings = M.plugins.validate_plugin_module(plugin_key)
        results[plugin_key] = {
            valid = valid,
            error = error,
            warnings = warnings or {}
        }
    end
    
    print("Plugin Validation Results:")
    print(vim.inspect(results))
    return results
end

-- Migration utilities exposed at top level
function M.migrate(config)
    return M.migration.run_migration(config, { interactive = false })
end

function M.migration_wizard()
    return M.migration.migration_wizard()
end

-- Legacy API compatibility (deprecated but functional)
function M.get_theme_colors(style)
    M.deprecation = M.deprecation or require('suikimuku.core.compat').deprecation
    M.deprecation.warn("M.get_theme_colors()", "M.get_colors()", "v2.1")
    M.deprecation.log_usage("get_theme_colors")
    
    local compat = require('suikimuku.core.compat')
    return compat.legacy_api.get_colors(style)
end

-- Legacy setup (deprecated but functional)  
function M.load_legacy(style)
    M.deprecation = M.deprecation or require('suikimuku.core.compat').deprecation
    M.deprecation.warn("M.load_legacy()", "M.load()", "v2.1")
    M.deprecation.log_usage("load_legacy")
    
    local compat = require('suikimuku.core.compat')
    return compat.legacy_api.load(style)
end

-- Expose core modules for advanced usage
M.modules = {
    core = function() return M.core end,
    config = function() return M.config end,
    colors = function() return M.colors end,
    plugins = function() return M.plugins end,
    migration = function() return M.migration end,
}

-- User commands setup
local function setup_user_commands()
    -- Main colorscheme command
    vim.api.nvim_create_user_command('SuikimukuLoad', function(opts)
        local style = opts.args ~= '' and opts.args or nil
        M.load(style)
    end, {
        nargs = '?',
        complete = function()
            return {'sui', 'ki', 'mu', 'ku'}
        end,
        desc = 'Load Suikimuku colorscheme with optional style'
    })
    
    -- Health check command
    vim.api.nvim_create_user_command('SuikimukuHealth', function()
        local health = M.health()
        print("🎨 Suikimuku Health Check")
        print("========================")
        print(string.format("Status: %s", health.status))
        print(string.format("Version: %s", health.version))
        print()
        
        if #health.issues > 0 then
            print("Issues:")
            for _, issue in ipairs(health.issues) do
                print("  ❌ " .. issue)
            end
            print()
        end
        
        if #health.warnings > 0 then
            print("Warnings:")
            for _, warning in ipairs(health.warnings) do
                print("  ⚠️  " .. warning)
            end
            print()
        end
        
        if #health.info > 0 then
            print("Info:")
            for _, info in ipairs(health.info) do
                print("  ℹ️  " .. info)
            end
        end
    end, { desc = 'Run Suikimuku health check' })
    
    -- Migration wizard command
    vim.api.nvim_create_user_command('SuikimukuMigrate', function()
        M.migration_wizard()
    end, { desc = 'Run Suikimuku migration wizard' })
    
    -- Plugin info command  
    vim.api.nvim_create_user_command('SuikimukuPlugins', function()
        local info = M.get_plugins_info()
        print("🔌 Suikimuku Plugin Status")
        print("=========================")
        print(string.format("Total registered: %d", info.total_registered))
        print(string.format("Total detected: %d", info.total_detected))
        print(string.format("Total enabled: %d", info.total_enabled))
        print()
        
        for plugin_key, plugin_info in pairs(info.plugins) do
            local status_icon = plugin_info.status == "active" and "✅" or 
                               plugin_info.status == "disabled" and "⚠️" or "❌"
            local module_icon = plugin_info.module_available and "📦" or "📋"
            print(string.format("%s %s %s - %s", status_icon, module_icon, plugin_key, plugin_info.name))
        end
    end, { desc = 'Show Suikimuku plugin status' })
end

-- Auto-setup user commands when module loads
setup_user_commands()

return M
