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

### 輝 (Ki) - Crystal Radiance
*Maximum brightness with warm golden crystal clarity*

- **Philosophy**: Pure radiant light with warm energy colors for ultimate brightness
- **Palette**: Warm crystal whites with golden undertones, radiant warm spectrum
- **Use Case**: Maximum brightness environments, warm light preference, intense focus
- **Aesthetic**: Crystal radiance with warm golden energy and brilliant luminosity

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

## Complete Color Specifications

### Base32 Color Palette

#### Background Colors (Base 00-03)

| Level | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|-------|----------|---------|---------|---------|
| **Base 00** (Primary) | `#0A1B1A` | `#FAFCFF` | `#000000` | `#000F10` |
| **Base 01** (Secondary) | `#0F2A28` | `#F0F9FF` | `#1A1A1A` | `#072842` |
| **Base 02** (Panel) | `#1A3E3B` | `#E1F5FE` | `#2D2D2D` | `#283d5e` |
| **Base 03** (Highlight) | `#2A5651` | `#CBD5E1` | `#404040` | `#203047` |

#### Foreground Colors (Base 04-07)

| Level | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|-------|----------|---------|---------|---------|
| **Base 04** (Muted) | `#7BBAB1` | `#475569` | `#808080` | `#586E75` |
| **Base 05** (Primary) | `#A7DBD8` | `#64748B` | `#CCCCCC` | `#839496` |
| **Base 06** (Bright) | `#C8E6F5` | `#334155` | `#E6E6E6` | `#93A1A1` |
| **Base 07** (Highlight) | `#F0FEFF` | `#1E293B` | `#FFFFFF` | `#FDF6E3` |

#### Accent Colors (Base 08-0F)

| Color | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|-------|----------|---------|---------|---------|
| **Base 08** (Red) | `#F38630` | `#E11D48` | `#FFFFFF` | `#DC322F` |
| **Base 09** (Orange) | `#FA6900` | `#F97316` | `#E0E0E0` | `#FF8C00` |
| **Base 0A** (Yellow) | `#FEF3C7` | `#FEF3C7` | `#D4D4D4` | `#38e8aa` |
| **Base 0B** (Green) | `#52C489` | `#10B981` | `#B8B8B8` | `#859900` |
| **Base 0C** (Cyan) | `#69D2E7` | `#06B6D4` | `#A0A0A0` | `#00CED1` |
| **Base 0D** (Blue) | `#69D2E7` | `#3B82F6` | `#909090` | `#00D7FF` |
| **Base 0E** (Purple) | `#1e9ee8` | `#8B5CF6` | `#808080` | `#6C71C4` |
| **Base 0F** (Magenta) | `#bce089` | `#EC4899` | `#707070` | `#9D7CD8` |

#### Semantic Colors

**Syntax Highlighting**
| Element | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|---------|----------|---------|---------|---------|
| **Functions** | `#69D2E7` | `#3B82F6` | `#FFFFFF` | `#00D7FF` |
| **Keywords** | `#1e9ee8` | `#8B5CF6` | `#E0E0E0` | `#9D7CD8` |
| **Strings** | `#52C489` | `#10B981` | `#B8B8B8` | `#38e8aa` |
| **Types** | `#A7DBD8` | `#06B6D4` | `#D4D4D4` | `#87CEEB` |
| **Constants** | `#F38630` | `#F97316` | `#A0A0A0` | `#FF8C00` |
| **Comments** | `#7BBAB1` | `#64748B` | `#707070` | `#586E75` |
| **Operators** | `#bce089` | `#475569` | `#909090` | `#00CED1` |

**Diagnostics**
| Level | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|-------|----------|---------|---------|---------|
| **Error** | `#F38630` | `#E11D48` | `#FFFFFF` | `#DC322F` |
| **Warning** | `#FA6900` | `#F97316` | `#E0E0E0` | `#DDD389` |
| **Info** | `#69D2E7` | `#3B82F6` | `#B8B8B8` | `#268BD2` |
| **Hint** | `#52C489` | `#10B981` | `#A0A0A0` | `#859900` |

### Theme-Specific Design Philosophy

#### 翠 (Sui) - Digital Aquarium
- **Philosophy**: Serene underwater workspace combining natural tranquility with digital precision
- **Deep Sea Color Palette**: 
  - **Ocean Depths**: `#0A1B1A`, `#0F2A28`, `#1A3E3B` for calming dark backgrounds
  - **Ocean Blue**: `#1e9ee8` (ocean blue keywords) for syntax highlighting like illuminated water
  - **Aqua Mint**: `#69d2e7` (functions), `#a7dbd8` (types) for crystal-clear water clarity
  - **Emerald Coral**: `#52c489` (strings) for organic sea vegetation
  - **Warm Coral**: `#f38630` (constants) for vibrant underwater life
  - **Light Sea Green**: `#bce089` (special) for gentle sea grass and floating vegetation
- **Use Case**: Calm, immersive coding sessions with natural depth and modern digital clarity
- **Aesthetic**: Deep sea coding environment where syntax glows like bioluminescent marine life
- **Digital Harmony**: Ocean blue keywords (`#1e9ee8`) provide natural water contrast against organic aqua foundation

#### 輝 (Ki) - Crystal Radiant Light
- **Philosophy**: Pure radiant light concept - cool, crisp, luminous like crystal clarity
- **Primary Hues**: Cool whites and light blues from ocean-breeze + crystal-waves palettes
- **Color References**: `#FAFCFF` (barely blue white), `#F0F9FF` (almost white blue), `#E1F5FE` (very light blue)
- **Reduced Warmth**: Replaced Renaissance earth tones with cool grays `#64748B`, `#475569`, `#334155`
- **Use Case**: Clean, crisp light mode for focused work and bright environments
- **Aesthetic**: Morning light through crystal, minimal warmth, maximum clarity
- **Soft Yellow**: Gentle `#FEF3C7` instead of harsh bright yellows

#### 無 (Mu) - WCAG AAA High-Contrast Grayscale
- **Philosophy**: Maximum readability with zero color distractions
- **Contrast Ratios**: WCAG AAA compliant (7:1+ for normal text, 21:1 for highlights)
- **Color Hierarchy**: Pure black `#000000` → Pure white `#FFFFFF` with 8 distinct levels
- **Use Case**: Deep focus sessions, accessibility needs, distraction-free coding
- **Aesthetic**: High-contrast monochrome, newspaper clarity, maximum legibility
- **Benefits**: Works with all colorblind conditions, reduces cognitive load from color processing

#### 空 (Ku) - Enhanced Vibrant Terminal
- **Philosophy**: Modern high-contrast terminal experience with electric vibrancy
- **Electric Palette**: Deep space backgrounds with neon-bright syntax highlighting
- **Vibrant Syntax Colors**: 
  - **Electric cyan**: `#00D7FF` for functions and imports
  - **Vibrant purple**: `#9D7CD8` for keywords and control flow
  - **Turquoise green**: `#38e8aa` for strings and literals
  - **Sky blue**: `#87CEEB` for types and declarations
  - **Dark turquoise**: `#00CED1` for operators and special characters
- **Background Evolution**: Enhanced blue tones (`#072842`, `#283d5e`) for better depth
- **Use Case**: Modern terminal workflows, high-contrast coding, enhanced syntax readability
- **Aesthetic**: Deep ocean depths with electric neon highlights, cyberpunk-inspired coding environment
- **Terminal Integration**: Maintains terminal harmony while enhancing visual distinction

### Advanced Usage

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
3. **Professional Polish**: Clean implementation focused on code readability
4. **Terminal First**: Optimized for terminal Neovim with GUI compatibility
5. **Japanese Aesthetics**: Color relationships inspired by traditional Japanese design

## Testing Themes

Use the included test script to preview all themes:

```lua
-- In Neovim command line
:luafile test-themes.lua
```

This will cycle through all four themes with a 2-second delay between each, demonstrating the visual differences.

## Theme Philosophy

### East Asian Aesthetic Principles

Drawing from Japanese, Taiwanese, and broader East Asian design philosophy:

- **翠 (Sui)**: Emerald tranquility - from Japanese jade concepts (翠 - midori/sui) and Taiwanese mountain forest aesthetics (翠綠), representing natural harmony, growth, and the feng shui wood element of vitality
- **輝 (Ki)**: Radiant illumination - combining Japanese kagayaki (輝 - radiance) with Taiwanese sunrise clarity (光輝), symbolizing enlightenment, brilliance, and yang energy in yin-yang philosophy
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