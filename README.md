<h1 align="center">Suikimuku.nvim</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.8%2B-57A143?style=flat-square&logo=neovim&logoColor=white" alt="Neovim" />
  <img src="https://img.shields.io/badge/Lua-5.1%2B-2C2D72?style=flat-square&logo=lua&logoColor=white" alt="Lua" />
  <img src="https://img.shields.io/badge/Version-v3.0-blueviolet?style=flat-square" alt="Version v3.0" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square" alt="MIT License" />
</p>

<p align="center">
A clean, focused four-theme colorscheme (翠輝無空) for Neovim inspired by East Asian aesthetic philosophy, drawing from Japanese, Taiwanese, and regional design traditions. Direct hex architecture with professional color precision for modern coding environments.
</p>

## The Four Themes

### 翠 (Sui) - Garden Sage
*Light green coding environment with natural harmony*

- **Philosophy**: Natural tranquility with forest green harmony in bright daylight
- **Palette**: Light sage backgrounds, forest green text, natural teal and purple accents
- **Use Case**: Bright environments, natural daylight coding, gentle on eyes
- **Aesthetic**: Fresh garden workspace with organic sage and forest color harmony

### 輝 (Ki) - Arctic Sunset Radiance
*Maximum brightness with ethereal arctic sunset gradients*

- **Philosophy**: Pure radiant illumination with aurora-inspired purple-pink-blue spectrum
- **Palette**: Cool arctic whites with lavender tints, sunset gradient colors
- **Use Case**: Maximum brightness environments, ethereal aesthetics, mystical focus
- **Aesthetic**: Arctic sunset radiance with aurora gradients and celestial luminosity

### 無 (Mu) - WCAG AAA Grayscale
*High-contrast monochrome for distraction-free coding*

- **Philosophy**: Maximum readability with zero color distractions
- **Palette**: Pure monochrome with 21:1 contrast ratios
- **Use Case**: Deep focus sessions, accessibility needs, colorblind-friendly
- **Aesthetic**: High-contrast newspaper clarity, maximum legibility

### 空 (Ku) - Infinite Sky
*Deep cosmic blue representing boundless space and terminal harmony*

- **Philosophy**: Infinite sky and cosmic depth with serene blue tranquility
- **Palette**: Deep sky backgrounds, celestial blue spectrum, cosmic accents  
- **Use Case**: Night coding, cosmic contemplation, terminal harmony
- **Aesthetic**: Boundless night sky with cosmic depth and celestial serenity

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'chxmeleon/suikimuku.nvim',
  name = 'suikimuku',
  lazy = false,
  priority = 1000,
  config = function()
    require('suikimuku').setup({
      style = 'ku',          -- 'sui', 'ki', 'mu', 'ku'
      transparent = nil,     -- Let theme decide (recommended)
      opacity = 0.64,        -- Background opacity (0.0-1.0)
    })
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'chxmeleon/suikimuku.nvim',
  config = function()
    require('suikimuku').setup({ style = 'ku' })
  end
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'chxmeleon/suikimuku.nvim'

" In your init.vim
lua << EOF
require('suikimuku').setup({ style = 'ku' })
EOF
```

## Usage

### Basic Setup

```lua
-- Apply a theme
require('suikimuku').setup({
  style = 'ku'  -- Options: 'sui', 'ki', 'mu', 'ku'
})
```

### Configuration Options

```lua
require('suikimuku').setup({
  style = 'ku',           -- Theme variant: 'sui', 'ki', 'mu', 'ku'
  transparent = nil,      -- Let theme decide transparency (recommended)
  opacity = 0.64,         -- Background opacity when transparent (0.0-1.0)
})
```

### Dynamic Theme Switching

```lua
-- Switch themes on the fly
require('suikimuku').load('sui')   -- Garden sage
require('suikimuku').load('ki')    -- Crystal radiance  
require('suikimuku').load('mu')    -- WCAG grayscale
require('suikimuku').load('ku')    -- Infinite sky

-- Or use the command
:SuikimukyLoad sui
```

### Theme Commands

```vim
" Load specific themes
:SuikimukyLoad sui     " Garden sage
:SuikimukyLoad ki      " Crystal radiance
:SuikimukyLoad mu      " WCAG grayscale
:SuikimukyLoad ku      " Infinite sky
```

## Features

- **Four Distinct Themes**: Each with unique philosophy and professional color precision
- **Direct Hex Architecture**: Clean, focused implementation with exact color control
- **Dynamic Switching**: Change themes instantly with `:SuikimukyLoad` command
- **Theme-Smart Transparency**: Each theme has optimized transparency settings
- **Modern Syntax Highlighting**: Professional colors for enhanced code readability  
- **TreeSitter Support**: Full TreeSitter and LSP integration
- **Terminal Optimized**: Works beautifully in both GUI and terminal Neovim
- **East Asian Aesthetic**: Inspired by Japanese, Taiwanese, and regional design philosophy

## Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `style` | string | `'ku'` | Theme variant: `'sui'`, `'ki'`, `'mu'`, `'ku'` |
| `transparent` | boolean/nil | `nil` | Let theme decide transparency (recommended) |
| `opacity` | number | `0.64` | Background opacity (0.0-1.0) when transparent |

## Advanced Usage

```lua
-- Get current theme colors for external integrations
local colors = require('suikimuku').get_colors()
print(colors.bg_primary)  -- Current background color

-- Theme-specific setups
if vim.o.background == 'light' then
  require('suikimuku').setup({ style = 'sui' })  -- Garden sage for light mode
else
  require('suikimuku').setup({ style = 'ku' })   -- Infinite sky for dark mode
end
```

### Implementation Notes

1. **Direct Hex Colors**: Each theme uses carefully chosen hex values for precision
2. **Theme Philosophy**: Each theme has its own transparency and aesthetic approach  
3. **East Asian Design**: Color relationships inspired by traditional regional aesthetics
4. **Terminal Optimized**: Works beautifully in both GUI and terminal environments

## Theme Philosophy

### East Asian Aesthetic Principles

Drawing from Japanese, Taiwanese, and broader East Asian design philosophy:

- **翠 (Sui)**: Emerald tranquility - from Japanese jade concepts (翠 - midori/sui) and Taiwanese mountain forest aesthetics (翠綠), representing natural harmony, growth, and the feng shui wood element of vitality
- **輝 (Ki)**: Radiant illumination - combining Japanese kagayaki (輝 - radiance) with Taiwanese arctic sunset mystique (光輝), symbolizing ethereal enlightenment, aurora brilliance, and celestial yang energy in yin-yang philosophy
- **無 (Mu)**: Profound emptiness - rooted in Zen Buddhism (無 - mu) and Taiwanese minimalist aesthetics (無色), embracing wabi-sabi simplicity, focused potential, and Taoist wu wei (effortless action)
- **空 (Ku)**: Boundless sky - merging Japanese cosmic void (空 - kuu/sora) with Taiwanese Pacific vistas (天空), representing infinite possibility, celestial harmony, and connection to heaven

Each theme embodies these cross-cultural East Asian concepts through carefully chosen colors that honor both traditional aesthetics and contemporary coding environments, creating a bridge between ancient wisdom and modern digital craftsmanship.

## API

### Available Functions

```lua
-- Main setup function
require('suikimuku').setup({ style = 'ku' })

-- Load theme directly
require('suikimuku').load('sui')

-- Get current theme colors
local colors = require('suikimuku').get_colors()
```

## Development

### Project Structure
```
suikimuku.nvim/
├── lua/suikimuku/
│   ├── init.lua         # Main plugin logic and setup
│   └── themes/          # Individual theme modules
│       ├── sui.lua      # Garden sage theme
│       ├── ki.lua       # Crystal radiance theme  
│       ├── mu.lua       # WCAG grayscale theme
│       └── ku.lua       # Infinite sky theme
└── README.md           # Documentation
```

### Contributing
1. Fork the repository
2. Create a feature branch  
3. Test your changes with all four themes
4. Ensure themes maintain their philosophical consistency
5. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by East Asian aesthetic philosophy, drawing from Japanese, Taiwanese, and broader regional design principles
- Built with direct hex precision for professional color accuracy
- Designed for modern terminal workflows and high-resolution displays  
- Each theme represents a different aspect of nature and consciousness across East Asian cultures
- Honors traditional concepts: Japanese wabi-sabi, Taiwanese mountain aesthetics, feng shui elements, and Taoist philosophy

---

<p align="center">
  <em>翠輝無空 (SuiKiMuKu) - Four themes, one philosophy</em><br>
  <em>Where East Asian aesthetics meet modern coding precision</em>
</p>