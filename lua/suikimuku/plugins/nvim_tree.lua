-- NvimTree Plugin Support for Suikimuku.nvim
-- File explorer theming and integration

local M = {}

-- Plugin metadata
M.name = "nvim-tree.lua"
M.description = "File explorer tree view"
M.url = "https://github.com/nvim-tree/nvim-tree.lua"

-- Generate highlights for NvimTree
function M.highlights(colors, plugin_config, global_config)
    local highlights = {}
    local transparency = plugin_config.transparency or false
    
    -- Background handling
    local bg = transparency and "NONE" or colors.bg.secondary
    local normal_bg = transparency and "NONE" or colors.bg.primary
    
    -- Core NvimTree interface
    highlights.NvimTreeNormal = { fg = colors.fg.primary, bg = bg }
    highlights.NvimTreeNormalNC = { fg = colors.fg.secondary, bg = bg }
    highlights.NvimTreeEndOfBuffer = { fg = bg, bg = bg }
    highlights.NvimTreeWinSeparator = { fg = colors.bg.highlight, bg = normal_bg }
    highlights.NvimTreeStatusLine = { fg = colors.fg.subtle, bg = bg }
    highlights.NvimTreeStatusLineNC = { fg = colors.fg.subtle, bg = bg }
    
    -- File and folder icons
    highlights.NvimTreeSymlink = { fg = colors.teal.primary }
    highlights.NvimTreeFolderName = { fg = colors.blue.primary }
    highlights.NvimTreeRootFolder = { fg = colors.orange.primary, bold = true }
    highlights.NvimTreeFolderIcon = { fg = colors.blue.primary }
    highlights.NvimTreeEmptyFolderName = { fg = colors.blue.dark or colors.fg.subtle }
    highlights.NvimTreeOpenedFolderName = { fg = colors.blue.bright or colors.blue.primary, bold = true }
    highlights.NvimTreeExecFile = { fg = colors.green.primary, bold = true }
    highlights.NvimTreeOpenedFile = { fg = colors.fg.primary, bold = true }
    highlights.NvimTreeSpecialFile = { fg = colors.orange.primary }
    highlights.NvimTreeImageFile = { fg = colors.purple.primary }
    highlights.NvimTreeMarkdownFile = { fg = colors.teal.primary }
    
    -- File type specific
    highlights.NvimTreeIndentMarker = { fg = colors.fg.subtle }
    highlights.NvimTreeLiveFilterPrefix = { fg = colors.orange.primary, bold = true }
    highlights.NvimTreeLiveFilterValue = { fg = colors.fg.primary, bold = true }
    
    -- Git integration
    highlights.NvimTreeGitDirty = { fg = colors.orange.primary }
    highlights.NvimTreeGitStaged = { fg = colors.green.primary }
    highlights.NvimTreeGitMerge = { fg = colors.orange.primary }
    highlights.NvimTreeGitRenamed = { fg = colors.purple.primary }
    highlights.NvimTreeGitNew = { fg = colors.green.primary }
    highlights.NvimTreeGitDeleted = { fg = colors.red.primary }
    highlights.NvimTreeGitIgnored = { fg = colors.fg.subtle }
    
    -- Selection and cursor
    highlights.NvimTreeCursorLine = { bg = colors.bg.highlight }
    highlights.NvimTreeCursorColumn = { bg = colors.bg.highlight }
    highlights.NvimTreeCursor = { bg = colors.bg.highlight }
    highlights.NvimTreeVisual = { bg = colors.bg.highlight }
    
    -- Popup and floating windows
    highlights.NvimTreePopup = { fg = colors.fg.primary, bg = colors.bg.float }
    highlights.NvimTreeSignColumn = { fg = colors.fg.subtle, bg = bg }
    
    -- File operations
    highlights.NvimTreeCopiedHL = { fg = colors.green.primary, bg = colors.bg.highlight }
    highlights.NvimTreeCutHL = { fg = colors.red.primary, bg = colors.bg.highlight }
    
    -- Diagnostics integration
    highlights.NvimTreeLspDiagnosticsError = { fg = colors.red.primary }
    highlights.NvimTreeLspDiagnosticsWarning = { fg = colors.orange.primary }
    highlights.NvimTreeLspDiagnosticsInformation = { fg = colors.blue.primary }
    highlights.NvimTreeLspDiagnosticsHint = { fg = colors.green.primary }
    
    -- Bookmarks
    highlights.NvimTreeBookmark = { fg = colors.purple.primary, bold = true }
    
    -- Theme-specific customizations
    if global_config.style == "sui" then
        -- Digital Aquarium - underwater file explorer
        highlights.NvimTreeFolderName.fg = colors.teal.primary
        highlights.NvimTreeOpenedFolderName.fg = colors.teal.bright or colors.teal.primary
        highlights.NvimTreeRootFolder.fg = colors.blue.primary
        highlights.NvimTreeIndentMarker.fg = colors.teal.dark or colors.fg.subtle
        
    elseif global_config.style == "ki" then
        -- Crystal Light - clean and organized
        highlights.NvimTreeNormal.bg = colors.bg.primary
        highlights.NvimTreeFolderName.fg = colors.blue.primary
        highlights.NvimTreeCursorLine.bg = colors.bg.secondary
        
    elseif global_config.style == "mu" then
        -- WCAG Grayscale - maximum contrast
        highlights.NvimTreeFolderName.bold = true
        highlights.NvimTreeOpenedFolderName.bold = true
        highlights.NvimTreeExecFile.bold = true
        highlights.NvimTreeSpecialFile.bold = true
        highlights.NvimTreeRootFolder.bold = true
        highlights.NvimTreeRootFolder.underline = true
        
    elseif global_config.style == "ku" then
        -- Enhanced Terminal - electric file explorer
        highlights.NvimTreeFolderIcon.fg = colors.blue.bright or colors.blue.primary
        highlights.NvimTreeOpenedFolderName.fg = colors.blue.bright or colors.blue.primary
        highlights.NvimTreeExecFile.fg = colors.green.bright or colors.green.primary
        highlights.NvimTreeRootFolder.fg = colors.orange.bright or colors.orange.primary
    end
    
    -- Alternative highlight names for different versions
    -- NvimTree has changed highlight group names over versions
    local alt_highlights = {
        -- Legacy names
        NvimTreeFolderName = highlights.NvimTreeFolderName,
        NvimTreeOpenedFolderName = highlights.NvimTreeOpenedFolderName,
        NvimTreeEmptyFolderName = highlights.NvimTreeEmptyFolderName,
        NvimTreeFolderIcon = highlights.NvimTreeFolderIcon,
        NvimTreeIndentMarker = highlights.NvimTreeIndentMarker,
        
        -- Modern names (in case they exist)
        ["NvimTreeDirectoryIcon"] = highlights.NvimTreeFolderIcon,
        ["NvimTreeDirectoryName"] = highlights.NvimTreeFolderName,
        ["NvimTreeOpenedDirectoryName"] = highlights.NvimTreeOpenedFolderName,
    }
    
    -- Merge alternative names
    for alt_name, highlight in pairs(alt_highlights) do
        highlights[alt_name] = highlight
    end
    
    return highlights
end

-- NvimTree integration setup
function M.setup()
    local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
    if not nvim_tree_ok then
        return
    end
    
    -- Get current theme colors
    local colors = require("suikimuku.core.colors")
    local config = require("suikimuku.core.config").get_config()
    local theme_colors = colors.get(config.style, 'legacy')
    
    -- Optional: Setup NvimTree with theme-aware configuration
    -- This would require NvimTree to be set up after Suikimuku
    -- Users would need to call this manually or through an autocmd
end

-- Get NvimTree configuration suggestions
function M.get_config_suggestions(theme_style)
    local base_config = {
        view = {
            side = "left",
            width = 30,
        },
        renderer = {
            highlight_git = true,
            highlight_opened_files = "name",
            indent_markers = {
                enable = true,
            },
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
            },
        },
        git = {
            enable = true,
            ignore = false,
        },
        actions = {
            open_file = {
                quit_on_open = false,
            },
        },
    }
    
    -- Theme-specific adjustments
    if theme_style == "ki" then
        -- Crystal Light theme preferences
        base_config.view.side = "left"
        base_config.renderer.indent_markers.enable = true
    elseif theme_style == "ku" then
        -- Enhanced Terminal theme preferences
        base_config.view.width = 35
        base_config.renderer.highlight_opened_files = "all"
    end
    
    return base_config
end

-- Validation
function M.validate()
    local issues = {}
    
    -- Check if NvimTree is available
    local ok, _ = pcall(require, "nvim-tree")
    if not ok then
        table.insert(issues, "NvimTree not found")
    end
    
    return issues
end

return M