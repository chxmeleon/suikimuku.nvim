# Plugin Support Architecture

*Comprehensive guide to third-party plugin integration in Suikimuku.nvim*

## Overview

This document outlines the technical architecture and implementation strategy for supporting third-party Neovim plugins in Suikimuku.nvim. Our goal is to provide seamless, beautiful theming for the entire Neovim ecosystem while maintaining our unique four-theme aesthetic.

## Architecture Design

### Modular Plugin System

The plugin support system is built on a modular architecture where each plugin has its own dedicated module:

```
lua/suikimuku/plugins/
├── init.lua           # Plugin loader and coordination
├── telescope.lua      # Fuzzy finder integration
├── nvim-tree.lua      # File explorer (nvim-tree)
├── neo-tree.lua       # File explorer (neo-tree)
├── lualine.lua        # Status line
├── gitsigns.lua       # Git integration
├── cmp.lua            # Completion framework
├── whichkey.lua       # Key mapping helper
├── treesitter.lua     # Enhanced syntax highlighting
├── lsp.lua            # Language server integration
├── dap.lua            # Debug adapter integration
├── toggleterm.lua     # Terminal integration
└── ... (additional plugins)
```

### Plugin Module Pattern

Each plugin module follows a consistent pattern:

```lua
-- lua/suikimuku/plugins/example.lua
return function(colors, config)
  local highlights = {}
  
  -- Plugin-specific highlight groups
  highlights.ExampleNormal = { 
    fg = colors.fg.primary, 
    bg = colors.bg.primary 
  }
  
  highlights.ExampleBorder = { 
    fg = colors.bg.highlight,
    bg = config.transparent and 'NONE' or colors.bg.float
  }
  
  highlights.ExampleTitle = { 
    fg = colors.syntax.func, 
    bold = true 
  }
  
  -- Theme-specific customizations
  if config.style == 'sui' then
    highlights.ExampleSelection = { bg = colors.bg.highlight }
  elseif config.style == 'ku' then
    highlights.ExampleSelection = { 
      bg = colors.bg.highlight, 
      fg = colors.syntax.func 
    }
  end
  
  return highlights
end
```

## Supported Plugins

### Current Support Status

#### ✅ Tier 1: Core Integrations (Phase 1)
Essential plugins with full theming support:

- **Telescope** - Fuzzy finder with comprehensive theming
- **nvim-tree** - File explorer with consistent styling
- **neo-tree** - Alternative file explorer
- **Lualine** - Status line with theme-aware colors
- **GitSigns** - Git integration markers
- **nvim-cmp** - Completion menu styling
- **Which-key** - Key mapping popups
- **TreeSitter** - Enhanced syntax highlighting

#### 🔄 Tier 2: Extended Integrations (Phase 2)
Additional ecosystem plugins:

- **nvim-dap** - Debug adapter protocol
- **toggleterm** - Terminal integration
- **hop.nvim** - Motion navigation
- **indent-blankline** - Indentation guides
- **nvim-notify** - Notification system
- **trouble.nvim** - Diagnostics viewer
- **bufferline** - Buffer tabs
- **dashboard** - Start screen

#### 📋 Tier 3: Specialized Plugins (Phase 3)
Specialized and less common plugins:

- **neogit** - Git interface
- **diffview** - Git diff viewer
- **oil.nvim** - File manager
- **aerial** - Symbol outline
- **navic** - Breadcrumbs
- **fidget** - LSP progress indicator

### Plugin Implementation Examples

#### Telescope Integration
```lua
-- lua/suikimuku/plugins/telescope.lua
return function(colors, config)
  local util = require('suikimuku.util')
  
  return {
    -- Main components
    TelescopeNormal = { 
      fg = colors.fg.primary, 
      bg = config.transparent and 'NONE' or colors.bg.float 
    },
    TelescopeBorder = { 
      fg = colors.bg.highlight, 
      bg = config.transparent and 'NONE' or colors.bg.float 
    },
    
    -- Prompt styling  
    TelescopePromptNormal = { 
      fg = colors.fg.primary, 
      bg = colors.bg.secondary 
    },
    TelescopePromptBorder = { 
      fg = colors.bg.secondary, 
      bg = colors.bg.secondary 
    },
    TelescopePromptTitle = { 
      fg = colors.bg.primary, 
      bg = colors.syntax.func 
    },
    
    -- Results styling
    TelescopeResultsNormal = { 
      fg = colors.fg.secondary, 
      bg = config.transparent and 'NONE' or colors.bg.float 
    },
    TelescopeResultsBorder = { 
      fg = colors.bg.highlight, 
      bg = config.transparent and 'NONE' or colors.bg.float 
    },
    TelescopeResultsTitle = { 
      fg = colors.fg.muted, 
      bg = colors.bg.float 
    },
    
    -- Preview styling
    TelescopePreviewNormal = { 
      fg = colors.fg.primary, 
      bg = colors.bg.primary 
    },
    TelescopePreviewBorder = { 
      fg = colors.bg.highlight, 
      bg = colors.bg.primary 
    },
    TelescopePreviewTitle = { 
      fg = colors.bg.primary, 
      bg = colors.syntax.string 
    },
    
    -- Selection and matching
    TelescopeSelection = { 
      fg = colors.fg.primary, 
      bg = colors.bg.highlight 
    },
    TelescopeSelectionCaret = { 
      fg = colors.syntax.func 
    },
    TelescopeMultiSelection = { 
      fg = colors.diag.warn 
    },
    TelescopeMatching = { 
      fg = colors.syntax.func, 
      bold = true 
    },
    
    -- Theme-specific enhancements
    TelescopePromptPrefix = {
      fg = config.style == 'sui' and colors.syntax.keyword or colors.syntax.func
    },
  }
end
```

#### Lualine Integration
```lua
-- lua/suikimuku/plugins/lualine.lua
return function(colors, config)
  local theme = {}
  
  -- Normal mode
  theme.normal = {
    a = { fg = colors.bg.primary, bg = colors.syntax.func, gui = 'bold' },
    b = { fg = colors.fg.primary, bg = colors.bg.highlight },
    c = { fg = colors.fg.secondary, bg = colors.bg.secondary },
  }
  
  -- Insert mode  
  theme.insert = {
    a = { fg = colors.bg.primary, bg = colors.syntax.string, gui = 'bold' },
    b = { fg = colors.fg.primary, bg = colors.bg.highlight },
  }
  
  -- Visual mode
  theme.visual = {
    a = { fg = colors.bg.primary, bg = colors.syntax.const, gui = 'bold' },
    b = { fg = colors.fg.primary, bg = colors.bg.highlight },
  }
  
  -- Replace mode
  theme.replace = {
    a = { fg = colors.bg.primary, bg = colors.diag.error, gui = 'bold' },
    b = { fg = colors.fg.primary, bg = colors.bg.highlight },
  }
  
  -- Command mode
  theme.command = {
    a = { fg = colors.bg.primary, bg = colors.syntax.keyword, gui = 'bold' },
    b = { fg = colors.fg.primary, bg = colors.bg.highlight },
  }
  
  -- Inactive
  theme.inactive = {
    a = { fg = colors.fg.subtle, bg = colors.bg.secondary },
    b = { fg = colors.fg.subtle, bg = colors.bg.secondary },
    c = { fg = colors.fg.subtle, bg = colors.bg.primary },
  }
  
  return theme
end
```

#### nvim-cmp Integration  
```lua
-- lua/suikimuku/plugins/cmp.lua
return function(colors, config)
  local util = require('suikimuku.util')
  
  return {
    -- Completion menu
    CmpNormal = { 
      fg = colors.fg.primary, 
      bg = colors.bg.float 
    },
    CmpBorder = { 
      fg = colors.bg.highlight, 
      bg = colors.bg.float 
    },
    CmpScrollbar = { 
      bg = colors.bg.highlight 
    },
    CmpThumb = { 
      bg = colors.fg.subtle 
    },
    
    -- Menu items
    CmpItemAbbr = { 
      fg = colors.fg.primary 
    },
    CmpItemAbbrDeprecated = { 
      fg = colors.fg.subtle, 
      strikethrough = true 
    },
    CmpItemAbbrMatch = { 
      fg = colors.syntax.func, 
      bold = true 
    },
    CmpItemAbbrMatchFuzzy = { 
      fg = colors.syntax.func, 
      bold = true 
    },
    
    -- Kind icons
    CmpItemKindText = { 
      fg = colors.fg.primary 
    },
    CmpItemKindMethod = { 
      fg = colors.syntax.func 
    },
    CmpItemKindFunction = { 
      fg = colors.syntax.func 
    },
    CmpItemKindConstructor = { 
      fg = colors.syntax.const 
    },
    CmpItemKindVariable = { 
      fg = colors.fg.muted 
    },
    CmpItemKindClass = { 
      fg = colors.syntax.type 
    },
    CmpItemKindInterface = { 
      fg = colors.syntax.type 
    },
    CmpItemKindModule = { 
      fg = colors.syntax.keyword 
    },
    CmpItemKindKeyword = { 
      fg = colors.syntax.keyword 
    },
    CmpItemKindSnippet = { 
      fg = colors.syntax.string 
    },
    CmpItemKindFile = { 
      fg = colors.fg.secondary 
    },
    CmpItemKindFolder = { 
      fg = colors.syntax.type 
    },
  }
end
```

## Configuration System

### Plugin-Specific Configuration

Users can configure plugin-specific theming:

```lua
require('suikimuku').setup({
  style = 'sui',
  
  plugins = {
    -- Enable/disable specific plugins
    telescope = true,
    nvim_tree = true,
    lualine = false,  -- Disable lualine integration
    
    -- Plugin-specific options
    telescope = {
      style = 'borderless',  -- 'bordered', 'borderless' 
      transparency = 0.8,    -- Override global transparency
    },
    
    nvim_tree = {
      darker = true,         -- Use darker background
      show_git_status = true, -- Enhanced git theming
    },
    
    cmp = {
      kind_icons = true,     -- Color kind icons
      ghost_text = true,     -- Style ghost text
    },
  },
})
```

### Dynamic Plugin Detection

The plugin system automatically detects installed plugins:

```lua
-- lua/suikimuku/plugins/init.lua
local M = {}

local function is_plugin_loaded(plugin_name)
  return pcall(require, plugin_name)
end

local function get_plugin_highlights(colors, config)
  local highlights = {}
  
  -- Only load highlights for installed plugins
  local plugins = {
    { name = 'telescope', module = 'telescope' },
    { name = 'nvim-tree', module = 'nvim-tree' },
    { name = 'neo-tree', module = 'neo-tree' },
    { name = 'lualine', module = 'lualine' },
    -- ... more plugins
  }
  
  for _, plugin in ipairs(plugins) do
    if config.plugins[plugin.name] ~= false and is_plugin_loaded(plugin.module) then
      local ok, plugin_highlights = pcall(require, 'suikimuku.plugins.' .. plugin.name)
      if ok then
        local plugin_hl = plugin_highlights(colors, config)
        highlights = vim.tbl_deep_extend('force', highlights, plugin_hl)
      end
    end
  end
  
  return highlights
end

return M
```

## Theme-Specific Adaptations

### Sui (Digital Aquarium) Adaptations
- **Ocean depths**: Darker, more atmospheric backgrounds for panels
- **Bioluminescent highlights**: Glowing selection and accent colors
- **Aquatic flow**: Smooth color transitions between elements

```lua
if config.style == 'sui' then
  -- More atmospheric floating panels
  highlights.TelescopeNormal = { 
    fg = colors.fg.primary, 
    bg = util.darken(colors.bg.float, 0.1) 
  }
  
  -- Glowing selections
  highlights.TelescopeSelection = { 
    bg = colors.bg.highlight, 
    fg = colors.syntax.func 
  }
end
```

### Ki (Crystal Radiant Light) Adaptations
- **Crystal clarity**: High contrast, clean lines
- **Minimal warmth**: Cool color temperature throughout
- **Radiant highlights**: Bright, clear accent colors

### Mu (WCAG AAA Grayscale) Adaptations  
- **Maximum contrast**: Ensure all plugin elements meet WCAG AAA standards
- **Monochrome consistency**: No color distractions in any plugin
- **Accessibility focus**: Optimal readability in all scenarios

### Ku (Enhanced Vibrant Terminal) Adaptations
- **Electric vibrancy**: High saturation, neon-like colors
- **Terminal harmony**: Colors that work well with terminal backgrounds
- **Cyberpunk aesthetic**: Bold, futuristic color combinations

## Custom Plugin Development

### Adding New Plugin Support

To add support for a new plugin:

1. **Create Plugin Module**:
   ```lua
   -- lua/suikimuku/plugins/your_plugin.lua
   return function(colors, config)
     local highlights = {}
     
     -- Define plugin-specific highlights
     highlights.YourPluginNormal = { fg = colors.fg.primary }
     -- ... more highlights
     
     return highlights
   end
   ```

2. **Register Plugin**:
   Add to the plugin list in `lua/suikimuku/plugins/init.lua`

3. **Add Configuration Options**:
   Include plugin options in the default configuration

4. **Test Across Themes**:
   Ensure the plugin works well with all four themes

### Plugin Development Guidelines

- **Consistency**: Use semantic color names (`colors.fg.primary` not hex codes)
- **Theme Awareness**: Adapt colors based on the active theme
- **Transparency Support**: Respect global and plugin-specific transparency settings
- **Performance**: Lazy load plugin highlights when possible
- **Documentation**: Include usage examples and configuration options

## Testing & Quality Assurance

### Automated Testing
```lua
-- Test that all plugins generate valid highlight groups
local function test_plugin_highlights()
  for _, theme in ipairs({ 'sui', 'ki', 'mu', 'ku' }) do
    local colors = require('suikimuku').get_colors(theme)
    local config = { style = theme, plugins = {} }
    
    for _, plugin in ipairs(supported_plugins) do
      local highlights = require('suikimuku.plugins.' .. plugin)(colors, config)
      assert(type(highlights) == 'table', 'Plugin must return highlight table')
      
      -- Validate highlight group format
      for group, props in pairs(highlights) do
        assert(type(group) == 'string', 'Highlight group must be string')
        assert(type(props) == 'table', 'Properties must be table')
      end
    end
  end
end
```

### Manual Testing Checklist
- [ ] All themes work with each supported plugin
- [ ] Transparency settings are respected
- [ ] Custom configuration options work correctly
- [ ] No highlight group conflicts
- [ ] Performance is acceptable (<100ms total load time)
- [ ] Colors maintain readability and aesthetic consistency

## Performance Considerations

### Lazy Loading Strategy
```lua
-- Load plugin highlights only when needed
local plugin_cache = {}

local function get_plugin_highlights_lazy(plugin_name, colors, config)
  if not plugin_cache[plugin_name] then
    local ok, plugin_module = pcall(require, 'suikimuku.plugins.' .. plugin_name)
    if ok then
      plugin_cache[plugin_name] = plugin_module(colors, config)
    else
      plugin_cache[plugin_name] = {}
    end
  end
  
  return plugin_cache[plugin_name]
end
```

### Memory Optimization
- Cache compiled highlight tables
- Reuse color calculations
- Minimize string allocations
- Use weak references for unused plugins

## Future Enhancements

### Plugin API
Public API for third-party plugin developers:

```lua
-- Allow external plugins to register their own theming
require('suikimuku').register_plugin('my_plugin', function(colors, config)
  return {
    MyPluginNormal = { fg = colors.fg.primary },
    -- ... plugin highlights
  }
end)
```

### Theme Export
Generate plugin themes for other colorschemes:

```lua
-- Export Suikimuku themes for other editors/tools
require('suikimuku').export({
  format = 'vscode',  -- 'vscode', 'sublime', 'idea', etc.
  theme = 'sui',
  output = 'sui-theme.json'
})
```

This plugin support architecture ensures Suikimuku.nvim provides comprehensive, beautiful theming for the entire Neovim ecosystem while maintaining our unique aesthetic vision across all four themes.