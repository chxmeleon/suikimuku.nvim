-- OKLCH Color Utility Functions for Suikimuku.nvim
-- Provides OKLCH to Hex conversion with perceptually uniform color manipulation

local M = {}

-- OKLCH to OKLab conversion
local function oklch_to_oklab(l, c, h)
    local h_rad = math.rad(h)
    local a = c * math.cos(h_rad)
    local b = c * math.sin(h_rad)
    return l, a, b
end

-- OKLab to Linear RGB conversion
local function oklab_to_linear_rgb(l, a, b)
    local l_ = l + 0.3963377774 * a + 0.2158037573 * b
    local m_ = l - 0.1055613458 * a - 0.0638541728 * b
    local s_ = l - 0.0894841775 * a - 1.2914855480 * b

    local l_cubed = l_ * l_ * l_
    local m_cubed = m_ * m_ * m_
    local s_cubed = s_ * s_ * s_

    return 
        4.0767416621 * l_cubed - 3.3077115913 * m_cubed + 0.2309699292 * s_cubed,
        -1.2684380046 * l_cubed + 2.6097574011 * m_cubed - 0.3413193965 * s_cubed,
        -0.0041960863 * l_cubed - 0.7034186147 * m_cubed + 1.7076147010 * s_cubed
end

-- Linear RGB to sRGB conversion
local function linear_to_srgb(c)
    if c >= 0.0031308 then
        return 1.055 * (c ^ (1.0 / 2.4)) - 0.055
    else
        return 12.92 * c
    end
end

-- Clamp value between 0 and 1
local function clamp(value)
    return math.max(0, math.min(1, value))
end

-- Convert OKLCH to Hex
function M.oklchToHex(l, c, h)
    -- Convert OKLCH to OKLab
    local lab_l, lab_a, lab_b = oklch_to_oklab(l, c, h)
    
    -- Convert OKLab to Linear RGB
    local r_linear, g_linear, b_linear = oklab_to_linear_rgb(lab_l, lab_a, lab_b)
    
    -- Convert Linear RGB to sRGB and clamp
    local r = clamp(linear_to_srgb(r_linear))
    local g = clamp(linear_to_srgb(g_linear))
    local b = clamp(linear_to_srgb(b_linear))
    
    -- Convert to 0-255 range and format as hex
    local r_int = math.floor(r * 255 + 0.5)
    local g_int = math.floor(g * 255 + 0.5)
    local b_int = math.floor(b * 255 + 0.5)
    
    return string.format("#%02x%02x%02x", r_int, g_int, b_int)
end

-- Convenience function similar to solarized-osaka's hsl() function
function M.oklch(l, c, h)
    return M.oklchToHex(l / 100, c / 100, h or 0)
end

-- Advanced OKLCH manipulation functions

-- Adjust lightness while maintaining chroma and hue
function M.lighten(l, c, h, amount)
    local new_l = math.min(100, l + amount)
    return M.oklch(new_l, c, h)
end

-- Adjust lightness while maintaining chroma and hue
function M.darken(l, c, h, amount)
    local new_l = math.max(0, l - amount)
    return M.oklch(new_l, c, h)
end

-- Adjust chroma (saturation) while maintaining lightness and hue
function M.saturate(l, c, h, amount)
    local new_c = math.min(100, c + amount)
    return M.oklch(l, new_c, h)
end

-- Adjust chroma (saturation) while maintaining lightness and hue
function M.desaturate(l, c, h, amount)
    local new_c = math.max(0, c - amount)
    return M.oklch(l, new_c, h)
end

-- Rotate hue while maintaining lightness and chroma
function M.rotate_hue(l, c, h, degrees)
    local new_h = (h + degrees) % 360
    return M.oklch(l, c, new_h)
end

-- Generate a complementary color (180° hue rotation)
function M.complement(l, c, h)
    return M.rotate_hue(l, c, h, 180)
end

-- Generate analogous colors (±30° hue rotation)
function M.analogous(l, c, h)
    return {
        M.rotate_hue(l, c, h, -30),
        M.oklch(l, c, h), -- original
        M.rotate_hue(l, c, h, 30)
    }
end

-- Generate triadic colors (120° hue rotations)
function M.triadic(l, c, h)
    return {
        M.oklch(l, c, h), -- original
        M.rotate_hue(l, c, h, 120),
        M.rotate_hue(l, c, h, 240)
    }
end

-- Generate a monochromatic color family with different lightness values
function M.monochromatic_family(base_l, c, h, steps)
    local colors = {}
    local step_size = (100 - 20) / (steps - 1) -- Range from 20% to 100% lightness
    
    for i = 1, steps do
        local l = 20 + (i - 1) * step_size
        table.insert(colors, M.oklch(l, c, h))
    end
    
    return colors
end

-- Generate perceptually uniform color scale
function M.color_scale(start_l, start_c, start_h, end_l, end_c, end_h, steps)
    local colors = {}
    
    for i = 1, steps do
        local t = (i - 1) / (steps - 1)
        local l = start_l + t * (end_l - start_l)
        local c = start_c + t * (end_c - start_c)
        local h = start_h + t * (end_h - start_h)
        
        table.insert(colors, M.oklch(l, c, h))
    end
    
    return colors
end

-- Palette generation functions for Suikimuku themes

-- Generate OKLCH-based color families for consistent perceptual relationships
function M.generate_color_family(base_l, base_c, base_h)
    return {
        primary = M.oklch(base_l, base_c, base_h),
        dark = M.oklch(base_l - 15, base_c * 0.8, base_h),
        light = M.oklch(base_l + 15, base_c * 0.9, base_h),
        bright = M.oklch(base_l + 10, base_c * 1.2, base_h)
    }
end

-- Ensure colors meet WCAG contrast requirements
function M.ensure_contrast(fg_l, fg_c, fg_h, bg_l, bg_c, bg_h, target_ratio)
    target_ratio = target_ratio or 4.5 -- WCAG AA standard
    
    -- Simplified contrast estimation based on lightness difference
    local lightness_diff = math.abs(fg_l - bg_l)
    local min_diff = target_ratio * 10 -- Rough approximation
    
    if lightness_diff < min_diff then
        if fg_l > bg_l then
            fg_l = math.min(100, bg_l + min_diff)
        else
            fg_l = math.max(0, bg_l - min_diff)
        end
    end
    
    return M.oklch(fg_l, fg_c, fg_h)
end

-- Validate OKLCH values are within valid ranges
function M.validate_oklch(l, c, h)
    l = math.max(0, math.min(100, l))
    c = math.max(0, math.min(100, c))
    h = h % 360
    return l, c, h
end

-- Convert hex back to approximate OKLCH (for analysis purposes)
-- Note: This is approximate and may not be perfectly accurate
function M.hex_to_oklch_approx(hex)
    -- Remove # if present
    hex = hex:gsub("#", "")
    
    -- Convert hex to RGB
    local r = tonumber(hex:sub(1, 2), 16) / 255
    local g = tonumber(hex:sub(3, 4), 16) / 255
    local b = tonumber(hex:sub(5, 6), 16) / 255
    
    -- Approximate OKLCH conversion (simplified)
    -- This is a rough approximation for analysis purposes
    local l = (0.299 * r + 0.587 * g + 0.114 * b) * 100
    local c = math.sqrt((r - g)^2 + (g - b)^2 + (b - r)^2) * 50
    local h = math.deg(math.atan2(g - b, r - g)) % 360
    
    return l, c, h
end

return M