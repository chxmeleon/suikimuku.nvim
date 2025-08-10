# SuiKimuku.nvim

A comprehensive four-theme color scheme for Neovim with Japanese aesthetic philosophy.

## Themes

- **翠 (Sui)** - Atmospheric Teal Garden: Organic, cinematic depth with aqua-mint dreams
- **輝 (Ki)** - Crystal Radiant Light: Clean, crisp light mode for focused work  
- **無 (Mu)** - WCAG AAA Grayscale: High-contrast monochrome for distraction-free coding
- **空 (Ku)** - Terminal Solarized Dark: Seamless terminal-to-editor harmony

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'chxmeleon/suikimuku.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kimuku').setup({
      style = 'ku',           -- 'sui', 'ki', 'mu', 'ku'
      transparent = false,    -- Enable transparent backgrounds
      opacity = 0.64,         -- Background opacity (0.0-1.0)
    })
  end,
}
```

## Usage

```lua
-- Switch themes dynamically
require('kimuku').setup({ style = 'sui' })   -- Atmospheric teal
require('kimuku').setup({ style = 'ki' })    -- Crystal light
require('kimuku').setup({ style = 'mu' })    -- High-contrast grayscale  
require('kimuku').setup({ style = 'ku' })    -- Terminal solarized
```

See [SPEC.md](SPEC.md) for complete color specifications and design philosophy.
