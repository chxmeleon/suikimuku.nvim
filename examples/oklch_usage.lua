-- Example usage of OKLCH functions in Suikimuku.nvim
-- Similar to solarized-osaka's HSL pattern but using OKLCH for perceptual uniformity

local oklch = require("suikimuku.oklch")

-- Basic usage similar to solarized-osaka's hsl() function
local examples = {
    -- OKLCH parameters: lightness (0-100), chroma (0-100), hue (0-360)
    
    -- Sui theme colors using OKLCH
    sui_bg = oklch(12, 15, 180),      -- Deep teal background
    sui_primary = oklch(75, 25, 220), -- Electric blue primary
    sui_green = oklch(70, 30, 140),   -- Kelp green
    
    -- Ki theme colors - higher lightness, lower chroma
    ki_bg = oklch(98, 2, 220),        -- Crystal white background
    ki_blue = oklch(65, 35, 250),     -- Crystal blue
    ki_text = oklch(45, 8, 220),      -- Dark text on light background
    
    -- Mu theme colors - zero chroma for accessibility
    mu_bg = oklch(0, 0, 0),           -- Pure black
    mu_text = oklch(100, 0, 0),       -- Pure white
    mu_gray = oklch(70, 0, 0),        -- Medium gray
    
    -- Ku theme colors - high chroma for vibrant terminal
    ku_bg = oklch(8, 20, 200),        -- Deep space background
    ku_cyan = oklch(80, 50, 200),     -- Electric cyan
    ku_purple = oklch(68, 35, 280),   -- Neon purple
}

-- Advanced OKLCH manipulations
local advanced_examples = {
    -- Create color variations
    base_color = oklch(70, 30, 220), -- Base blue
    lighter = oklch.lighten(70, 30, 220, 15), -- Lighten by 15%
    darker = oklch.darken(70, 30, 220, 15),   -- Darken by 15%
    more_vibrant = oklch.saturate(70, 30, 220, 20), -- Increase chroma
    muted = oklch.desaturate(70, 30, 220, 15), -- Decrease chroma
    
    -- Generate color harmonies
    complement = oklch.complement(70, 30, 220), -- 180° hue rotation
    analogous = oklch.analogous(70, 30, 220),   -- Returns table with 3 colors
    triadic = oklch.triadic(70, 30, 220),       -- Returns table with 3 colors
    
    -- Generate color families
    blue_family = oklch.generate_color_family(70, 30, 220),
    -- Returns: { primary, dark, light, bright }
    
    -- Create perceptual color scales
    gradient = oklch.color_scale(
        20, 15, 180,  -- Start: dark teal
        90, 25, 220,  -- End: light blue  
        5             -- Steps
    ),
}

-- Theme palette generation using OKLCH
local function create_sui_palette()
    return {
        -- Use consistent lightness and chroma relationships
        bg = {
            primary = oklch(12, 15, 180),   -- Deep sea
            secondary = oklch(18, 12, 175), -- Ocean depths
            float = oklch(25, 10, 170),     -- Kelp forest
            highlight = oklch(35, 8, 165),  -- Bioluminescent selection
        },
        
        -- Generate blue family with consistent relationships
        blue = oklch.generate_color_family(75, 25, 220),
        
        -- Generate complementary warm colors for accent
        orange = oklch.generate_color_family(65, 40, 45), -- ~180° from teal
        
        -- Create monochromatic variations for subtle differences
        teal_variants = oklch.monochromatic_family(82, 8, 180, 4),
    }
end

-- Color validation and accessibility
local function ensure_accessibility()
    return {
        -- Ensure good contrast between text and background
        accessible_text = oklch.ensure_contrast(
            80, 8, 180,  -- Foreground: light teal
            12, 15, 180, -- Background: dark teal
            4.5          -- Target contrast ratio (WCAG AA)
        ),
        
        -- Validate OKLCH values are in range
        validated_color = oklch.validate_oklch(120, -10, 450), -- Will clamp values
    }
end

-- Convert existing hex colors to OKLCH for analysis
local function analyze_existing_colors()
    local existing_hex = "#69D2E7" -- Current Sui blue
    local l, c, h = oklch.hex_to_oklch_approx(existing_hex)
    
    print(string.format("Color %s is approximately OKLCH(%.1f, %.1f, %.1f)", 
        existing_hex, l, c, h))
    
    -- Use these values to create consistent variations
    return {
        analyzed_primary = oklch(l, c, h),
        darker_variant = oklch(l - 15, c * 0.8, h),
        lighter_variant = oklch(l + 15, c * 0.9, h),
    }
end

return {
    examples = examples,
    advanced_examples = advanced_examples,
    create_sui_palette = create_sui_palette,
    ensure_accessibility = ensure_accessibility,
    analyze_existing_colors = analyze_existing_colors,
}