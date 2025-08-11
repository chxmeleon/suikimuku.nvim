-- Lualine Plugin Support for Suikimuku.nvim
-- Status line theming and integration

local M = {}

-- Plugin metadata
M.name = "lualine.nvim"
M.description = "Fast and customizable statusline"
M.url = "https://github.com/nvim-lualine/lualine.nvim"

-- Generate highlights for Lualine
function M.highlights(colors, plugin_config, global_config)
    local highlights = {}
    
    -- Note: Lualine uses its own theming system rather than highlight groups
    -- These highlights are for any Lualine-related UI elements that might use standard groups
    
    -- Status line base
    highlights.StatusLine = { fg = colors.fg.primary, bg = colors.bg.secondary }
    highlights.StatusLineNC = { fg = colors.fg.subtle, bg = colors.bg.secondary }
    
    -- Mode-specific colors (used by some Lualine configurations)
    highlights.lualine_a_normal = { fg = colors.bg.primary, bg = colors.blue.primary, bold = true }
    highlights.lualine_a_insert = { fg = colors.bg.primary, bg = colors.green.primary, bold = true }
    highlights.lualine_a_visual = { fg = colors.bg.primary, bg = colors.orange.primary, bold = true }
    highlights.lualine_a_replace = { fg = colors.bg.primary, bg = colors.red.primary, bold = true }
    highlights.lualine_a_command = { fg = colors.bg.primary, bg = colors.purple.primary, bold = true }
    
    -- Section backgrounds
    highlights.lualine_b_normal = { fg = colors.fg.primary, bg = colors.bg.highlight }
    highlights.lualine_c_normal = { fg = colors.fg.secondary, bg = colors.bg.secondary }
    
    return highlights
end

-- Generate complete Lualine theme
function M.get_lualine_theme(colors, style)
    local theme = {}
    
    -- Helper function to create section colors
    local function create_section(fg, bg, gui)
        return { fg = fg, bg = bg, gui = gui or "NONE" }
    end
    
    -- Normal mode
    theme.normal = {
        a = create_section(colors.bg.primary, colors.blue.primary, "bold"),
        b = create_section(colors.fg.primary, colors.bg.highlight),
        c = create_section(colors.fg.secondary, colors.bg.secondary),
        x = create_section(colors.fg.secondary, colors.bg.secondary),
        y = create_section(colors.fg.primary, colors.bg.highlight),
        z = create_section(colors.bg.primary, colors.blue.primary, "bold")
    }
    
    -- Insert mode
    theme.insert = {
        a = create_section(colors.bg.primary, colors.green.primary, "bold"),
        b = create_section(colors.fg.primary, colors.bg.highlight),
        c = create_section(colors.fg.secondary, colors.bg.secondary),
        x = create_section(colors.fg.secondary, colors.bg.secondary),
        y = create_section(colors.fg.primary, colors.bg.highlight),
        z = create_section(colors.bg.primary, colors.green.primary, "bold")
    }
    
    -- Visual mode
    theme.visual = {
        a = create_section(colors.bg.primary, colors.orange.primary, "bold"),
        b = create_section(colors.fg.primary, colors.bg.highlight),
        c = create_section(colors.fg.secondary, colors.bg.secondary),
        x = create_section(colors.fg.secondary, colors.bg.secondary),
        y = create_section(colors.fg.primary, colors.bg.highlight),
        z = create_section(colors.bg.primary, colors.orange.primary, "bold")
    }
    
    -- Replace mode
    theme.replace = {
        a = create_section(colors.bg.primary, colors.red.primary, "bold"),
        b = create_section(colors.fg.primary, colors.bg.highlight),
        c = create_section(colors.fg.secondary, colors.bg.secondary),
        x = create_section(colors.fg.secondary, colors.bg.secondary),
        y = create_section(colors.fg.primary, colors.bg.highlight),
        z = create_section(colors.bg.primary, colors.red.primary, "bold")
    }
    
    -- Command mode
    theme.command = {
        a = create_section(colors.bg.primary, colors.purple.primary, "bold"),
        b = create_section(colors.fg.primary, colors.bg.highlight),
        c = create_section(colors.fg.secondary, colors.bg.secondary),
        x = create_section(colors.fg.secondary, colors.bg.secondary),
        y = create_section(colors.fg.primary, colors.bg.highlight),
        z = create_section(colors.bg.primary, colors.purple.primary, "bold")
    }
    
    -- Inactive
    theme.inactive = {
        a = create_section(colors.fg.subtle, colors.bg.secondary),
        b = create_section(colors.fg.subtle, colors.bg.secondary),
        c = create_section(colors.fg.subtle, colors.bg.secondary),
        x = create_section(colors.fg.subtle, colors.bg.secondary),
        y = create_section(colors.fg.subtle, colors.bg.secondary),
        z = create_section(colors.fg.subtle, colors.bg.secondary)
    }
    
    -- Theme-specific adjustments
    if style == "sui" then
        -- Digital Aquarium - oceanic flow
        theme.normal.a.bg = colors.teal.primary
        theme.normal.z.bg = colors.teal.primary
        theme.insert.a.bg = colors.green.primary
        theme.insert.z.bg = colors.green.primary
        
    elseif style == "ki" then
        -- Crystal Light - clean and bright
        -- Use lighter colors for better visibility on light background
        theme.normal.c.fg = colors.fg.primary
        theme.insert.c.fg = colors.fg.primary
        theme.visual.c.fg = colors.fg.primary
        theme.replace.c.fg = colors.fg.primary
        theme.command.c.fg = colors.fg.primary
        
    elseif style == "mu" then
        -- WCAG Grayscale - high contrast
        theme.normal.a = create_section(colors.bg.primary, colors.fg.primary, "bold")
        theme.normal.z = create_section(colors.bg.primary, colors.fg.primary, "bold")
        theme.insert.a = create_section(colors.bg.primary, colors.fg.primary, "bold")
        theme.insert.z = create_section(colors.bg.primary, colors.fg.primary, "bold")
        theme.visual.a = create_section(colors.bg.primary, colors.fg.secondary, "bold")
        theme.visual.z = create_section(colors.bg.primary, colors.fg.secondary, "bold")
        theme.replace.a = create_section(colors.fg.primary, colors.bg.primary, "bold")
        theme.replace.z = create_section(colors.fg.primary, colors.bg.primary, "bold")
        theme.command.a = create_section(colors.bg.primary, colors.fg.muted, "bold")
        theme.command.z = create_section(colors.bg.primary, colors.fg.muted, "bold")
        
    elseif style == "ku" then
        -- Enhanced Terminal - electric vibrancy
        theme.normal.a.bg = colors.blue.bright or colors.blue.primary
        theme.normal.z.bg = colors.blue.bright or colors.blue.primary
        theme.insert.a.bg = colors.green.bright or colors.green.primary
        theme.insert.z.bg = colors.green.bright or colors.green.primary
        theme.visual.a.bg = colors.orange.bright or colors.orange.primary
        theme.visual.z.bg = colors.orange.bright or colors.orange.primary
        theme.replace.a.bg = colors.red.bright or colors.red.primary
        theme.replace.z.bg = colors.red.bright or colors.red.primary
        theme.command.a.bg = colors.purple.bright or colors.purple.primary
        theme.command.z.bg = colors.purple.bright or colors.purple.primary
    end
    
    return theme
end

-- Get recommended Lualine configuration
function M.get_config(theme_style)
    local colors = require("suikimuku.core.colors")
    local theme_colors = colors.get(theme_style, 'legacy')
    local lualine_theme = M.get_lualine_theme(theme_colors, theme_style)
    
    local config = {
        options = {
            theme = lualine_theme,
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
    
    -- Theme-specific configuration adjustments
    if theme_style == "sui" then
        -- Digital Aquarium - flowing separators
        config.options.component_separators = { left = '|', right = '|' }
        config.options.section_separators = { left = '', right = '' }
        
    elseif theme_style == "ki" then
        -- Crystal Light - clean separators
        config.options.component_separators = { left = '', right = '' }
        config.options.section_separators = { left = '', right = '' }
        
    elseif theme_style == "mu" then
        -- WCAG Grayscale - high contrast separators
        config.options.component_separators = { left = '|', right = '|' }
        config.options.section_separators = { left = '|', right = '|' }
        
    elseif theme_style == "ku" then
        -- Enhanced Terminal - electric separators
        config.options.component_separators = { left = '', right = '' }
        config.options.section_separators = { left = '', right = '' }
    end
    
    return config
end

-- Setup Lualine integration
function M.setup()
    local lualine_ok, lualine = pcall(require, "lualine")
    if not lualine_ok then
        return
    end
    
    -- Get current configuration
    local config = require("suikimuku.core.config").get_config()
    
    -- Only setup if theme integration is enabled
    if config.plugins.lualine and config.plugins.lualine.theme_integration then
        local lualine_config = M.get_config(config.style)
        lualine.setup(lualine_config)
    end
end

-- Register theme with Lualine
function M.register_theme(theme_name)
    theme_name = theme_name or "suikimuku"
    
    local colors = require("suikimuku.core.colors")
    local config = require("suikimuku.core.config").get_config()
    local theme_colors = colors.get(config.style, 'legacy')
    local lualine_theme = M.get_lualine_theme(theme_colors, config.style)
    
    -- Try to register with Lualine's theme system
    local lualine_ok, lualine = pcall(require, "lualine")
    if lualine_ok then
        -- Store theme for Lualine to use
        package.loaded['lualine.themes.' .. theme_name] = lualine_theme
        return lualine_theme
    end
    
    return nil
end

-- Get theme for external use
function M.get_theme()
    local colors = require("suikimuku.core.colors")
    local config = require("suikimuku.core.config").get_config()
    local theme_colors = colors.get(config.style, 'legacy')
    
    return M.get_lualine_theme(theme_colors, config.style)
end

-- Validation
function M.validate()
    local issues = {}
    
    -- Check if Lualine is available
    local ok, _ = pcall(require, "lualine")
    if not ok then
        table.insert(issues, "Lualine not found")
    end
    
    return issues
end

return M