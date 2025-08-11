-- GitSigns Plugin Support for Suikimuku.nvim
-- Git integration and status highlighting

local M = {}

-- Plugin metadata
M.name = "gitsigns.nvim"
M.description = "Git integration with line status indicators"
M.url = "https://github.com/lewis6991/gitsigns.nvim"

-- Generate highlights for GitSigns
function M.highlights(colors, plugin_config, global_config)
    local highlights = {}
    local line_highlights = plugin_config.line_highlights or false
    
    -- Git signs in the sign column
    highlights.GitSignsAdd = { fg = colors.green.primary }
    highlights.GitSignsChange = { fg = colors.blue.primary }
    highlights.GitSignsDelete = { fg = colors.red.primary }
    highlights.GitSignsTopdelete = { fg = colors.red.primary }
    highlights.GitSignsChangedelete = { fg = colors.orange.primary }
    highlights.GitSignsUntracked = { fg = colors.purple.primary }
    
    -- Number line highlights (when enabled)
    if line_highlights then
        highlights.GitSignsAddLn = { bg = colors.green.dark or colors.bg.highlight }
        highlights.GitSignsChangeLn = { bg = colors.blue.dark or colors.bg.highlight }
        highlights.GitSignsDeleteLn = { bg = colors.red.dark or colors.bg.highlight }
        highlights.GitSignsAddNr = { fg = colors.green.primary, bg = colors.bg.secondary }
        highlights.GitSignsChangeNr = { fg = colors.blue.primary, bg = colors.bg.secondary }
        highlights.GitSignsDeleteNr = { fg = colors.red.primary, bg = colors.bg.secondary }
    end
    
    -- Inline blame text
    highlights.GitSignsCurrentLineBlame = { 
        fg = colors.fg.subtle, 
        italic = true 
    }
    
    -- Word diff highlighting
    highlights.GitSignsAddInline = { 
        fg = colors.bg.primary, 
        bg = colors.green.primary 
    }
    highlights.GitSignsChangeInline = { 
        fg = colors.bg.primary, 
        bg = colors.blue.primary 
    }
    highlights.GitSignsDeleteInline = { 
        fg = colors.bg.primary, 
        bg = colors.red.primary 
    }
    
    -- Staged changes
    highlights.GitSignsStagedAdd = { fg = colors.green.bright or colors.green.primary }
    highlights.GitSignsStagedChange = { fg = colors.blue.bright or colors.blue.primary }
    highlights.GitSignsStagedDelete = { fg = colors.red.bright or colors.red.primary }
    highlights.GitSignsStagedChangedelete = { fg = colors.orange.bright or colors.orange.primary }
    highlights.GitSignsStagedTopdelete = { fg = colors.red.bright or colors.red.primary }
    
    -- Preview window (for hunk previews)
    highlights.GitSignsAddPreview = { fg = colors.green.primary, bg = colors.bg.float }
    highlights.GitSignsDeletePreview = { fg = colors.red.primary, bg = colors.bg.float }
    
    -- Theme-specific customizations
    if global_config.style == "sui" then
        -- Digital Aquarium - oceanic git flow
        highlights.GitSignsAdd.fg = colors.teal.primary
        highlights.GitSignsChange.fg = colors.blue.primary
        highlights.GitSignsCurrentLineBlame.fg = colors.teal.dark or colors.fg.subtle
        
    elseif global_config.style == "ki" then
        -- Crystal Light - clean git indicators
        highlights.GitSignsCurrentLineBlame.fg = colors.fg.muted
        if line_highlights then
            highlights.GitSignsAddLn.bg = colors.green.light or colors.bg.highlight
            highlights.GitSignsChangeLn.bg = colors.blue.light or colors.bg.highlight
            highlights.GitSignsDeleteLn.bg = colors.red.light or colors.bg.highlight
        end
        
    elseif global_config.style == "mu" then
        -- WCAG Grayscale - high contrast git status
        highlights.GitSignsAdd.bold = true
        highlights.GitSignsChange.bold = true
        highlights.GitSignsDelete.bold = true
        highlights.GitSignsCurrentLineBlame.bold = true
        highlights.GitSignsCurrentLineBlame.italic = false
        
    elseif global_config.style == "ku" then
        -- Enhanced Terminal - electric git indicators
        highlights.GitSignsAdd.fg = colors.green.bright or colors.green.primary
        highlights.GitSignsChange.fg = colors.blue.bright or colors.blue.primary
        highlights.GitSignsDelete.fg = colors.red.bright or colors.red.primary
        highlights.GitSignsUntracked.fg = colors.purple.bright or colors.purple.primary
        highlights.GitSignsCurrentLineBlame.fg = colors.fg.secondary
    end
    
    -- Additional highlight aliases for compatibility
    local alias_highlights = {
        -- Alternative names used in some GitSigns configurations
        GitGutterAdd = highlights.GitSignsAdd,
        GitGutterChange = highlights.GitSignsChange,
        GitGutterDelete = highlights.GitSignsDelete,
        GitGutterChangeDelete = highlights.GitSignsChangedelete,
        
        -- Diff mode highlights
        DiffAdd = { bg = colors.green.dark or colors.bg.highlight, fg = colors.fg.primary },
        DiffChange = { bg = colors.blue.dark or colors.bg.highlight, fg = colors.fg.primary },
        DiffDelete = { bg = colors.red.dark or colors.bg.highlight, fg = colors.fg.primary },
        DiffText = { bg = colors.orange.dark or colors.bg.secondary, fg = colors.fg.primary, bold = true },
    }
    
    -- Merge alias highlights
    for alias_name, highlight in pairs(alias_highlights) do
        highlights[alias_name] = highlight
    end
    
    return highlights
end

-- GitSigns integration utilities
function M.get_config_suggestions(theme_style)
    local config = {
        signs = {
            add = { text = '│' },
            change = { text = '│' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
            follow_files = true
        },
        attach_to_untracked = false,
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol',
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
    }
    
    -- Theme-specific adjustments
    if theme_style == "sui" then
        -- Digital Aquarium - flowing git indicators
        config.signs.add.text = '▎'
        config.signs.change.text = '▎'
        config.signs.delete.text = '▁'
        config.signs.topdelete.text = '▔'
        config.signs.changedelete.text = '▎'
        config.signs.untracked.text = '▎'
        
    elseif theme_style == "ki" then
        -- Crystal Light - clean indicators
        config.signs.add.text = '+'
        config.signs.change.text = '~'
        config.signs.delete.text = '-'
        config.signs.topdelete.text = '-'
        config.signs.changedelete.text = '~'
        config.signs.untracked.text = '?'
        
    elseif theme_style == "mu" then
        -- WCAG Grayscale - high contrast indicators
        config.signs.add.text = '■'
        config.signs.change.text = '■'
        config.signs.delete.text = '■'
        config.signs.topdelete.text = '■'
        config.signs.changedelete.text = '■'
        config.signs.untracked.text = '■'
        config.numhl = true -- Enable number highlighting for better visibility
        
    elseif theme_style == "ku" then
        -- Enhanced Terminal - electric indicators
        config.signs.add.text = '┃'
        config.signs.change.text = '┃'
        config.signs.delete.text = '▁'
        config.signs.topdelete.text = '▔'
        config.signs.changedelete.text = '┃'
        config.signs.untracked.text = '┋'
    end
    
    return config
end

-- Setup GitSigns integration
function M.setup()
    local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
    if not gitsigns_ok then
        return
    end
    
    -- Get current theme configuration
    local config = require("suikimuku.core.config").get_config()
    
    -- Only setup if GitSigns integration is enabled
    if config.plugins.gitsigns and config.plugins.gitsigns.enabled then
        local gitsigns_config = M.get_config_suggestions(config.style)
        
        -- Merge with user's existing GitSigns config if any
        if config.plugins.gitsigns.config then
            gitsigns_config = vim.tbl_deep_extend("force", gitsigns_config, config.plugins.gitsigns.config)
        end
        
        -- Apply line highlighting if enabled
        if config.plugins.gitsigns.line_highlights then
            gitsigns_config.linehl = true
            gitsigns_config.numhl = true
        end
        
        gitsigns.setup(gitsigns_config)
    end
end

-- Get GitSigns theme configuration for external use
function M.get_theme_config()
    local colors = require("suikimuku.core.colors")
    local config = require("suikimuku.core.config").get_config()
    local theme_colors = colors.get(config.style, 'legacy')
    
    return {
        add = theme_colors.green.primary,
        change = theme_colors.blue.primary,
        delete = theme_colors.red.primary,
        topdelete = theme_colors.red.primary,
        changedelete = theme_colors.orange.primary,
        untracked = theme_colors.purple.primary,
        current_line_blame = theme_colors.fg.subtle,
    }
end

-- Refresh GitSigns signs with current theme
function M.refresh_signs()
    local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
    if not gitsigns_ok then
        return
    end
    
    -- Force refresh of all GitSigns highlights
    if gitsigns.refresh then
        gitsigns.refresh()
    end
end

-- Validation
function M.validate()
    local issues = {}
    
    -- Check if GitSigns is available
    local ok, _ = pcall(require, "gitsigns")
    if not ok then
        table.insert(issues, "GitSigns not found")
    end
    
    return issues
end

return M