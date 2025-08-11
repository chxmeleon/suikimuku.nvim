-- Plugin Infrastructure Framework for Suikimuku.nvim
-- Modular system for automatic plugin detection and highlight integration

local M = {}

-- Plugin registry with metadata
M.registry = {
    telescope = {
        name = "telescope.nvim",
        detect_patterns = {"telescope", "telescope.builtin"},
        config_key = "telescope",
        priority = 100,
        description = "Fuzzy finder and picker",
        url = "https://github.com/nvim-telescope/telescope.nvim"
    },
    
    nvim_tree = {
        name = "nvim-tree.lua",
        detect_patterns = {"nvim-tree", "nvim-tree.api"},
        config_key = "nvim_tree", 
        priority = 90,
        description = "File explorer",
        url = "https://github.com/nvim-tree/nvim-tree.lua"
    },
    
    neo_tree = {
        name = "neo-tree.nvim",
        detect_patterns = {"neo-tree"},
        config_key = "neo_tree",
        priority = 89,
        description = "Modern file explorer",
        url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
    },
    
    lualine = {
        name = "lualine.nvim", 
        detect_patterns = {"lualine"},
        config_key = "lualine",
        priority = 85,
        description = "Status line",
        url = "https://github.com/nvim-lualine/lualine.nvim"
    },
    
    bufferline = {
        name = "bufferline.nvim",
        detect_patterns = {"bufferline"},
        config_key = "bufferline",
        priority = 80,
        description = "Buffer tabs",
        url = "https://github.com/akinsho/bufferline.nvim"
    },
    
    gitsigns = {
        name = "gitsigns.nvim",
        detect_patterns = {"gitsigns"},
        config_key = "gitsigns",
        priority = 75,
        description = "Git integration",
        url = "https://github.com/lewis6991/gitsigns.nvim"
    },
    
    cmp = {
        name = "nvim-cmp",
        detect_patterns = {"cmp", "nvim-cmp"},
        config_key = "cmp",
        priority = 70,
        description = "Completion engine",
        url = "https://github.com/hrsh7th/nvim-cmp"
    },
    
    treesitter = {
        name = "nvim-treesitter", 
        detect_patterns = {"nvim-treesitter", "treesitter"},
        config_key = "treesitter",
        priority = 65,
        description = "Syntax highlighting",
        url = "https://github.com/nvim-treesitter/nvim-treesitter"
    },
    
    which_key = {
        name = "which-key.nvim",
        detect_patterns = {"which-key"},
        config_key = "which_key",
        priority = 60,
        description = "Key binding helper",
        url = "https://github.com/folke/which-key.nvim"
    },
    
    trouble = {
        name = "trouble.nvim",
        detect_patterns = {"trouble"},
        config_key = "trouble", 
        priority = 55,
        description = "Diagnostics viewer",
        url = "https://github.com/folke/trouble.nvim"
    },
    
    toggleterm = {
        name = "toggleterm.nvim",
        detect_patterns = {"toggleterm"},
        config_key = "toggleterm",
        priority = 50,
        description = "Terminal integration",
        url = "https://github.com/akinsho/toggleterm.nvim"
    },
    
    indent_blankline = {
        name = "indent-blankline.nvim",
        detect_patterns = {"ibl", "indent_blankline", "indent-blankline"},
        config_key = "indent_blankline",
        priority = 45,
        description = "Indentation guides",
        url = "https://github.com/lukas-reineke/indent-blankline.nvim"
    },
    
    mason = {
        name = "mason.nvim",
        detect_patterns = {"mason"},
        config_key = "mason",
        priority = 40,
        description = "LSP installer",
        url = "https://github.com/williamboman/mason.nvim"
    },
    
    notify = {
        name = "nvim-notify", 
        detect_patterns = {"notify"},
        config_key = "notify",
        priority = 35,
        description = "Notification system",
        url = "https://github.com/rcarriga/nvim-notify"
    },
    
    neogit = {
        name = "neogit",
        detect_patterns = {"neogit"},
        config_key = "neogit", 
        priority = 30,
        description = "Git interface",
        url = "https://github.com/NeogitOrg/neogit"
    },
    
    diffview = {
        name = "diffview.nvim",
        detect_patterns = {"diffview"},
        config_key = "diffview",
        priority = 25,
        description = "Git diff viewer", 
        url = "https://github.com/sindrets/diffview.nvim"
    },
    
    hop = {
        name = "hop.nvim",
        detect_patterns = {"hop"},
        config_key = "hop",
        priority = 20,
        description = "Motion navigation",
        url = "https://github.com/phaazon/hop.nvim"
    },
    
    aerial = {
        name = "aerial.nvim",
        detect_patterns = {"aerial"},
        config_key = "aerial",
        priority = 15,
        description = "Symbol outline",
        url = "https://github.com/stevearc/aerial.nvim"
    },
    
    dashboard = {
        name = "dashboard-nvim",
        detect_patterns = {"dashboard"},
        config_key = "dashboard",
        priority = 10,
        description = "Start screen",
        url = "https://github.com/nvimdev/dashboard-nvim"
    },
    
    alpha = {
        name = "alpha-nvim",
        detect_patterns = {"alpha"},
        config_key = "alpha",
        priority = 9,
        description = "Start screen", 
        url = "https://github.com/goolord/alpha-nvim"
    }
}

-- Cache for detected plugins
M._detected_cache = nil
M._loaded_plugins = {}

-- Plugin detection functions
function M.detect_plugin(plugin_key)
    local plugin_info = M.registry[plugin_key]
    if not plugin_info then
        return false
    end
    
    -- Try to require each detection pattern
    for _, pattern in ipairs(plugin_info.detect_patterns) do
        local ok, _ = pcall(require, pattern)
        if ok then
            return true
        end
    end
    
    return false
end

-- Detect all available plugins
function M.detect_all_plugins()
    if M._detected_cache then
        return M._detected_cache
    end
    
    local detected = {}
    
    for plugin_key, plugin_info in pairs(M.registry) do
        if M.detect_plugin(plugin_key) then
            detected[plugin_key] = plugin_info
        end
    end
    
    -- Sort by priority (higher priority first)
    local sorted_plugins = {}
    for key, info in pairs(detected) do
        table.insert(sorted_plugins, {key = key, info = info})
    end
    
    table.sort(sorted_plugins, function(a, b)
        return a.info.priority > b.info.priority
    end)
    
    -- Cache result
    M._detected_cache = {
        plugins = detected,
        sorted = sorted_plugins,
        count = #sorted_plugins
    }
    
    return M._detected_cache
end

-- Load plugin highlight module
function M.load_plugin_module(plugin_key)
    if M._loaded_plugins[plugin_key] then
        return M._loaded_plugins[plugin_key]
    end
    
    local module_path = "suikimuku.plugins." .. plugin_key
    local ok, plugin_module = pcall(require, module_path)
    
    if not ok then
        -- Plugin not implemented yet, return nil
        return nil
    end
    
    -- Cache the loaded module
    M._loaded_plugins[plugin_key] = plugin_module
    return plugin_module
end

-- Get highlights for a specific plugin
function M.get_plugin_highlights(plugin_key, colors, config)
    local plugin_module = M.load_plugin_module(plugin_key)
    if not plugin_module then
        return {}
    end
    
    local plugin_config = config.plugins[plugin_key] or {}
    
    -- Check if plugin is enabled in config
    if plugin_config.enabled == false then
        return {}
    end
    
    -- Get highlights from plugin module
    if type(plugin_module.highlights) == "function" then
        return plugin_module.highlights(colors, plugin_config, config)
    elseif type(plugin_module.highlights) == "table" then
        return plugin_module.highlights
    end
    
    return {}
end

-- Get highlights for all detected and enabled plugins
function M.get_all_plugin_highlights(colors, config)
    local all_highlights = {}
    local detected = M.detect_all_plugins()
    
    -- Process plugins in priority order
    for _, plugin_data in ipairs(detected.sorted) do
        local plugin_key = plugin_data.key
        local highlights = M.get_plugin_highlights(plugin_key, colors, config)
        
        -- Merge highlights (later plugins can override earlier ones with same priority)
        all_highlights = vim.tbl_deep_extend("force", all_highlights, highlights)
    end
    
    return all_highlights
end

-- Get only enabled plugins from config
function M.get_enabled_plugins(config)
    local enabled = {}
    local detected = M.detect_all_plugins()
    
    for plugin_key, _ in pairs(detected.plugins) do
        local plugin_config = config.plugins[plugin_key] or {}
        
        if plugin_config.enabled ~= false then -- Default is enabled
            enabled[plugin_key] = true
        end
    end
    
    return enabled
end

-- Plugin information and diagnostics
function M.get_plugin_info(plugin_key)
    return M.registry[plugin_key]
end

function M.get_detected_plugins_info()
    local detected = M.detect_all_plugins()
    local info = {}
    
    for plugin_key, plugin_info in pairs(detected.plugins) do
        local module_available = M.load_plugin_module(plugin_key) ~= nil
        
        info[plugin_key] = {
            name = plugin_info.name,
            description = plugin_info.description,
            priority = plugin_info.priority,
            url = plugin_info.url,
            detected = true,
            module_available = module_available,
            highlights_count = module_available and 
                vim.tbl_count(M.get_plugin_highlights(plugin_key, {}, {})) or 0
        }
    end
    
    return info
end

-- Create plugin status report
function M.create_status_report(config)
    local detected = M.detect_all_plugins()
    local enabled = M.get_enabled_plugins(config)
    
    local report = {
        total_registered = vim.tbl_count(M.registry),
        total_detected = detected.count,
        total_enabled = vim.tbl_count(enabled),
        plugins = {}
    }
    
    -- Add details for each plugin
    for plugin_key, plugin_info in pairs(M.registry) do
        local is_detected = detected.plugins[plugin_key] ~= nil
        local is_enabled = enabled[plugin_key] == true
        local module_available = M.load_plugin_module(plugin_key) ~= nil
        
        report.plugins[plugin_key] = {
            name = plugin_info.name,
            detected = is_detected,
            enabled = is_enabled, 
            module_available = module_available,
            priority = plugin_info.priority,
            status = is_detected and (is_enabled and "active" or "disabled") or "not_detected"
        }
    end
    
    return report
end

-- Plugin management utilities
function M.refresh_detection()
    M._detected_cache = nil
    return M.detect_all_plugins()
end

function M.clear_plugin_cache()
    M._detected_cache = nil
    M._loaded_plugins = {}
end

-- Configuration helpers
function M.get_default_plugin_config(plugin_key)
    local config = require("suikimuku.core.config")
    local schema = config.get_schema()
    
    if schema.plugins and schema.plugins.schema and schema.plugins.schema[plugin_key] then
        local plugin_schema = schema.plugins.schema[plugin_key]
        local defaults = {}
        
        if plugin_schema.schema then
            for key, field_schema in pairs(plugin_schema.schema) do
                defaults[key] = field_schema.default
            end
        end
        
        return defaults
    end
    
    return {enabled = true}
end

-- Debug and development utilities
function M.validate_plugin_module(plugin_key)
    local plugin_module = M.load_plugin_module(plugin_key)
    
    if not plugin_module then
        return false, "Module not found"
    end
    
    -- Check required fields
    if not plugin_module.highlights then
        return false, "Missing highlights field"
    end
    
    if type(plugin_module.highlights) ~= "function" and type(plugin_module.highlights) ~= "table" then
        return false, "highlights must be function or table"
    end
    
    -- Check optional metadata
    local warnings = {}
    
    if not plugin_module.name then
        table.insert(warnings, "Missing name field")
    end
    
    if not plugin_module.description then
        table.insert(warnings, "Missing description field")
    end
    
    return true, nil, warnings
end

function M.test_plugin_highlights(plugin_key, theme_name)
    theme_name = theme_name or "sui"
    
    local colors = require("suikimuku.core.colors")
    local theme_colors = colors.get(theme_name, 'legacy')
    local config = require("suikimuku.core.config").get_config()
    
    local highlights = M.get_plugin_highlights(plugin_key, theme_colors, config)
    
    return {
        plugin = plugin_key,
        theme = theme_name,
        highlight_count = vim.tbl_count(highlights),
        highlights = highlights
    }
end

-- Register new plugin (for extensibility)
function M.register_plugin(plugin_key, plugin_info)
    M.registry[plugin_key] = vim.tbl_deep_extend("force", {
        name = plugin_key,
        detect_patterns = {plugin_key},
        config_key = plugin_key,
        priority = 0,
        description = "Custom plugin",
        url = ""
    }, plugin_info)
    
    -- Clear cache to force re-detection
    M._detected_cache = nil
end

-- Unregister plugin
function M.unregister_plugin(plugin_key)
    M.registry[plugin_key] = nil
    M._loaded_plugins[plugin_key] = nil
    M._detected_cache = nil
end

return M