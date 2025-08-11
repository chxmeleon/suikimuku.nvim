-- OKLCH-Based Extended Color System for Suikimuku.nvim
-- Using perceptually uniform OKLCH color space for mathematically consistent color relationships

local util = require("suikimuku.util")
local oklch = require("suikimuku.oklch")

local M = {}

---@class Palette
M.default = {
    none = "NONE",
    
    -- Background Family - Deep ocean depths with consistent lightness progression
    bg_primary   = oklch(12, 15, 180),  -- Deep teal background
    bg_secondary = oklch(18, 12, 180),  -- Slightly lighter teal
    bg_float     = oklch(25, 10, 180),  -- Floating elements
    bg_highlight = oklch(35, 8, 180),   -- Selection highlights
    
    -- Foreground Family - Aquatic clarity with perceptual uniformity
    fg_primary   = oklch(80, 8, 180),   -- Clear water primary text
    fg_secondary = oklch(65, 12, 180),  -- Sea foam secondary text
    fg_muted     = oklch(85, 15, 200),  -- Misty water
    fg_subtle    = oklch(55, 10, 170),  -- Deep water subtle
}

---@class Palette  
M.sui = {
    none = "NONE",
    
    -- Background Family - Digital Aquarium depths
    bg_primary   = oklch(12, 15, 180),  -- Deep sea #0A1B1A
    bg_secondary = oklch(18, 12, 175),  -- Ocean depths #0F2A28
    bg_float     = oklch(25, 10, 170),  -- Kelp forest #1A3E3B  
    bg_highlight = oklch(35, 8, 165),   -- Bioluminescent selection #2A5651
    
    -- Foreground Family - Aquatic text hierarchy
    fg_primary   = oklch(82, 8, 180),   -- Clear water #A7DBD8
    fg_secondary = oklch(68, 12, 175),  -- Sea foam #7BBAB1
    fg_muted     = oklch(88, 15, 200),  -- Light mist #C8E6F5
    fg_subtle    = oklch(58, 10, 170),  -- Deep current #6B9F96
    
    -- Blue Family - Electric bioluminescence (consistent chroma for harmony)
    blue_primary = oklch(75, 25, 220),  -- Electric jellyfish #69D2E7
    blue_dark    = oklch(60, 20, 215),  -- Deep ocean blue #4A9BB0
    blue_light   = oklch(85, 20, 225),  -- Bright bioluminescence #87E0F0
    blue_bright  = oklch(90, 30, 230),  -- Electric highlight #A0F0FF
    
    -- Teal Family - Primary aqua theme colors (maintaining hue consistency)
    teal_primary = oklch(82, 8, 180),   -- Aqua mint #A7DBD8
    teal_dark    = oklch(68, 12, 175),  -- Deep aqua #7BBAB1
    teal_light   = oklch(88, 15, 185),  -- Light aqua mist #C8E6F5
    teal_bright  = oklch(85, 18, 190),  -- Bright aqua #B5F0ED
    
    -- Green Family - Underwater kelp growth (natural green spectrum)
    green_primary = oklch(70, 30, 140), -- Kelp green #52C489
    green_dark    = oklch(55, 25, 135), -- Deep kelp #3A8B5F
    green_light   = oklch(78, 25, 145), -- Bright kelp #6FD49F
    green_bright  = oklch(85, 35, 150), -- Electric kelp #7DE8A8
    
    -- Purple Family - Ocean mystery depths (shifted towards blue-purple)
    purple_primary = oklch(72, 28, 250), -- Ocean mystery #1e9ee8
    purple_dark    = oklch(57, 23, 245), -- Deep mystery #1570A8
    purple_light   = oklch(80, 23, 255), -- Light mystery #4BB8F0
    purple_bright  = oklch(85, 33, 260), -- Bright mystery #66C8FF
    
    -- Orange Family - Coral warmth (warm accent in cool palette)
    orange_primary = oklch(65, 40, 45),  -- Coral orange #F38630
    orange_dark    = oklch(50, 35, 40),  -- Deep coral #B85E20
    orange_light   = oklch(75, 35, 50),  -- Light coral #FF9D4D
    orange_bright  = oklch(80, 45, 55),  -- Bright coral #FFB366
    
    -- Red Family - Deep danger warnings
    red_primary = oklch(60, 35, 25),     -- Danger red #E85A4F
    red_dark    = oklch(45, 30, 20),     -- Deep danger #B03E35
    red_light   = oklch(70, 30, 30),     -- Light danger #F2776B
    red_bright  = oklch(75, 40, 35),     -- Bright danger #FF8A7F
}

---@class Palette
M.ki = {
    none = "NONE",
    
    -- Background Family - Crystal clarity (high lightness, low chroma)
    bg_primary   = oklch(98, 2, 220),    -- Pure crystal #FAFCFF
    bg_secondary = oklch(95, 3, 215),    -- Light crystal #F0F9FF
    bg_float     = oklch(92, 5, 210),    -- Floating crystal #E1F5FE
    bg_highlight = oklch(85, 8, 205),    -- Crystal selection #CBD5E1
    
    -- Foreground Family - Clear text on light background
    fg_primary   = oklch(45, 8, 220),    -- Primary clarity #475569
    fg_secondary = oklch(55, 12, 215),   -- Secondary clarity #64748B
    fg_muted     = oklch(65, 10, 210),   -- Muted clarity #94A3B8
    fg_subtle    = oklch(75, 8, 205),    -- Subtle clarity #CBD5E1
    
    -- Blue Family - Crystal blue spectrum
    blue_primary = oklch(65, 35, 250),   -- Crystal blue #3B82F6
    blue_dark    = oklch(50, 40, 245),   -- Deep crystal #1E40AF
    blue_light   = oklch(75, 30, 255),   -- Light crystal #60A5FA
    blue_bright  = oklch(85, 25, 260),   -- Bright crystal #93C5FD
    
    -- Teal Family - Crystal teal variants
    teal_primary = oklch(70, 30, 200),   -- Crystal teal #06B6D4
    teal_dark    = oklch(60, 25, 195),   -- Deep teal #0891B2
    teal_light   = oklch(80, 25, 205),   -- Light teal #22D3EE
    teal_bright  = oklch(88, 30, 210),   -- Bright teal #67E8F9
    
    -- Green Family - Crystal green spectrum
    green_primary = oklch(65, 35, 160),  -- Crystal green #10B981
    green_dark    = oklch(55, 30, 155),  -- Deep green #059669
    green_light   = oklch(75, 30, 165),  -- Light green #34D399
    green_bright  = oklch(85, 35, 170),  -- Bright green #6EE7B7
    
    -- Purple Family - Crystal purple spectrum
    purple_primary = oklch(65, 40, 280), -- Crystal purple #8B5CF6
    purple_dark    = oklch(55, 45, 275), -- Deep purple #7C3AED
    purple_light   = oklch(75, 35, 285), -- Light purple #A78BFA
    purple_bright  = oklch(85, 30, 290), -- Bright purple #C4B5FD
    
    -- Orange Family - Crystal warm tones
    orange_primary = oklch(70, 40, 50),  -- Crystal orange #F97316
    orange_dark    = oklch(60, 45, 45),  -- Deep orange #EA580C
    orange_light   = oklch(80, 35, 55),  -- Light orange #FB923C
    orange_bright  = oklch(88, 40, 60),  -- Bright orange #FDBA74
    
    -- Red Family - Crystal danger tones
    red_primary = oklch(60, 45, 15),     -- Crystal red #E11D48
    red_dark    = oklch(50, 50, 10),     -- Deep red #BE123C
    red_light   = oklch(70, 40, 20),     -- Light red #F43F5E
    red_bright  = oklch(80, 35, 25),     -- Bright red #FB7185
}

---@class Palette
M.mu = {
    none = "NONE",
    
    -- Background Family - High-contrast grayscale (zero chroma)
    bg_primary   = oklch(0, 0, 0),       -- Pure black #000000
    bg_secondary = oklch(15, 0, 0),      -- Dark gray #1A1A1A
    bg_float     = oklch(25, 0, 0),      -- Medium dark #2D2D2D
    bg_highlight = oklch(35, 0, 0),      -- Highlight gray #404040
    
    -- Foreground Family - High contrast text hierarchy
    fg_primary   = oklch(100, 0, 0),     -- Pure white #FFFFFF
    fg_secondary = oklch(90, 0, 0),      -- Light gray #E6E6E6
    fg_muted     = oklch(80, 0, 0),      -- Medium gray #CCCCCC
    fg_subtle    = oklch(60, 0, 0),      -- Subtle gray #808080
    
    -- All color families use grayscale values (zero chroma for accessibility)
    blue_primary = oklch(82, 0, 0),      -- Light gray #D4D4D4
    blue_dark    = oklch(60, 0, 0),      -- Medium gray #808080
    blue_light   = oklch(90, 0, 0),      -- Very light #E6E6E6
    blue_bright  = oklch(94, 0, 0),      -- Bright gray #F0F0F0
    
    teal_primary = oklch(80, 0, 0),      -- Light gray #CCCCCC
    teal_dark    = oklch(65, 0, 0),      -- Medium gray #909090
    teal_light   = oklch(88, 0, 0),      -- Very light #E0E0E0
    teal_bright  = oklch(96, 0, 0),      -- Bright gray #F5F5F5
    
    green_primary = oklch(72, 0, 0),     -- Medium light #B8B8B8
    green_dark    = oklch(50, 0, 0),     -- Dark gray #707070
    green_light   = oklch(82, 0, 0),     -- Light gray #D0D0D0
    green_bright  = oklch(91, 0, 0),     -- Bright gray #E8E8E8
    
    purple_primary = oklch(70, 0, 0),    -- Medium gray #A0A0A0
    purple_dark    = oklch(45, 0, 0),    -- Dark gray #606060
    purple_light   = oklch(78, 0, 0),    -- Light gray #C0C0C0
    purple_bright  = oklch(87, 0, 0),    -- Bright gray #DEDEDE
    
    orange_primary = oklch(65, 0, 0),    -- Medium gray #909090
    orange_dark    = oklch(38, 0, 0),    -- Dark gray #505050
    orange_light   = oklch(75, 0, 0),    -- Light gray #B0B0B0
    orange_bright  = oklch(85, 0, 0),    -- Bright gray #D8D8D8
    
    red_primary = oklch(60, 0, 0),       -- Medium gray #808080
    red_dark    = oklch(35, 0, 0),       -- Dark gray #404040
    red_light   = oklch(70, 0, 0),       -- Light gray #A0A0A0
    red_bright  = oklch(78, 0, 0),       -- Bright gray #C8C8C8
}

---@class Palette
M.ku = {
    none = "NONE",
    
    -- Background Family - Electric deep space (low lightness, moderate chroma)
    bg_primary   = oklch(8, 20, 200),    -- Deep space #000F10
    bg_secondary = oklch(20, 25, 210),   -- Electric deep #072842
    bg_float     = oklch(30, 20, 215),   -- Floating neon #283D5E
    bg_highlight = oklch(25, 15, 205),   -- Electric selection #203047
    
    -- Foreground Family - Terminal clarity
    fg_primary   = oklch(65, 8, 180),    -- Terminal primary #839496
    fg_secondary = oklch(50, 12, 175),   -- Terminal secondary #586E75
    fg_muted     = oklch(70, 6, 185),    -- Terminal muted #93A1A1
    fg_subtle    = oklch(58, 10, 170),   -- Terminal subtle #657B83
    
    -- Blue Family - Electric cyan spectrum (high chroma for vibrancy)
    blue_primary = oklch(80, 50, 200),   -- Electric cyan #00D7FF
    blue_dark    = oklch(65, 45, 195),   -- Deep cyan #0099CC
    blue_light   = oklch(85, 45, 205),   -- Light cyan #33E0FF
    blue_bright  = oklch(90, 55, 210),   -- Bright cyan #66E8FF
    
    -- Teal Family - Cyber teal variants
    teal_primary = oklch(75, 40, 180),   -- Cyber teal #00CED1
    teal_dark    = oklch(60, 35, 175),   -- Deep teal #008B8B
    teal_light   = oklch(85, 35, 185),   -- Light teal #40E0D0
    teal_bright  = oklch(92, 45, 190),   -- Bright teal #7FFFD4
    
    -- Green Family - Electric green spectrum
    green_primary = oklch(85, 45, 150),  -- Electric green #38E8AA
    green_dark    = oklch(70, 40, 145),  -- Deep green #20B887
    green_light   = oklch(90, 40, 155),  -- Light green #52F0B8
    green_bright  = oklch(95, 50, 160),  -- Bright green #6FFFC6
    
    -- Purple Family - Neon purple spectrum
    purple_primary = oklch(68, 35, 280), -- Neon purple #9D7CD8
    purple_dark    = oklch(55, 30, 275), -- Deep purple #7B5CB5
    purple_light   = oklch(78, 30, 285), -- Light purple #B599E8
    purple_bright  = oklch(88, 40, 290), -- Bright purple #D4B5FF
    
    -- Orange Family - Electric warm spectrum
    orange_primary = oklch(75, 50, 60),  -- Electric orange #FF8C00
    orange_dark    = oklch(60, 45, 55),  -- Deep orange #CC6600
    orange_light   = oklch(82, 45, 65),  -- Light orange #FFA533
    orange_bright  = oklch(88, 55, 70),  -- Bright orange #FFBF66
    
    -- Red Family - Neon danger spectrum
    red_primary = oklch(58, 40, 25),     -- Neon red #DC322F
    red_dark    = oklch(45, 35, 20),     -- Deep red #B21E1B
    red_light   = oklch(68, 35, 30),     -- Light red #E85D58
    red_bright  = oklch(78, 45, 35),     -- Bright red #FF7A75
}

-- Generate semantic color mappings for backward compatibility
function M.get_semantic_colors(theme_name)
    local palette = M[theme_name] or M.default
    
    return {
        -- Legacy mapping for backward compatibility
        bg = {
            primary = palette.bg_primary,
            secondary = palette.bg_secondary,
            float = palette.bg_float,
            highlight = palette.bg_highlight,
        },
        fg = {
            primary = palette.fg_primary,
            secondary = palette.fg_secondary,
            muted = palette.fg_muted,
            subtle = palette.fg_subtle,
        },
        syntax = {
            func = palette.blue_primary,
            keyword = palette.purple_primary,
            string = palette.green_primary,
            type = palette.teal_primary,
            const = palette.orange_primary,
            special = palette.teal_light,
        },
        diag = {
            error = palette.red_primary,
            warn = palette.orange_light,
            info = palette.blue_light,
            hint = palette.green_light,
        }
    }
end

-- Get full extended palette
function M.get_extended_colors(theme_name)
    return M[theme_name] or M.default
end

-- Setup function similar to solarized-osaka pattern
---@return ColorScheme
function M.setup(opts)
    opts = opts or {}
    local config = require("suikimuku.config")
    
    -- Determine which palette to use
    local style = opts.style or config.options.style or "sui"
    local palette = M[style] or M.default
    
    if type(palette) == "function" then
        palette = palette()
    end
    
    -- Color Palette with OKLCH-generated colors
    ---@class ColorScheme: Palette
    local colors = vim.tbl_deep_extend("force", vim.deepcopy(palette), {})
    
    -- Set utility background for other functions
    util.bg = colors.bg_primary
    
    -- Generate dynamic colors using OKLCH relationships
    colors.black = oklch.darken(70, 8, 180, 60) -- Derived from theme
    colors.border = colors.black
    
    -- Semantic color assignments
    colors.error = colors.red_primary
    colors.warning = colors.orange_primary  
    colors.info = colors.blue_primary
    colors.hint = colors.teal_primary
    colors.todo = colors.purple_primary
    
    -- Terminal colors using OKLCH for consistent brightness
    colors.terminal = {
        black = colors.bg_primary,
        black_bright = colors.bg_highlight,
        red = colors.red_primary,
        red_bright = colors.red_bright,
        green = colors.green_primary,
        green_bright = colors.green_bright,
        yellow = colors.orange_primary, -- Orange used as yellow
        yellow_bright = colors.orange_bright,
        blue = colors.blue_primary,
        blue_bright = colors.blue_bright,
        magenta = colors.purple_primary,
        magenta_bright = colors.purple_bright,
        cyan = colors.teal_primary,
        cyan_bright = colors.teal_bright,
        white = colors.fg_secondary,
        white_bright = colors.fg_primary,
    }
    
    return colors
end

return M