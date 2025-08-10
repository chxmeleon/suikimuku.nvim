-- SuiKimuku (翠輝無空) Theme Color Data
-- Raw color palette definitions for all four theme variations

local themes = {
  -- 翠 (Sui) - Atmospheric Teal Garden: Multi-palette fusion with cinematic depth
  sui = {
    base = {
      "#0A1B1A", "#0F2A28", "#1A3E3B", "#2A5651", "#7BBAB1", "#A7DBD8", "#C8E6F5", "#F0FEFF"
    },
    -- Ethereal teal palette
    blue = {"#69D2E7", "#87CEEB", "#C8E6F5"},
    aqua = {"#A7DBD8", "#7BBAB1", "#52C489"},
    green = {"#52C489", "#B8E6D3", "#D1F2E8"},
    orange = {"#F38630", "#FA6900", "#E6944D"},
    magenta = {"#EC4899", "#FF77AA", "#E6A3C7"},
    cyan = {"#69D2E7", "#5FB3B3", "#6BC4BC"},
    yellow = {"#FEF3C7", "#F2D98A", "#E6C44D"}
  },

  -- 輝 (Ki) - Crystal Radiant Light: Cool, crisp, luminous radiance
  ki = {
    base = {
      "#FAFCFF", "#F0F9FF", "#E1F5FE", "#CBD5E1", "#64748B", "#475569", "#334155", "#1E293B"
    },
    -- Cool crystal palette
    blue = {"#3B82F6", "#60A5FA", "#93C5FD"},
    purple = {"#8B5CF6", "#A78BFA", "#C4B5FD"},
    green = {"#10B981", "#34D399", "#6EE7B7"},
    cyan = {"#06B6D4", "#22D3EE", "#67E8F9"},
    orange = {"#F97316", "#FB923C", "#FDBA74"},
    red = {"#E11D48", "#F43F5E", "#FB7185"},
    yellow = {"#FEF3C7", "#FEF08A", "#FDE047"}
  },

  -- 無 (Mu) - WCAG AAA High-Contrast Grayscale: Maximum contrast monochrome
  mu = {
    base = {
      "#000000", "#1A1A1A", "#2D2D2D", "#404040", "#808080", "#CCCCCC", "#E6E6E6", "#FFFFFF"
    },
    -- High contrast grayscale hierarchy
    white = {"#FFFFFF", "#F8F8F8", "#F0F0F0"},
    light = {"#E0E0E0", "#D4D4D4", "#C0C0C0"},
    medium = {"#B8B8B8", "#A0A0A0", "#909090"},
    dark = {"#808080", "#707070", "#606060"},
    black = {"#404040", "#2D2D2D", "#1A1A1A"}
  },

  -- 空 (Ku) - Terminal Solarized Dark: Perfect harmony with terminal colors
  ku = {
    base = {
      "#000F10", "#073642", "#114555", "#203047", "#586E75", "#839496", "#93A1A1", "#FDF6E3"
    },
    -- Solarized color palette
    blue = {"#268BD2", "#79A3A8", "#6699CC"},
    green = {"#859900", "#586E75", "#96FF65"},
    yellow = {"#B58900", "#DDD389", "#EAB875"},
    orange = {"#CB4B16", "#FD692A", "#EDC894"},
    red = {"#DC322F", "#E11624", "#F8404C"},
    magenta = {"#D33682", "#F51875", "#FF76A7"},
    cyan = {"#74B6B6", "#1EACB6", "#5FF4E5"},
    violet = {"#6C71C4", "#B132FF", "#BF65F6"}
  }
}

return themes
