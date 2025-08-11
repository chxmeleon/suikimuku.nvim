-- Unified Color System for Suikimuku.nvim
-- Single source of truth with multiple format support (hex, OKLCH, extended families)
-- Consolidates legacy, extended, and OKLCH color systems

local oklch = require("suikimuku.oklch")
local M = {}

-- Color definition structure: OKLCH as source of truth, hex for compatibility
-- Each color includes: OKLCH values, pre-calculated hex, and semantic metadata
local color_definitions = {
    -- 翠 (Sui) - Digital Aquarium: Deep ocean with bioluminescent accents
    sui = {
        -- Background Family - Ocean depths with consistent lightness progression
        bg_primary = {
            oklch = {12, 15, 180},
            hex = "#0A1B1A",
            semantic = "main_background"
        },
        bg_secondary = {
            oklch = {18, 12, 175}, 
            hex = "#0F2A28",
            semantic = "secondary_panels"
        },
        bg_float = {
            oklch = {25, 10, 170},
            hex = "#1A3E3B", 
            semantic = "floating_windows"
        },
        bg_highlight = {
            oklch = {35, 8, 165},
            hex = "#2A5651",
            semantic = "selections"
        },
        
        -- Foreground Family - Aquatic text hierarchy
        fg_primary = {
            oklch = {82, 8, 180},
            hex = "#A7DBD8",
            semantic = "primary_text"
        },
        fg_secondary = {
            oklch = {68, 12, 175},
            hex = "#7BBAB1", 
            semantic = "secondary_text"
        },
        fg_muted = {
            oklch = {88, 15, 200},
            hex = "#C8E6F5",
            semantic = "muted_text"
        },
        fg_subtle = {
            oklch = {58, 10, 170},
            hex = "#6B9F96",
            semantic = "subtle_text"
        },
        
        -- Blue Family - Electric bioluminescence
        blue_primary = {
            oklch = {75, 25, 220},
            hex = "#69D2E7",
            semantic = "functions"
        },
        blue_dark = {
            oklch = {60, 20, 215},
            hex = "#4A9BB0",
            semantic = "borders"
        },
        blue_light = {
            oklch = {85, 20, 225},
            hex = "#87E0F0",
            semantic = "info_messages"
        },
        blue_bright = {
            oklch = {90, 30, 230},
            hex = "#A0F0FF",
            semantic = "highlights"
        },
        
        -- Teal Family - Primary theme colors
        teal_primary = {
            oklch = {82, 8, 180},
            hex = "#A7DBD8",
            semantic = "types"
        },
        teal_dark = {
            oklch = {68, 12, 175},
            hex = "#7BBAB1",
            semantic = "muted_elements"
        },
        teal_light = {
            oklch = {88, 15, 185},
            hex = "#C8E6F5",
            semantic = "special_operators"
        },
        teal_bright = {
            oklch = {85, 18, 190},
            hex = "#B5F0ED",
            semantic = "accents"
        },
        
        -- Green Family - Underwater growth
        green_primary = {
            oklch = {70, 30, 140},
            hex = "#52C489",
            semantic = "strings"
        },
        green_dark = {
            oklch = {55, 25, 135},
            hex = "#3A8B5F",
            semantic = "success_muted"
        },
        green_light = {
            oklch = {78, 25, 145},
            hex = "#6FD49F",
            semantic = "success_messages"
        },
        green_bright = {
            oklch = {85, 35, 150},
            hex = "#7DE8A8",
            semantic = "diff_additions"
        },
        
        -- Purple Family - Ocean mystery
        purple_primary = {
            oklch = {72, 28, 250},
            hex = "#1e9ee8",
            semantic = "keywords"
        },
        purple_dark = {
            oklch = {57, 23, 245},
            hex = "#1570A8",
            semantic = "muted_keywords"
        },
        purple_light = {
            oklch = {80, 23, 255},
            hex = "#4BB8F0",
            semantic = "special_keywords"
        },
        purple_bright = {
            oklch = {85, 33, 260},
            hex = "#66C8FF",
            semantic = "bright_accents"
        },
        
        -- Orange Family - Coral warmth
        orange_primary = {
            oklch = {65, 40, 45},
            hex = "#F38630",
            semantic = "constants"
        },
        orange_dark = {
            oklch = {50, 35, 40},
            hex = "#B85E20",
            semantic = "warning_muted"
        },
        orange_light = {
            oklch = {75, 35, 50},
            hex = "#FF9D4D",
            semantic = "warning_messages"
        },
        orange_bright = {
            oklch = {80, 45, 55},
            hex = "#FFB366",
            semantic = "diff_changes"
        },
        
        -- Red Family - Deep danger
        red_primary = {
            oklch = {60, 35, 25},
            hex = "#E85A4F",
            semantic = "errors"
        },
        red_dark = {
            oklch = {45, 30, 20},
            hex = "#B03E35",
            semantic = "error_muted"
        },
        red_light = {
            oklch = {70, 30, 30},
            hex = "#F2776B",
            semantic = "error_messages"
        },
        red_bright = {
            oklch = {75, 40, 35},
            hex = "#FF8A7F",
            semantic = "diff_deletions"
        },
    },
    
    -- 輝 (Ki) - Crystal Radiant Light
    ki = {
        -- Background Family - Crystal clarity
        bg_primary = {
            oklch = {98, 2, 220},
            hex = "#FAFCFF",
            semantic = "main_background"
        },
        bg_secondary = {
            oklch = {95, 3, 215},
            hex = "#F0F9FF",
            semantic = "secondary_panels"
        },
        bg_float = {
            oklch = {92, 5, 210},
            hex = "#E1F5FE",
            semantic = "floating_windows"
        },
        bg_highlight = {
            oklch = {85, 8, 205},
            hex = "#CBD5E1",
            semantic = "selections"
        },
        
        -- Foreground Family - Clear text
        fg_primary = {
            oklch = {45, 8, 220},
            hex = "#475569",
            semantic = "primary_text"
        },
        fg_secondary = {
            oklch = {55, 12, 215},
            hex = "#64748B",
            semantic = "secondary_text"
        },
        fg_muted = {
            oklch = {65, 10, 210},
            hex = "#94A3B8",
            semantic = "muted_text"
        },
        fg_subtle = {
            oklch = {75, 8, 205},
            hex = "#CBD5E1",
            semantic = "subtle_text"
        },
        
        -- Blue Family - Crystal blue
        blue_primary = {
            oklch = {65, 35, 250},
            hex = "#3B82F6",
            semantic = "functions"
        },
        blue_dark = {
            oklch = {50, 40, 245},
            hex = "#1E40AF",
            semantic = "borders"
        },
        blue_light = {
            oklch = {75, 30, 255},
            hex = "#60A5FA",
            semantic = "info_messages"
        },
        blue_bright = {
            oklch = {85, 25, 260},
            hex = "#93C5FD",
            semantic = "highlights"
        },
        
        -- Teal Family - Crystal teal
        teal_primary = {
            oklch = {70, 30, 200},
            hex = "#06B6D4",
            semantic = "types"
        },
        teal_dark = {
            oklch = {60, 25, 195},
            hex = "#0891B2",
            semantic = "muted_elements"
        },
        teal_light = {
            oklch = {80, 25, 205},
            hex = "#22D3EE",
            semantic = "special_operators"
        },
        teal_bright = {
            oklch = {88, 30, 210},
            hex = "#67E8F9",
            semantic = "accents"
        },
        
        -- Green Family - Crystal green
        green_primary = {
            oklch = {65, 35, 160},
            hex = "#10B981",
            semantic = "strings"
        },
        green_dark = {
            oklch = {55, 30, 155},
            hex = "#059669",
            semantic = "success_muted"
        },
        green_light = {
            oklch = {75, 30, 165},
            hex = "#34D399",
            semantic = "success_messages"
        },
        green_bright = {
            oklch = {85, 35, 170},
            hex = "#6EE7B7",
            semantic = "diff_additions"
        },
        
        -- Purple Family - Crystal purple
        purple_primary = {
            oklch = {65, 40, 280},
            hex = "#8B5CF6",
            semantic = "keywords"
        },
        purple_dark = {
            oklch = {55, 45, 275},
            hex = "#7C3AED",
            semantic = "muted_keywords"
        },
        purple_light = {
            oklch = {75, 35, 285},
            hex = "#A78BFA",
            semantic = "special_keywords"
        },
        purple_bright = {
            oklch = {85, 30, 290},
            hex = "#C4B5FD",
            semantic = "bright_accents"
        },
        
        -- Orange Family - Crystal warm
        orange_primary = {
            oklch = {70, 40, 50},
            hex = "#F97316",
            semantic = "constants"
        },
        orange_dark = {
            oklch = {60, 45, 45},
            hex = "#EA580C",
            semantic = "warning_muted"
        },
        orange_light = {
            oklch = {80, 35, 55},
            hex = "#FB923C",
            semantic = "warning_messages"
        },
        orange_bright = {
            oklch = {88, 40, 60},
            hex = "#FDBA74",
            semantic = "diff_changes"
        },
        
        -- Red Family - Crystal danger
        red_primary = {
            oklch = {60, 45, 15},
            hex = "#E11D48",
            semantic = "errors"
        },
        red_dark = {
            oklch = {50, 50, 10},
            hex = "#BE123C",
            semantic = "error_muted"
        },
        red_light = {
            oklch = {70, 40, 20},
            hex = "#F43F5E",
            semantic = "error_messages"
        },
        red_bright = {
            oklch = {80, 35, 25},
            hex = "#FB7185",
            semantic = "diff_deletions"
        },
    },
    
    -- 無 (Mu) - WCAG AAA Grayscale
    mu = {
        -- Background Family - High contrast
        bg_primary = {
            oklch = {0, 0, 0},
            hex = "#000000",
            semantic = "main_background"
        },
        bg_secondary = {
            oklch = {15, 0, 0},
            hex = "#1A1A1A",
            semantic = "secondary_panels"
        },
        bg_float = {
            oklch = {25, 0, 0},
            hex = "#2D2D2D",
            semantic = "floating_windows"
        },
        bg_highlight = {
            oklch = {35, 0, 0},
            hex = "#404040",
            semantic = "selections"
        },
        
        -- Foreground Family - High contrast text
        fg_primary = {
            oklch = {100, 0, 0},
            hex = "#FFFFFF",
            semantic = "primary_text"
        },
        fg_secondary = {
            oklch = {90, 0, 0},
            hex = "#E6E6E6",
            semantic = "secondary_text"
        },
        fg_muted = {
            oklch = {80, 0, 0},
            hex = "#CCCCCC",
            semantic = "muted_text"
        },
        fg_subtle = {
            oklch = {60, 0, 0},
            hex = "#808080",
            semantic = "subtle_text"
        },
        
        -- All color families use grayscale (zero chroma)
        blue_primary = {
            oklch = {82, 0, 0},
            hex = "#D4D4D4",
            semantic = "functions"
        },
        blue_dark = {
            oklch = {60, 0, 0},
            hex = "#808080",
            semantic = "borders"
        },
        blue_light = {
            oklch = {90, 0, 0},
            hex = "#E6E6E6",
            semantic = "info_messages"
        },
        blue_bright = {
            oklch = {94, 0, 0},
            hex = "#F0F0F0",
            semantic = "highlights"
        },
        
        teal_primary = {
            oklch = {80, 0, 0},
            hex = "#CCCCCC",
            semantic = "types"
        },
        teal_dark = {
            oklch = {65, 0, 0},
            hex = "#909090",
            semantic = "muted_elements"
        },
        teal_light = {
            oklch = {88, 0, 0},
            hex = "#E0E0E0",
            semantic = "special_operators"
        },
        teal_bright = {
            oklch = {96, 0, 0},
            hex = "#F5F5F5",
            semantic = "accents"
        },
        
        green_primary = {
            oklch = {72, 0, 0},
            hex = "#B8B8B8",
            semantic = "strings"
        },
        green_dark = {
            oklch = {50, 0, 0},
            hex = "#707070",
            semantic = "success_muted"
        },
        green_light = {
            oklch = {82, 0, 0},
            hex = "#D0D0D0",
            semantic = "success_messages"
        },
        green_bright = {
            oklch = {91, 0, 0},
            hex = "#E8E8E8",
            semantic = "diff_additions"
        },
        
        purple_primary = {
            oklch = {70, 0, 0},
            hex = "#A0A0A0",
            semantic = "keywords"
        },
        purple_dark = {
            oklch = {45, 0, 0},
            hex = "#606060",
            semantic = "muted_keywords"
        },
        purple_light = {
            oklch = {78, 0, 0},
            hex = "#C0C0C0",
            semantic = "special_keywords"
        },
        purple_bright = {
            oklch = {87, 0, 0},
            hex = "#DEDEDE",
            semantic = "bright_accents"
        },
        
        orange_primary = {
            oklch = {65, 0, 0},
            hex = "#909090",
            semantic = "constants"
        },
        orange_dark = {
            oklch = {38, 0, 0},
            hex = "#505050",
            semantic = "warning_muted"
        },
        orange_light = {
            oklch = {75, 0, 0},
            hex = "#B0B0B0",
            semantic = "warning_messages"
        },
        orange_bright = {
            oklch = {85, 0, 0},
            hex = "#D8D8D8",
            semantic = "diff_changes"
        },
        
        red_primary = {
            oklch = {60, 0, 0},
            hex = "#808080",
            semantic = "errors"
        },
        red_dark = {
            oklch = {35, 0, 0},
            hex = "#404040",
            semantic = "error_muted"
        },
        red_light = {
            oklch = {70, 0, 0},
            hex = "#A0A0A0",
            semantic = "error_messages"
        },
        red_bright = {
            oklch = {78, 0, 0},
            hex = "#C8C8C8",
            semantic = "diff_deletions"
        },
    },
    
    -- 空 (Ku) - Enhanced Vibrant Terminal
    ku = {
        -- Background Family - Electric deep space
        bg_primary = {
            oklch = {8, 20, 200},
            hex = "#000F10",
            semantic = "main_background"
        },
        bg_secondary = {
            oklch = {20, 25, 210},
            hex = "#072842",
            semantic = "secondary_panels"
        },
        bg_float = {
            oklch = {30, 20, 215},
            hex = "#283D5E",
            semantic = "floating_windows"
        },
        bg_highlight = {
            oklch = {25, 15, 205},
            hex = "#203047",
            semantic = "selections"
        },
        
        -- Foreground Family - Terminal clarity
        fg_primary = {
            oklch = {65, 8, 180},
            hex = "#839496",
            semantic = "primary_text"
        },
        fg_secondary = {
            oklch = {50, 12, 175},
            hex = "#586E75",
            semantic = "secondary_text"
        },
        fg_muted = {
            oklch = {70, 6, 185},
            hex = "#93A1A1",
            semantic = "muted_text"
        },
        fg_subtle = {
            oklch = {58, 10, 170},
            hex = "#657B83",
            semantic = "subtle_text"
        },
        
        -- Blue Family - Electric cyan
        blue_primary = {
            oklch = {80, 50, 200},
            hex = "#00D7FF",
            semantic = "functions"
        },
        blue_dark = {
            oklch = {65, 45, 195},
            hex = "#0099CC",
            semantic = "borders"
        },
        blue_light = {
            oklch = {85, 45, 205},
            hex = "#33E0FF",
            semantic = "info_messages"
        },
        blue_bright = {
            oklch = {90, 55, 210},
            hex = "#66E8FF",
            semantic = "highlights"
        },
        
        -- Teal Family - Cyber teal
        teal_primary = {
            oklch = {75, 40, 180},
            hex = "#00CED1",
            semantic = "types"
        },
        teal_dark = {
            oklch = {60, 35, 175},
            hex = "#008B8B",
            semantic = "muted_elements"
        },
        teal_light = {
            oklch = {85, 35, 185},
            hex = "#40E0D0",
            semantic = "special_operators"
        },
        teal_bright = {
            oklch = {92, 45, 190},
            hex = "#7FFFD4",
            semantic = "accents"
        },
        
        -- Green Family - Electric green
        green_primary = {
            oklch = {85, 45, 150},
            hex = "#38E8AA",
            semantic = "strings"
        },
        green_dark = {
            oklch = {70, 40, 145},
            hex = "#20B887",
            semantic = "success_muted"
        },
        green_light = {
            oklch = {90, 40, 155},
            hex = "#52F0B8",
            semantic = "success_messages"
        },
        green_bright = {
            oklch = {95, 50, 160},
            hex = "#6FFFC6",
            semantic = "diff_additions"
        },
        
        -- Purple Family - Neon purple
        purple_primary = {
            oklch = {68, 35, 280},
            hex = "#9D7CD8",
            semantic = "keywords"
        },
        purple_dark = {
            oklch = {55, 30, 275},
            hex = "#7B5CB5",
            semantic = "muted_keywords"
        },
        purple_light = {
            oklch = {78, 30, 285},
            hex = "#B599E8",
            semantic = "special_keywords"
        },
        purple_bright = {
            oklch = {88, 40, 290},
            hex = "#D4B5FF",
            semantic = "bright_accents"
        },
        
        -- Orange Family - Electric orange
        orange_primary = {
            oklch = {75, 50, 60},
            hex = "#FF8C00",
            semantic = "constants"
        },
        orange_dark = {
            oklch = {60, 45, 55},
            hex = "#CC6600",
            semantic = "warning_muted"
        },
        orange_light = {
            oklch = {82, 45, 65},
            hex = "#FFA533",
            semantic = "warning_messages"
        },
        orange_bright = {
            oklch = {88, 55, 70},
            hex = "#FFBF66",
            semantic = "diff_changes"
        },
        
        -- Red Family - Neon red
        red_primary = {
            oklch = {58, 40, 25},
            hex = "#DC322F",
            semantic = "errors"
        },
        red_dark = {
            oklch = {45, 35, 20},
            hex = "#B21E1B",
            semantic = "error_muted"
        },
        red_light = {
            oklch = {68, 35, 30},
            hex = "#E85D58",
            semantic = "error_messages"
        },
        red_bright = {
            oklch = {78, 45, 35},
            hex = "#FF7A75",
            semantic = "diff_deletions"
        },
    },
}

-- Unified API for accessing colors in different formats
-- Usage: colors.get('sui', 'hex', 'blue_primary') -> "#69D2E7"
-- Usage: colors.get('sui', 'oklch', 'blue_primary') -> {l: 75, c: 25, h: 220}
-- Usage: colors.get('sui', 'family', 'blue') -> {primary: "#69D2E7", dark: "#4A9BB0", ...}
function M.get(theme, format, color_name)
    local theme_colors = color_definitions[theme]
    if not theme_colors then
        error("Unknown theme: " .. tostring(theme))
    end
    
    format = format or 'hex'
    
    if format == 'hex' then
        if color_name then
            local color = theme_colors[color_name]
            return color and color.hex or nil
        else
            -- Return all colors as hex values
            local result = {}
            for name, color in pairs(theme_colors) do
                result[name] = color.hex
            end
            return result
        end
        
    elseif format == 'oklch' then
        if color_name then
            local color = theme_colors[color_name]
            return color and {l = color.oklch[1], c = color.oklch[2], h = color.oklch[3]} or nil
        else
            -- Return all colors as OKLCH values
            local result = {}
            for name, color in pairs(theme_colors) do
                result[name] = {l = color.oklch[1], c = color.oklch[2], h = color.oklch[3]}
            end
            return result
        end
        
    elseif format == 'family' then
        -- Return colors grouped by family
        local families = {}
        
        if color_name then
            -- Get specific family (e.g., 'blue' -> {primary, dark, light, bright})
            local family_colors = {}
            for name, color in pairs(theme_colors) do
                if name:match("^" .. color_name .. "_") then
                    local variant = name:match("^" .. color_name .. "_(.+)")
                    family_colors[variant] = color.hex
                end
            end
            return family_colors
        else
            -- Return all families
            local family_names = {"bg", "fg", "blue", "teal", "green", "purple", "orange", "red"}
            for _, family in ipairs(family_names) do
                families[family] = {}
                for name, color in pairs(theme_colors) do
                    if name:match("^" .. family .. "_") then
                        local variant = name:match("^" .. family .. "_(.+)")
                        families[family][variant] = color.hex
                    end
                end
            end
            return families
        end
        
    elseif format == 'legacy' then
        -- Return colors in legacy format for backward compatibility
        local legacy = {
            bg = {
                primary = theme_colors.bg_primary.hex,
                secondary = theme_colors.bg_secondary.hex,
                float = theme_colors.bg_float.hex,
                highlight = theme_colors.bg_highlight.hex,
            },
            fg = {
                primary = theme_colors.fg_primary.hex,
                secondary = theme_colors.fg_secondary.hex,
                muted = theme_colors.fg_muted.hex,
                subtle = theme_colors.fg_subtle.hex,
            },
            syntax = {
                func = theme_colors.blue_primary.hex,
                keyword = theme_colors.purple_primary.hex,
                string = theme_colors.green_primary.hex,
                type = theme_colors.teal_primary.hex,
                const = theme_colors.orange_primary.hex,
                special = theme_colors.teal_light.hex,
            },
            diag = {
                error = theme_colors.red_primary.hex,
                warn = theme_colors.orange_light.hex,
                info = theme_colors.blue_light.hex,
                hint = theme_colors.green_light.hex,
            }
        }
        return legacy
        
    else
        error("Unknown format: " .. tostring(format))
    end
end

-- Get semantic color by purpose (e.g., 'functions', 'strings', 'errors')
function M.get_semantic(theme, semantic)
    local theme_colors = color_definitions[theme]
    if not theme_colors then
        error("Unknown theme: " .. tostring(theme))
    end
    
    for name, color in pairs(theme_colors) do
        if color.semantic == semantic then
            return color.hex
        end
    end
    
    return nil
end

-- Get all available themes
function M.get_themes()
    local themes = {}
    for theme_name, _ in pairs(color_definitions) do
        table.insert(themes, theme_name)
    end
    return themes
end

-- Get color families for a theme
function M.get_families(theme)
    return {"bg", "fg", "blue", "teal", "green", "purple", "orange", "red"}
end

-- Get color variants within a family
function M.get_variants(theme, family)
    local theme_colors = color_definitions[theme]
    if not theme_colors then
        return {}
    end
    
    local variants = {}
    for name, _ in pairs(theme_colors) do
        if name:match("^" .. family .. "_") then
            local variant = name:match("^" .. family .. "_(.+)")
            table.insert(variants, variant)
        end
    end
    
    return variants
end

-- Color manipulation using OKLCH
function M.manipulate(theme, color_name, operation, ...)
    local color = color_definitions[theme] and color_definitions[theme][color_name]
    if not color then
        error("Color not found: " .. tostring(color_name) .. " in theme " .. tostring(theme))
    end
    
    local l, c, h = color.oklch[1], color.oklch[2], color.oklch[3]
    local args = {...}
    
    if operation == 'lighten' then
        return oklch.lighten(l, c, h, args[1] or 10)
    elseif operation == 'darken' then
        return oklch.darken(l, c, h, args[1] or 10)
    elseif operation == 'saturate' then
        return oklch.saturate(l, c, h, args[1] or 10)
    elseif operation == 'desaturate' then
        return oklch.desaturate(l, c, h, args[1] or 10)
    elseif operation == 'rotate' then
        return oklch.rotate_hue(l, c, h, args[1] or 30)
    elseif operation == 'complement' then
        return oklch.complement(l, c, h)
    else
        error("Unknown operation: " .. tostring(operation))
    end
end

-- Validate theme and color names
function M.validate(theme, color_name)
    if not color_definitions[theme] then
        return false, "Unknown theme: " .. tostring(theme)
    end
    
    if color_name and not color_definitions[theme][color_name] then
        return false, "Unknown color: " .. tostring(color_name) .. " in theme " .. tostring(theme)
    end
    
    return true
end

-- Get color metadata
function M.get_metadata(theme, color_name)
    local color = color_definitions[theme] and color_definitions[theme][color_name]
    if not color then
        return nil
    end
    
    return {
        oklch = {l = color.oklch[1], c = color.oklch[2], h = color.oklch[3]},
        hex = color.hex,
        semantic = color.semantic,
    }
end

return M