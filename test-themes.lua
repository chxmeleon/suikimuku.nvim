-- Test script for SuiKimuku theme switching
-- Run this in Neovim to test all four themes

local kimuku = require('kimuku')

print("=== SuiKimuku Theme Test ===")

-- Test Ku (default - terminal solarized)
print("\n🌌 Testing Ku (空) - Terminal Solarized Dark")
kimuku.setup({ style = 'ku' })
print("✓ Ku theme applied")

vim.defer_fn(function()
    -- Test Sui (atmospheric teal)
    print("\n🌿 Testing Sui (翠) - Atmospheric Teal Garden")
    kimuku.setup({ style = 'sui', transparent = true, opacity = 0.64 })
    print("✓ Sui theme applied with transparency")
    
    vim.defer_fn(function()
        -- Test Ki (crystal light)
        print("\n💎 Testing Ki (輝) - Crystal Radiant Light")
        kimuku.setup({ style = 'ki' })
        print("✓ Ki theme applied")
        
        vim.defer_fn(function()
            -- Test Mu (grayscale)
            print("\n⚫ Testing Mu (無) - WCAG AAA Grayscale")
            kimuku.setup({ style = 'mu' })
            print("✓ Mu theme applied")
            
            vim.defer_fn(function()
                -- Return to default
                print("\n🔄 Returning to default Ku theme")
                kimuku.setup()
                print("✓ All themes tested successfully!")
                print("\nUse :lua require('kimuku').setup({style = 'THEME'}) to switch themes")
                print("Available themes: 'sui', 'ki', 'mu', 'ku'")
            end, 2000)
        end, 2000)
    end, 2000)
end, 2000)