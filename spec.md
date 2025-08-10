# SuiKimuku.nvim - Complete Color Theme Specification

A comprehensive four-theme system for Neovim with Japanese aesthetic philosophy and modern transparency support.

## Philosophy

- **翠 (Sui)** - Emerald/Jade: Organic, natural green tones for harmonious coding
- **輝 (Ki)** - Radiant: Light mode with high contrast for bright environments  
- **無 (Mu)** - Void: Pure grayscale for distraction-free focus sessions
- **空 (Ku)** - Sky: Balanced dark mode for comfortable long coding sessions

## Base32 Color Palette

### 🌑 Background Colors (Base 00-03)

| Level | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|-------|----------|---------|---------|---------|
| **Base 00** (Primary) | `#0A1B1A` | `#FAFCFF` | `#000000` | `#000F10` |
| **Base 01** (Secondary) | `#0F2A28` | `#F0F9FF` | `#1A1A1A` | `#073642` |
| **Base 02** (Panel) | `#1A3E3B` | `#E1F5FE` | `#2D2D2D` | `#114555` |
| **Base 03** (Highlight) | `#2A5651` | `#CBD5E1` | `#404040` | `#203047` |

### 🌕 Foreground Colors (Base 04-07)

| Level | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|-------|----------|---------|---------|---------|
| **Base 04** (Muted) | `#7BBAB1` | `#64748B` | `#808080` | `#586E75` |
| **Base 05** (Primary) | `#A7DBD8` | `#475569` | `#CCCCCC` | `#839496` |
| **Base 06** (Bright) | `#C8E6F5` | `#334155` | `#E6E6E6` | `#93A1A1` |
| **Base 07** (Highlight) | `#F0FEFF` | `#1E293B` | `#FFFFFF` | `#FDF6E3` |

### 🎨 Accent Colors (Base 08-0F)

| Color | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|-------|----------|---------|---------|---------|
| **Base 08** (Red) | `#F38630` | `#E11D48` | `#FFFFFF` | `#DC322F` |
| **Base 09** (Orange) | `#FA6900` | `#F97316` | `#E0E0E0` | `#CB4B16` |
| **Base 0A** (Yellow) | `#FEF3C7` | `#FEF3C7` | `#D4D4D4` | `#DDD389` |
| **Base 0B** (Green) | `#52C489` | `#10B981` | `#B8B8B8` | `#859900` |
| **Base 0C** (Cyan) | `#69D2E7` | `#06B6D4` | `#A0A0A0` | `#74B6B6` |
| **Base 0D** (Blue) | `#87CEEB` | `#3B82F6` | `#909090` | `#268BD2` |
| **Base 0E** (Purple) | `#8B5CF6` | `#8B5CF6` | `#808080` | `#6C71C4` |
| **Base 0F** (Magenta) | `#EC4899` | `#EC4899` | `#707070` | `#D33682` |

### 🔍 Semantic Colors

#### Syntax Highlighting
| Element | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|---------|----------|---------|---------|---------|
| **Functions** | `#69D2E7` | `#3B82F6` | `#FFFFFF` | `#268BD2` |
| **Keywords** | `#EC4899` | `#8B5CF6` | `#E0E0E0` | `#D33682` |
| **Strings** | `#52C489` | `#10B981` | `#B8B8B8` | `#859900` |
| **Types** | `#87CEEB` | `#06B6D4` | `#D4D4D4` | `#B58900` |
| **Constants** | `#F38630` | `#F97316` | `#A0A0A0` | `#CB4B16` |
| **Comments** | `#7BBAB1` | `#64748B` | `#707070` | `#586E75` |
| **Operators** | `#A7DBD8` | `#475569` | `#909090` | `#74B6B6` |

#### Diagnostics
| Level | 翠 (Sui) | 輝 (Ki) | 無 (Mu) | 空 (Ku) |
|-------|----------|---------|---------|---------|
| **Error** | `#F38630` | `#E11D48` | `#FFFFFF` | `#DC322F` |
| **Warning** | `#FA6900` | `#F97316` | `#E0E0E0` | `#DDD389` |
| **Info** | `#69D2E7` | `#3B82F6` | `#B8B8B8` | `#268BD2` |
| **Hint** | `#52C489` | `#10B981` | `#A0A0A0` | `#859900` |

## Transparency Support

All themes support transparency with the following alpha levels:
- **Primary Background**: Configurable opacity (default: 0.64 to match terminal)
- **Secondary Elements**: Maintain relative opacity relationships
- **Text**: Always fully opaque for readability
- **Diagnostics**: Full opacity for visibility

## Theme-Specific Design Notes

### 翠 (Sui) - Atmospheric Teal Garden
- **Philosophy**: Fusion of your design palettes with Makoto Shinkai's atmospheric depth
- **Multi-Palette Fusion**: 
  - **Ethereal-teal**: `#69d2e7` (light blue), `#a7dbd8` (aqua mint) for atmospheric sky
  - **Emerald-flow**: `#52c489` (medium green), `#b8e6d3` (mint) for organic depth  
  - **Ocean-breeze**: `#f0feff`, `#c8e6f5` for misty highlights
- **Use Case**: Cinematic coding experience, atmospheric immersion, nature-tech harmony
- **Aesthetic**: Light through water and leaves, contemplative depth with aqua-mint dreams
- **Layered Depth**: 6+ atmospheric tones creating Shinkai-style environmental storytelling

### 輝 (Ki) - Crystal Radiant Light
- **Philosophy**: Pure radiant light concept - cool, crisp, luminous like crystal clarity
- **Primary Hues**: Cool whites and light blues from ocean-breeze + crystal-waves palettes
- **Color References**: `#FAFCFF` (barely blue white), `#F0F9FF` (almost white blue), `#E1F5FE` (very light blue)
- **Reduced Warmth**: Replaced Renaissance earth tones with cool grays `#64748B`, `#475569`, `#334155`
- **Use Case**: Clean, crisp light mode for focused work and bright environments
- **Aesthetic**: Morning light through crystal, minimal warmth, maximum clarity
- **Soft Yellow**: Gentle `#FEF3C7` instead of harsh bright yellows

### 無 (Mu) - WCAG AAA High-Contrast Grayscale
- **Philosophy**: Maximum readability with zero color distractions
- **Contrast Ratios**: WCAG AAA compliant (7:1+ for normal text, 21:1 for highlights)
- **Color Hierarchy**: Pure black `#000000` → Pure white `#FFFFFF` with 8 distinct levels
- **Use Case**: Deep focus sessions, accessibility needs, distraction-free coding
- **Aesthetic**: High-contrast monochrome, newspaper clarity, maximum legibility
- **Benefits**: Works with all colorblind conditions, reduces cognitive load from color processing

### 空 (Ku) - Terminal-Inspired Solarized Dark
- **Philosophy**: Perfect terminal-to-editor harmony based on your kitty configuration
- **Primary Hues**: Exact match to your terminal colors - dark blue-green base with warm accents
- **Color References**: `#000F10` (terminal bg), `#839496` (terminal fg), `#DFC082` (cursor gold), Solarized palette
- **Use Case**: Seamless workflow between terminal and Neovim, familiar Solarized aesthetics
- **Aesthetic**: Deep ocean tones with golden highlights, consistent with your shell experience
- **Integration**: Matches your kitty.conf colors exactly for unified visual experience

## Implementation Notes

1. **Base32 Organization**: Colors follow Base16 extended to 32 colors for richer syntax highlighting
2. **Semantic Consistency**: Same semantic meanings across all themes (red=error, etc.)
3. **Accessibility**: All themes meet WCAG contrast requirements
4. **Terminal Compatibility**: Colors chosen to work well in both GUI and terminal Neovim
5. **Transparency Ready**: Background colors designed to work with various transparency levels

## Configuration Options

```lua
{
  style = 'ku',           -- 'sui', 'ki', 'mu', 'ku'
  transparent = true,     -- Enable transparent backgrounds
  opacity = 0.64,         -- Background opacity (0.0-1.0)
  monochrome = false,     -- Force grayscale (overrides style)
  italic_comments = true, -- Italicize comments
  bold_keywords = true,   -- Bold keywords
}
```