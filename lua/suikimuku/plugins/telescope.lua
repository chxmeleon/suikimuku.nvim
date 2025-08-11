-- Telescope.nvim Plugin Support for Suikimuku.nvim
-- Comprehensive theming for fuzzy finder and picker

local M = {}

-- Plugin metadata
M.name = "telescope.nvim"
M.description = "Fuzzy finder and picker interface"
M.url = "https://github.com/nvim-telescope/telescope.nvim"

-- Generate highlights for Telescope
function M.highlights(colors, plugin_config, global_config)
    local highlights = {}
    local style = plugin_config.style or "bordered"
    
    -- Core Telescope interface
    highlights.TelescopeNormal = { fg = colors.fg.primary, bg = colors.bg.float }
    highlights.TelescopeBorder = { fg = colors.blue.primary, bg = colors.bg.float }
    highlights.TelescopeTitle = { fg = colors.blue.primary, bold = true }
    
    -- Prompt styling
    highlights.TelescopePromptNormal = { fg = colors.fg.primary, bg = colors.bg.secondary }
    highlights.TelescopePromptBorder = { fg = colors.blue.primary, bg = colors.bg.secondary }
    highlights.TelescopePromptTitle = { fg = colors.bg.primary, bg = colors.blue.primary, bold = true }
    highlights.TelescopePromptPrefix = { fg = colors.blue.primary, bg = colors.bg.secondary }
    highlights.TelescopePromptCounter = { fg = colors.fg.muted }
    
    -- Results area
    highlights.TelescopeResultsNormal = { fg = colors.fg.primary, bg = colors.bg.float }
    highlights.TelescopeResultsBorder = { fg = colors.fg.subtle, bg = colors.bg.float }
    highlights.TelescopeResultsTitle = { fg = colors.fg.primary, bg = colors.bg.highlight, bold = true }
    
    -- Preview area
    highlights.TelescopePreviewNormal = { fg = colors.fg.primary, bg = colors.bg.primary }
    highlights.TelescopePreviewBorder = { fg = colors.fg.subtle, bg = colors.bg.primary }
    highlights.TelescopePreviewTitle = { fg = colors.green.primary, bg = colors.bg.highlight, bold = true }
    
    -- Selection and matching
    highlights.TelescopeSelection = { fg = colors.fg.primary, bg = colors.bg.highlight, bold = true }
    highlights.TelescopeSelectionCaret = { fg = colors.blue.primary, bg = colors.bg.highlight }
    highlights.TelescopeMultiSelection = { fg = colors.orange.primary, bg = colors.bg.secondary }
    highlights.TelescopeMultiIcon = { fg = colors.orange.primary }
    
    -- Matching text highlighting
    highlights.TelescopeMatching = { fg = colors.orange.primary, bold = true }
    
    -- File type and path styling
    highlights.TelescopeResultsClass = { fg = colors.teal.primary }
    highlights.TelescopeResultsConstant = { fg = colors.orange.primary }
    highlights.TelescopeResultsField = { fg = colors.teal.primary }
    highlights.TelescopeResultsFunction = { fg = colors.blue.primary }
    highlights.TelescopeResultsMethod = { fg = colors.blue.primary }
    highlights.TelescopeResultsOperator = { fg = colors.fg.secondary }
    highlights.TelescopeResultsStruct = { fg = colors.teal.primary }
    highlights.TelescopeResultsVariable = { fg = colors.fg.primary }
    highlights.TelescopeResultsLineNr = { fg = colors.orange.primary }
    highlights.TelescopeResultsIdentifier = { fg = colors.teal.primary }
    highlights.TelescopeResultsNumber = { fg = colors.orange.primary }
    highlights.TelescopeResultsComment = { fg = colors.fg.subtle, italic = true }
    highlights.TelescopeResultsSpecialComment = { fg = colors.green.primary, italic = true }
    
    -- File icons and paths
    highlights.TelescopeResultsDiffAdd = { fg = colors.green.primary }
    highlights.TelescopeResultsDiffChange = { fg = colors.blue.primary }  
    highlights.TelescopeResultsDiffDelete = { fg = colors.red.primary }
    highlights.TelescopeResultsDiffUntracked = { fg = colors.orange.primary }
    
    -- Git status integration
    highlights.TelescopeResultsFileIcon = { fg = colors.blue.primary }
    
    -- Style-specific customizations
    if style == "borderless" then
        -- Borderless style - blend borders with background
        highlights.TelescopeBorder.fg = colors.bg.float
        highlights.TelescopePromptBorder.fg = colors.bg.secondary
        highlights.TelescopeResultsBorder.fg = colors.bg.float
        highlights.TelescopePreviewBorder.fg = colors.bg.primary
    elseif style == "bordered" then
        -- Enhanced borders for better visibility
        highlights.TelescopeBorder.fg = colors.blue.primary
        highlights.TelescopePromptBorder.fg = colors.blue.primary
    end
    
    -- Theme-specific enhancements
    if global_config.style == "sui" then
        -- Digital Aquarium theme - electric highlights
        highlights.TelescopeMatching.fg = colors.blue.bright or colors.blue.primary
        highlights.TelescopeSelection.bg = colors.bg.highlight
        highlights.TelescopePromptTitle.bg = colors.blue.primary
        
    elseif global_config.style == "ki" then
        -- Crystal Light theme - clean and bright
        highlights.TelescopeNormal.bg = colors.bg.primary
        highlights.TelescopeResultsNormal.bg = colors.bg.primary
        highlights.TelescopeSelection.bg = colors.blue.light or colors.bg.highlight
        
    elseif global_config.style == "mu" then
        -- WCAG Grayscale - maximum contrast
        highlights.TelescopeMatching.fg = colors.fg.primary
        highlights.TelescopeMatching.bold = true
        highlights.TelescopeMatching.underline = true
        highlights.TelescopeSelection.bold = true
        highlights.TelescopePromptTitle.bold = true
        
    elseif global_config.style == "ku" then
        -- Enhanced Terminal - electric effects
        highlights.TelescopeMatching.fg = colors.blue.bright or colors.blue.primary
        highlights.TelescopeSelection.bold = true
        highlights.TelescopePromptTitle.bg = colors.blue.primary
        highlights.TelescopePromptTitle.bold = true
    end
    
    return highlights
end

-- Telescope integration utilities
function M.get_theme()
    local colors = require("suikimuku.core.colors")
    local config = require("suikimuku.core.config").get_config()
    local theme_colors = colors.get(config.style, 'legacy')
    
    -- Return Telescope theme table
    return {
        -- Core colors
        normal = theme_colors.bg.float,
        insert = theme_colors.blue.primary,
        visual = theme_colors.orange.primary,
        replace = theme_colors.red.primary,
        command = theme_colors.green.primary,
        
        -- UI elements
        prompt = theme_colors.bg.secondary,
        results = theme_colors.bg.float,
        preview = theme_colors.bg.primary,
        
        -- Text colors
        prompt_fg = theme_colors.fg.primary,
        results_fg = theme_colors.fg.primary,
        preview_fg = theme_colors.fg.primary,
        
        -- Borders
        prompt_border = theme_colors.blue.primary,
        results_border = theme_colors.fg.subtle,
        preview_border = theme_colors.fg.subtle,
        
        -- Special highlights
        selection = theme_colors.bg.highlight,
        matching = theme_colors.orange.primary,
    }
end

-- Setup Telescope integration
function M.setup()
    local telescope_ok, telescope = pcall(require, "telescope")
    if not telescope_ok then
        return
    end
    
    -- Apply theme to Telescope
    local theme_data = M.get_theme()
    
    -- Register custom theme with Telescope
    if telescope.load_extension then
        -- Custom Telescope theme integration would go here
        -- This is a placeholder for potential future Telescope theme integration
    end
end

-- Validation
function M.validate()
    local issues = {}
    
    -- Check if Telescope is available
    local ok, _ = pcall(require, "telescope")
    if not ok then
        table.insert(issues, "Telescope not found")
    end
    
    return issues
end

return M