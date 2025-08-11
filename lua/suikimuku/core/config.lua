-- Enhanced Configuration System for Suikimuku.nvim
-- Provides validation, user hooks, and intelligent defaults

local M = {}

-- Configuration schema with validation rules
M.schema = {
    style = {
        type = "string",
        enum = {"sui", "ki", "mu", "ku"},
        default = "sui",
        description = "Theme style selection"
    },
    
    transparent = {
        type = "boolean",
        default = nil, -- nil means use theme default
        description = "Enable transparent background"
    },
    
    opacity = {
        type = "number",
        min = 0.0,
        max = 1.0,
        default = nil, -- nil means use theme default
        description = "Background opacity when transparent"
    },
    
    contrast = {
        type = "string",
        enum = {"low", "normal", "high", "maximum"},
        default = "normal",
        description = "Contrast level adjustment"
    },
    
    variant = {
        type = "string",
        enum = {"standard", "soft", "bright", "minimal"},
        default = "standard",
        description = "Theme variant"
    },
    
    terminal_colors = {
        type = "boolean",
        default = true,
        description = "Set terminal colors"
    },
    
    italic = {
        type = "table",
        default = {
            comments = true,
            keywords = false,
            functions = false,
            strings = false,
            variables = false
        },
        schema = {
            comments = {type = "boolean", default = true},
            keywords = {type = "boolean", default = false},
            functions = {type = "boolean", default = false},
            strings = {type = "boolean", default = false},
            variables = {type = "boolean", default = false}
        },
        description = "Italic text settings"
    },
    
    bold = {
        type = "table", 
        default = {
            keywords = true,
            functions = false,
            types = false,
            constants = false
        },
        schema = {
            keywords = {type = "boolean", default = true},
            functions = {type = "boolean", default = false},
            types = {type = "boolean", default = false},
            constants = {type = "boolean", default = false}
        },
        description = "Bold text settings"
    },
    
    underline = {
        type = "table",
        default = {
            links = true,
            errors = false,
            warnings = false,
            spell = true
        },
        schema = {
            links = {type = "boolean", default = true},
            errors = {type = "boolean", default = false},
            warnings = {type = "boolean", default = false},
            spell = {type = "boolean", default = true}
        },
        description = "Underline text settings"
    },
    
    styles = {
        type = "table",
        default = {
            sidebars = "normal", -- "normal", "dark", "transparent"
            floats = "normal",   -- "normal", "dark", "transparent"
            popup = "normal"     -- "normal", "dark", "transparent"
        },
        schema = {
            sidebars = {type = "string", enum = {"normal", "dark", "transparent"}, default = "normal"},
            floats = {type = "string", enum = {"normal", "dark", "transparent"}, default = "normal"},
            popup = {type = "string", enum = {"normal", "dark", "transparent"}, default = "normal"}
        },
        description = "UI element styling"
    },
    
    plugins = {
        type = "table",
        default = {
            auto_detect = true,
            telescope = {enabled = true, style = "bordered"},
            nvim_tree = {enabled = true, transparency = false},
            lualine = {enabled = true, theme_integration = true},
            gitsigns = {enabled = true, line_highlights = false},
            cmp = {enabled = true, menu_style = "default"},
            treesitter = {enabled = true, enhanced_highlights = true}
        },
        schema = {
            auto_detect = {type = "boolean", default = true},
            telescope = {
                type = "table",
                schema = {
                    enabled = {type = "boolean", default = true},
                    style = {type = "string", enum = {"bordered", "borderless"}, default = "bordered"}
                }
            },
            nvim_tree = {
                type = "table", 
                schema = {
                    enabled = {type = "boolean", default = true},
                    transparency = {type = "boolean", default = false}
                }
            },
            lualine = {
                type = "table",
                schema = {
                    enabled = {type = "boolean", default = true},
                    theme_integration = {type = "boolean", default = true}
                }
            },
            gitsigns = {
                type = "table",
                schema = {
                    enabled = {type = "boolean", default = true},
                    line_highlights = {type = "boolean", default = false}
                }
            },
            cmp = {
                type = "table",
                schema = {
                    enabled = {type = "boolean", default = true},
                    menu_style = {type = "string", enum = {"default", "minimal", "detailed"}, default = "default"}
                }
            },
            treesitter = {
                type = "table",
                schema = {
                    enabled = {type = "boolean", default = true},
                    enhanced_highlights = {type = "boolean", default = true}
                }
            }
        },
        description = "Plugin integration settings"
    },
    
    overrides = {
        type = "table",
        default = {},
        description = "Manual color overrides"
    },
    
    on_colors = {
        type = "function",
        default = function(colors) end,
        description = "Color customization hook"
    },
    
    on_highlights = {
        type = "function", 
        default = function(highlights, colors) end,
        description = "Highlight customization hook"
    },
    
    cache = {
        type = "table",
        default = {
            enabled = true,
            path = vim.fn.stdpath("cache") .. "/suikimuku",
            ttl = 3600 -- 1 hour in seconds
        },
        schema = {
            enabled = {type = "boolean", default = true},
            path = {type = "string", default = vim.fn.stdpath("cache") .. "/suikimuku"},
            ttl = {type = "number", min = 0, default = 3600}
        },
        description = "Configuration and color caching"
    },
    
    debug = {
        type = "table",
        default = {
            enabled = false,
            log_level = "info", -- "debug", "info", "warn", "error"
            print_colors = false,
            validate_highlights = false
        },
        schema = {
            enabled = {type = "boolean", default = false},
            log_level = {type = "string", enum = {"debug", "info", "warn", "error"}, default = "info"},
            print_colors = {type = "boolean", default = false},
            validate_highlights = {type = "boolean", default = false}
        },
        description = "Debug and development settings"
    }
}

-- Default configuration
M.defaults = {}
for key, value in pairs(M.schema) do
    M.defaults[key] = value.default
end

-- Current configuration state
M.current = vim.deepcopy(M.defaults)

-- Configuration validation functions
local function validate_value(value, schema_def, path)
    path = path or ""
    
    if value == nil then
        return schema_def.default, nil
    end
    
    -- Type validation
    if schema_def.type and type(value) ~= schema_def.type then
        return nil, string.format("Invalid type at %s: expected %s, got %s", path, schema_def.type, type(value))
    end
    
    -- Enum validation
    if schema_def.enum then
        local valid = false
        for _, enum_value in ipairs(schema_def.enum) do
            if value == enum_value then
                valid = true
                break
            end
        end
        if not valid then
            return nil, string.format("Invalid value at %s: expected one of %s, got %s", 
                path, table.concat(schema_def.enum, ", "), tostring(value))
        end
    end
    
    -- Number range validation
    if schema_def.type == "number" then
        if schema_def.min and value < schema_def.min then
            return nil, string.format("Value at %s too small: minimum %s, got %s", path, schema_def.min, value)
        end
        if schema_def.max and value > schema_def.max then
            return nil, string.format("Value at %s too large: maximum %s, got %s", path, schema_def.max, value)
        end
    end
    
    -- Table schema validation
    if schema_def.type == "table" and schema_def.schema then
        if type(value) ~= "table" then
            return nil, string.format("Invalid type at %s: expected table", path)
        end
        
        local validated_table = {}
        
        -- Validate each field in the table
        for field_key, field_schema in pairs(schema_def.schema) do
            local field_path = path == "" and field_key or (path .. "." .. field_key)
            local field_value = value[field_key]
            
            local validated_field, error = validate_value(field_value, field_schema, field_path)
            if error then
                return nil, error
            end
            
            validated_table[field_key] = validated_field
        end
        
        -- Include any extra fields that aren't in schema (for flexibility)
        for key, val in pairs(value) do
            if not schema_def.schema[key] then
                validated_table[key] = val
            end
        end
        
        return validated_table, nil
    end
    
    return value, nil
end

-- Validate entire configuration
function M.validate(config)
    config = config or {}
    local validated = {}
    local errors = {}
    
    -- Validate each top-level field
    for key, schema_def in pairs(M.schema) do
        local value = config[key]
        local validated_value, error = validate_value(value, schema_def, key)
        
        if error then
            table.insert(errors, error)
        else
            validated[key] = validated_value
        end
    end
    
    -- Include any extra fields not in schema (for extensibility)
    for key, value in pairs(config) do
        if not M.schema[key] then
            validated[key] = value
        end
    end
    
    if #errors > 0 then
        return nil, errors
    end
    
    return validated, nil
end

-- Apply theme-specific defaults
function M.apply_theme_defaults(config, theme_name)
    local themes = require("suikimuku.themes.init")
    local theme_info = themes.get_theme_info(theme_name)
    local theme_defaults = themes.get_defaults(theme_name)
    
    -- Apply theme-specific defaults
    local enhanced_config = vim.tbl_deep_extend("keep", config, theme_defaults)
    
    -- Apply theme-specific transparent default if not explicitly set
    if enhanced_config.transparent == nil then
        enhanced_config.transparent = theme_info.default_transparent or false
    end
    
    -- Apply theme-specific opacity if transparent
    if enhanced_config.transparent and enhanced_config.opacity == nil then
        enhanced_config.opacity = theme_defaults.opacity or 0.85
    end
    
    return enhanced_config
end

-- Setup configuration with validation
function M.setup(user_config)
    user_config = user_config or {}
    
    -- Store the provided theme style for theme defaults
    local theme_style = user_config.style or M.defaults.style
    
    -- Apply theme-specific defaults first
    local config_with_theme_defaults = M.apply_theme_defaults(user_config, theme_style)
    
    -- Validate configuration
    local validated_config, errors = M.validate(config_with_theme_defaults)
    
    if errors then
        local error_msg = "Suikimuku configuration errors:\n" .. table.concat(errors, "\n")
        vim.notify(error_msg, vim.log.levels.ERROR)
        
        -- Use defaults for invalid configuration
        validated_config = vim.deepcopy(M.defaults)
        validated_config = M.apply_theme_defaults(validated_config, theme_style)
    end
    
    -- Update current configuration
    M.current = validated_config
    
    -- Store theme for access
    vim.g.suikimuku_current_theme = validated_config.style
    
    -- Enable debug logging if requested
    if validated_config.debug.enabled then
        M.enable_debug_logging(validated_config.debug)
    end
    
    return validated_config
end

-- Get current configuration
function M.get_config()
    return vim.deepcopy(M.current)
end

-- Update configuration at runtime
function M.update(updates)
    local merged_config = vim.tbl_deep_extend("force", M.current, updates)
    return M.setup(merged_config)
end

-- Reset to defaults
function M.reset()
    M.current = vim.deepcopy(M.defaults)
    vim.g.suikimuku_current_theme = M.current.style
    return M.current
end

-- Configuration migration for backward compatibility
function M.migrate_legacy_config(legacy_config)
    local migrated = {}
    
    -- Map legacy keys to new structure
    local key_mappings = {
        style = "style",
        transparent = "transparent", 
        opacity = "opacity",
        italic_comments = function(val) 
            return {italic = {comments = val}} 
        end,
        bold_keywords = function(val)
            return {bold = {keywords = val}}
        end,
        -- Add more mappings as needed
    }
    
    for legacy_key, value in pairs(legacy_config) do
        local mapping = key_mappings[legacy_key]
        
        if type(mapping) == "string" then
            migrated[mapping] = value
        elseif type(mapping) == "function" then
            local mapped = mapping(value)
            migrated = vim.tbl_deep_extend("force", migrated, mapped)
        else
            -- Unknown legacy key, preserve it
            migrated[legacy_key] = value
        end
    end
    
    return migrated
end

-- Debug logging utilities
function M.enable_debug_logging(debug_config)
    M._debug = debug_config or M.current.debug
    
    if M._debug.print_colors then
        M.log("debug", "Color debugging enabled")
    end
    
    if M._debug.validate_highlights then
        M.log("debug", "Highlight validation enabled") 
    end
end

function M.log(level, message, data)
    if not M._debug or not M._debug.enabled then
        return
    end
    
    local log_levels = {debug = 0, info = 1, warn = 2, error = 3}
    local current_level = log_levels[M._debug.log_level] or 1
    local msg_level = log_levels[level] or 1
    
    if msg_level >= current_level then
        local prefix = string.format("[Suikimuku:%s]", level:upper())
        local full_message = data and (message .. " " .. vim.inspect(data)) or message
        print(prefix .. " " .. full_message)
    end
end

-- Configuration introspection
function M.get_schema()
    return vim.deepcopy(M.schema)
end

function M.get_defaults()
    return vim.deepcopy(M.defaults) 
end

-- Validation utilities for user functions
function M.is_valid_style(style)
    return M.schema.style.enum and vim.tbl_contains(M.schema.style.enum, style)
end

function M.is_valid_contrast(contrast)
    return M.schema.contrast.enum and vim.tbl_contains(M.schema.contrast.enum, contrast)
end

function M.is_valid_variant(variant)
    return M.schema.variant.enum and vim.tbl_contains(M.schema.variant.enum, variant)
end

-- Cache management
function M.get_cache_key(config)
    -- Generate cache key from configuration
    local cache_data = {
        style = config.style,
        variant = config.variant,
        contrast = config.contrast,
        transparent = config.transparent,
        opacity = config.opacity,
        plugins = config.plugins,
        overrides = config.overrides
    }
    
    return vim.fn.sha256(vim.fn.json_encode(cache_data))
end

function M.get_cache_path(cache_key)
    local cache_dir = M.current.cache.path
    return cache_dir .. "/" .. cache_key .. ".json"
end

return M