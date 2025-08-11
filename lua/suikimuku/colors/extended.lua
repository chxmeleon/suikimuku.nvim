-- Suikimuku (翠輝無空) Extended 32-Color System
-- Professional-grade color architecture inspired by TokyoNight
-- 8 families × 4 variants = 32 colors per theme

local M = {}

-- Color utility functions for mathematical relationships
local function hex_to_rgb(hex)
    local r = tonumber(hex:sub(2, 3), 16) / 255
    local g = tonumber(hex:sub(4, 5), 16) / 255  
    local b = tonumber(hex:sub(6, 7), 16) / 255
    return r, g, b
end

local function rgb_to_hex(r, g, b)
    return string.format("#%02x%02x%02x", 
        math.floor(r * 255), 
        math.floor(g * 255), 
        math.floor(b * 255))
end

local function rgb_to_hsl(r, g, b)
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local h, s, l = 0, 0, (max + min) / 2

    if max == min then
        h, s = 0, 0 -- achromatic
    else
        local d = max - min
        s = l > 0.5 and d / (2 - max - min) or d / (max + min)
        
        if max == r then
            h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end

    return h, s, l
end

local function hsl_to_rgb(h, s, l)
    local r, g, b

    if s == 0 then
        r, g, b = l, l, l -- achromatic
    else
        local function hue2rgb(p, q, t)
            if t < 0 then t = t + 1 end
            if t > 1 then t = t - 1 end
            if t < 1/6 then return p + (q - p) * 6 * t end
            if t < 1/2 then return q end
            if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
            return p
        end

        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = hue2rgb(p, q, h + 1/3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1/3)
    end

    return r, g, b
end

-- Color manipulation functions
function M.darken(hex, amount)
    local r, g, b = hex_to_rgb(hex)
    local h, s, l = rgb_to_hsl(r, g, b)
    l = math.max(0, l - amount)
    r, g, b = hsl_to_rgb(h, s, l)
    return rgb_to_hex(r, g, b)
end

function M.lighten(hex, amount)
    local r, g, b = hex_to_rgb(hex)
    local h, s, l = rgb_to_hsl(r, g, b)
    l = math.min(1, l + amount)
    r, g, b = hsl_to_rgb(h, s, l)
    return rgb_to_hex(r, g, b)
end

function M.saturate(hex, amount)
    local r, g, b = hex_to_rgb(hex)
    local h, s, l = rgb_to_hsl(r, g, b)
    s = math.min(1, s + amount)
    r, g, b = hsl_to_rgb(h, s, l)
    return rgb_to_hex(r, g, b)
end

function M.blend(fg_hex, bg_hex, alpha)
    local fg_r, fg_g, fg_b = hex_to_rgb(fg_hex)
    local bg_r, bg_g, bg_b = hex_to_rgb(bg_hex)
    
    local r = alpha * fg_r + (1 - alpha) * bg_r
    local g = alpha * fg_g + (1 - alpha) * bg_g
    local b = alpha * fg_b + (1 - alpha) * bg_b
    
    return rgb_to_hex(r, g, b)
end

-- Generate color family variants
function M.generate_family(base_color)
    return {
        primary = base_color,
        dark = M.darken(base_color, 0.2),
        light = M.lighten(base_color, 0.15),
        bright = M.saturate(M.lighten(base_color, 0.1), 0.1)
    }
end

-- 32-Color Extended Palettes
M.palettes = {
    -- 翠 (Sui) - Digital Aquarium: Deep ocean with bioluminescent electric accents
    sui = {
        -- Background Family: Deep ocean depths
        bg = {
            primary   = "#0A1B1A",  -- Deep sea primary
            secondary = "#0F2A28",  -- Ocean depths secondary  
            float     = "#1A3E3B",  -- Floating kelp windows
            highlight = "#2A5651",  -- Bioluminescent selection
        },
        
        -- Foreground Family: Aquatic clarity
        fg = {
            primary   = "#A7DBD8",  -- Clear water primary
            secondary = "#7BBAB1",  -- Sea foam secondary
            muted     = "#C8E6F5",  -- Misty water
            subtle    = "#6B9F96",  -- Deep water subtle
        },
        
        -- Blue Family: Electric bioluminescence  
        blue = {
            primary   = "#69D2E7",  -- Electric jellyfish
            dark      = "#4A9BB0",  -- Deep ocean blue
            light     = "#87E0F0",  -- Bright bioluminescence  
            bright    = "#A0F0FF",  -- Electric highlight
        },
        
        -- Teal Family: Aqua depths
        teal = {
            primary   = "#A7DBD8",  -- Aqua mint
            dark      = "#7BBAB1",  -- Deep aqua
            light     = "#C8E6F5",  -- Light aqua mist
            bright    = "#B5F0ED",  -- Bright aqua
        },
        
        -- Green Family: Underwater growth
        green = {
            primary   = "#52C489",  -- Kelp green
            dark      = "#3A8B5F",  -- Deep kelp  
            light     = "#6FD49F",  -- Bright kelp
            bright    = "#7DE8A8",  -- Electric kelp
        },
        
        -- Purple Family: Deep sea mystery
        purple = {
            primary   = "#1e9ee8",  -- Ocean blue purple
            dark      = "#1570A8",  -- Deep mystery
            light     = "#4BB8F0",  -- Light mystery
            bright    = "#66C8FF",  -- Bright mystery
        },
        
        -- Orange Family: Coral warmth
        orange = {
            primary   = "#F38630",  -- Coral orange
            dark      = "#B85E20",  -- Deep coral
            light     = "#FF9D4D",  -- Light coral
            bright    = "#FFB366",  -- Bright coral
        },
        
        -- Red Family: Deep danger
        red = {
            primary   = "#E85A4F",  -- Danger red
            dark      = "#B03E35",  -- Deep danger
            light     = "#F2776B",  -- Light danger  
            bright    = "#FF8A7F",  -- Bright danger
        }
    },

    -- 輝 (Ki) - Crystal Radiant Light: Cool crystal clarity with luminous highlights
    ki = {
        -- Background Family: Crystal clarity
        bg = {
            primary   = "#FAFCFF",  -- Pure crystal
            secondary = "#F0F9FF",  -- Light crystal
            float     = "#E1F5FE",  -- Floating crystal
            highlight = "#CBD5E1",  -- Crystal selection
        },
        
        -- Foreground Family: Clear text
        fg = {
            primary   = "#475569",  -- Primary clarity
            secondary = "#64748B",  -- Secondary clarity  
            muted     = "#94A3B8",  -- Muted clarity
            subtle    = "#CBD5E1",  -- Subtle clarity
        },
        
        -- Blue Family: Crystal blue
        blue = {
            primary   = "#3B82F6",  -- Crystal blue
            dark      = "#1E40AF",  -- Deep crystal
            light     = "#60A5FA",  -- Light crystal
            bright    = "#93C5FD",  -- Bright crystal
        },
        
        -- Teal Family: Crystal teal
        teal = {
            primary   = "#06B6D4",  -- Crystal teal
            dark      = "#0891B2",  -- Deep teal
            light     = "#22D3EE",  -- Light teal
            bright    = "#67E8F9",  -- Bright teal
        },
        
        -- Green Family: Crystal green
        green = {
            primary   = "#10B981",  -- Crystal green
            dark      = "#059669",  -- Deep green
            light     = "#34D399",  -- Light green
            bright    = "#6EE7B7",  -- Bright green
        },
        
        -- Purple Family: Crystal purple
        purple = {
            primary   = "#8B5CF6",  -- Crystal purple
            dark      = "#7C3AED",  -- Deep purple
            light     = "#A78BFA",  -- Light purple
            bright    = "#C4B5FD",  -- Bright purple
        },
        
        -- Orange Family: Crystal warm
        orange = {
            primary   = "#F97316",  -- Crystal orange
            dark      = "#EA580C",  -- Deep orange
            light     = "#FB923C",  -- Light orange
            bright    = "#FDBA74",  -- Bright orange
        },
        
        -- Red Family: Crystal danger
        red = {
            primary   = "#E11D48",  -- Crystal red
            dark      = "#BE123C",  -- Deep red
            light     = "#F43F5E",  -- Light red
            bright    = "#FB7185",  -- Bright red
        }
    },

    -- 無 (Mu) - WCAG AAA Grayscale: High-contrast monochrome with subtle variations
    mu = {
        -- Background Family: Pure contrast
        bg = {
            primary   = "#000000",  -- Pure black
            secondary = "#1A1A1A",  -- Dark gray
            float     = "#2D2D2D",  -- Medium dark
            highlight = "#404040",  -- Highlight gray
        },
        
        -- Foreground Family: High contrast text
        fg = {
            primary   = "#FFFFFF",  -- Pure white
            secondary = "#E6E6E6",  -- Light gray
            muted     = "#CCCCCC",  -- Medium gray
            subtle    = "#808080",  -- Subtle gray
        },
        
        -- Blue Family: Grayscale blues
        blue = {
            primary   = "#D4D4D4",  -- Light gray
            dark      = "#808080",  -- Medium gray
            light     = "#E6E6E6",  -- Very light  
            bright    = "#F0F0F0",  -- Bright gray
        },
        
        -- Teal Family: Grayscale teals
        teal = {
            primary   = "#CCCCCC",  -- Light gray
            dark      = "#909090",  -- Medium gray
            light     = "#E0E0E0",  -- Very light
            bright    = "#F5F5F5",  -- Bright gray
        },
        
        -- Green Family: Grayscale greens  
        green = {
            primary   = "#B8B8B8",  -- Medium light
            dark      = "#707070",  -- Dark gray
            light     = "#D0D0D0",  -- Light gray
            bright    = "#E8E8E8",  -- Bright gray
        },
        
        -- Purple Family: Grayscale purples
        purple = {
            primary   = "#A0A0A0",  -- Medium gray
            dark      = "#606060",  -- Dark gray
            light     = "#C0C0C0",  -- Light gray
            bright    = "#DEDEDE",  -- Bright gray
        },
        
        -- Orange Family: Grayscale oranges
        orange = {
            primary   = "#909090",  -- Medium gray
            dark      = "#505050",  -- Dark gray
            light     = "#B0B0B0",  -- Light gray
            bright    = "#D8D8D8",  -- Bright gray
        },
        
        -- Red Family: Grayscale reds
        red = {
            primary   = "#808080",  -- Medium gray
            dark      = "#404040",  -- Dark gray
            light     = "#A0A0A0",  -- Light gray
            bright    = "#C8C8C8",  -- Bright gray
        }
    },

    -- 空 (Ku) - Enhanced Vibrant Terminal: Electric cyberpunk with high-saturation neon
    ku = {
        -- Background Family: Deep space
        bg = {
            primary   = "#000F10",  -- Deep space
            secondary = "#072842",  -- Electric deep
            float     = "#283D5E",  -- Floating neon
            highlight = "#203047",  -- Electric selection
        },
        
        -- Foreground Family: Terminal clarity
        fg = {
            primary   = "#839496",  -- Terminal primary
            secondary = "#586E75",  -- Terminal secondary
            muted     = "#93A1A1",  -- Terminal muted
            subtle    = "#657B83",  -- Terminal subtle
        },
        
        -- Blue Family: Electric cyan spectrum
        blue = {
            primary   = "#00D7FF",  -- Electric cyan
            dark      = "#0099CC",  -- Deep cyan
            light     = "#33E0FF",  -- Light cyan
            bright    = "#66E8FF",  -- Bright cyan
        },
        
        -- Teal Family: Cyber teal
        teal = {
            primary   = "#00CED1",  -- Cyber teal
            dark      = "#008B8B",  -- Deep teal
            light     = "#40E0D0",  -- Light teal
            bright    = "#7FFFD4",  -- Bright teal
        },
        
        -- Green Family: Electric green spectrum
        green = {
            primary   = "#38E8AA",  -- Electric green
            dark      = "#20B887",  -- Deep green
            light     = "#52F0B8",  -- Light green
            bright    = "#6FFFC6",  -- Bright green
        },
        
        -- Purple Family: Neon purple spectrum
        purple = {
            primary   = "#9D7CD8",  -- Neon purple
            dark      = "#7B5CB5",  -- Deep purple
            light     = "#B599E8",  -- Light purple
            bright    = "#D4B5FF",  -- Bright purple
        },
        
        -- Orange Family: Electric warm spectrum
        orange = {
            primary   = "#FF8C00",  -- Electric orange
            dark      = "#CC6600",  -- Deep orange
            light     = "#FFA533",  -- Light orange
            bright    = "#FFBF66",  -- Bright orange
        },
        
        -- Red Family: Neon danger spectrum
        red = {
            primary   = "#DC322F",  -- Neon red
            dark      = "#B21E1B",  -- Deep red
            light     = "#E85D58",  -- Light red
            bright    = "#FF7A75",  -- Bright red
        }
    }
}

-- Generate semantic color mappings for backward compatibility
function M.get_semantic_colors(theme_name)
    local palette = M.palettes[theme_name]
    if not palette then return nil end
    
    return {
        -- Legacy mapping for backward compatibility
        bg = {
            primary = palette.bg.primary,
            secondary = palette.bg.secondary,
            float = palette.bg.float,
            highlight = palette.bg.highlight,
        },
        fg = {
            primary = palette.fg.primary,
            secondary = palette.fg.secondary,
            muted = palette.fg.muted,
            subtle = palette.fg.subtle,
        },
        syntax = {
            func = palette.blue.primary,
            keyword = palette.purple.primary,
            string = palette.green.primary,
            type = palette.teal.primary,
            const = palette.orange.primary,
            special = palette.teal.light,
        },
        diag = {
            error = palette.red.primary,
            warn = palette.orange.light,
            info = palette.blue.light,
            hint = palette.green.light,
        }
    }
end

-- Get full extended palette
function M.get_extended_colors(theme_name)
    return M.palettes[theme_name]
end

-- Get all 32 colors as flat list for previews
function M.get_color_list(theme_name)
    local palette = M.palettes[theme_name]
    if not palette then return {} end
    
    local colors = {}
    for family_name, family in pairs(palette) do
        for variant_name, color in pairs(family) do
            table.insert(colors, {
                name = family_name .. '.' .. variant_name,
                family = family_name,
                variant = variant_name,
                hex = color,
            })
        end
    end
    
    return colors
end

return M