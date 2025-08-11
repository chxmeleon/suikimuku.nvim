-- Migration Utilities for Suikimuku.nvim
-- Helps users migrate from legacy configurations to the new unified architecture

local M = {}

-- Migration status tracking
M.migration_status = {
    version = "2.0.0",
    target_version = "2.0.0",
    completed_steps = {},
    pending_steps = {}
}

-- Migration steps definition
M.migration_steps = {
    {
        id = "config_format",
        name = "Configuration Format Update",
        description = "Update configuration to new nested format",
        required = true,
        priority = 1
    },
    {
        id = "style_names", 
        name = "Style Name Normalization",
        description = "Update theme style names to new format",
        required = true,
        priority = 2
    },
    {
        id = "plugin_config",
        name = "Plugin Configuration Structure",
        description = "Update plugin configurations to new structure",
        required = false,
        priority = 3
    },
    {
        id = "color_api",
        name = "Color API Migration",
        description = "Update custom color usage to new API",
        required = false,
        priority = 4
    },
    {
        id = "command_update",
        name = "Command Usage Update", 
        description = "Update colorscheme commands to new format",
        required = false,
        priority = 5
    }
}

-- Detect legacy configuration in user's config
function M.detect_legacy_usage()
    local legacy_indicators = {}
    
    -- Check common legacy patterns
    local common_legacy_patterns = {
        -- Old init.vim patterns
        'colorscheme suikimuku-',
        'let g:suikimuku_',
        'vim.g.suikimuku_',
        
        -- Old Lua patterns
        'require("suikimuku").setup({style = "suikimuku-',
        'require("suikimuku").load("suikimuku-',
        'transparent = true',
        'italic_comments =',
        
        -- Old plugin patterns
        'telescope_style =',
        'nvim_tree_transparency =',
        'lualine_integration =',
    }
    
    -- Search for patterns in likely config locations
    local config_paths = {
        vim.fn.stdpath("config") .. "/init.lua",
        vim.fn.stdpath("config") .. "/init.vim", 
        vim.fn.stdpath("config") .. "/lua/config/colorscheme.lua",
        vim.fn.stdpath("config") .. "/lua/plugins/colorscheme.lua",
    }
    
    for _, path in ipairs(config_paths) do
        if vim.fn.filereadable(path) == 1 then
            local content = table.concat(vim.fn.readfile(path), "\n")
            
            for _, pattern in ipairs(common_legacy_patterns) do
                if content:find(pattern, 1, true) then
                    table.insert(legacy_indicators, {
                        file = path,
                        pattern = pattern,
                        type = "legacy_usage"
                    })
                end
            end
        end
    end
    
    return legacy_indicators
end

-- Generate migration plan
function M.generate_migration_plan(current_config)
    local compat = require("suikimuku.core.compat")
    local plan = {
        steps = {},
        estimated_time = 0,
        backup_needed = true,
        breaking_changes = false
    }
    
    -- Analyze current configuration
    local needs_migration = compat.migration.needs_migration(current_config)
    
    if not needs_migration then
        plan.message = "✅ No migration needed - configuration is already up to date!"
        return plan
    end
    
    -- Add relevant migration steps
    for _, step in ipairs(M.migration_steps) do
        local should_include = false
        
        if step.id == "config_format" and current_config then
            -- Check if config format needs updating
            should_include = compat.migration.needs_migration(current_config)
        elseif step.id == "style_names" and current_config and current_config.style then
            -- Check if style names need updating
            should_include = compat.legacy_config_map.style_map[current_config.style] ~= nil
        elseif step.id == "plugin_config" and current_config and current_config.plugins then
            -- Check if plugin config needs updating
            for plugin_name, plugin_config in pairs(current_config.plugins) do
                if type(plugin_config) == "boolean" then
                    should_include = true
                    break
                end
            end
        elseif step.id == "color_api" then
            -- Check if custom color API is used
            local legacy_usage = M.detect_legacy_usage()
            for _, indicator in ipairs(legacy_usage) do
                if indicator.pattern:find("get_colors") or indicator.pattern:find("get_theme_colors") then
                    should_include = true
                    break
                end
            end
        elseif step.id == "command_update" then
            -- Check if legacy commands are used
            local legacy_usage = M.detect_legacy_usage()
            for _, indicator in ipairs(legacy_usage) do
                if indicator.pattern:find("colorscheme suikimuku-") then
                    should_include = true
                    break
                end
            end
        end
        
        if should_include then
            table.insert(plan.steps, step)
            plan.estimated_time = plan.estimated_time + 5 -- 5 minutes per step estimate
            
            if step.required then
                plan.breaking_changes = true
            end
        end
    end
    
    return plan
end

-- Execute migration step
function M.execute_migration_step(step_id, current_config, options)
    options = options or {}
    local compat = require("suikimuku.core.compat")
    
    if step_id == "config_format" then
        local converted = compat.convert_legacy_config(current_config)
        return {
            success = true,
            result = converted,
            message = "Configuration format updated successfully",
            changes = "Converted to new nested configuration structure"
        }
        
    elseif step_id == "style_names" then
        local updated_config = vim.deepcopy(current_config)
        local old_style = updated_config.style
        local new_style = compat.legacy_config_map.style_map[old_style]
        
        if new_style then
            updated_config.style = new_style
            return {
                success = true,
                result = updated_config,
                message = string.format("Style name updated from '%s' to '%s'", old_style, new_style),
                changes = "Updated style name to new format"
            }
        else
            return {
                success = false,
                message = "No style name update needed",
                changes = "Style name is already in new format"
            }
        end
        
    elseif step_id == "plugin_config" then
        local updated_config = vim.deepcopy(current_config)
        updated_config.plugins = updated_config.plugins or {}
        
        local changes = {}
        for plugin_name, plugin_config in pairs(updated_config.plugins) do
            if type(plugin_config) == "boolean" then
                updated_config.plugins[plugin_name] = { enabled = plugin_config }
                table.insert(changes, string.format("Updated %s plugin config to new format", plugin_name))
            end
        end
        
        return {
            success = true,
            result = updated_config,
            message = "Plugin configurations updated",
            changes = changes
        }
        
    elseif step_id == "color_api" then
        return {
            success = true,
            message = "Color API migration completed - use require('suikimuku.core.colors').get() instead of legacy functions",
            changes = {
                "get_colors() → require('suikimuku.core.colors').get()",
                "get_theme_colors() → require('suikimuku.core.colors').get()"
            },
            manual_action_required = true
        }
        
    elseif step_id == "command_update" then
        return {
            success = true,
            message = "Command usage migration completed - use new colorscheme commands",
            changes = {
                ":colorscheme suikimuku-sui → :colorscheme suikimuku (with style = 'sui')",
                ":colorscheme suikimuku-ki → :colorscheme suikimuku (with style = 'ki')",
                ":colorscheme suikimuku-mu → :colorscheme suikimuku (with style = 'mu')", 
                ":colorscheme suikimuku-ku → :colorscheme suikimuku (with style = 'ku')"
            },
            manual_action_required = true
        }
    end
    
    return {
        success = false,
        message = "Unknown migration step: " .. step_id
    }
end

-- Run complete migration
function M.run_migration(current_config, options)
    options = vim.tbl_extend("force", {
        interactive = true,
        backup = true,
        dry_run = false
    }, options or {})
    
    local plan = M.generate_migration_plan(current_config)
    local results = {
        success = true,
        steps_completed = {},
        steps_failed = {},
        final_config = vim.deepcopy(current_config),
        backup_path = nil
    }
    
    if #plan.steps == 0 then
        results.message = "No migration needed - configuration is up to date!"
        return results
    end
    
    -- Create backup if requested
    if options.backup and not options.dry_run then
        local backup_path = vim.fn.stdpath("data") .. "/suikimuku_config_backup_" .. os.date("%Y%m%d_%H%M%S") .. ".lua"
        local backup_content = "-- Suikimuku configuration backup\nreturn " .. vim.inspect(current_config)
        vim.fn.writefile(vim.split(backup_content, "\n"), backup_path)
        results.backup_path = backup_path
    end
    
    -- Execute migration steps
    for _, step in ipairs(plan.steps) do
        if options.interactive then
            local proceed = vim.fn.confirm(
                string.format("Execute migration step: %s\n%s\n\nProceed?", step.name, step.description),
                "&Yes\n&No\n&Skip",
                1
            )
            
            if proceed == 2 then -- No - abort migration
                results.success = false
                results.message = "Migration aborted by user"
                break
            elseif proceed == 3 then -- Skip
                table.insert(results.steps_completed, {
                    id = step.id,
                    name = step.name,
                    result = "skipped"
                })
                continue
            end
        end
        
        -- Execute step
        local step_result = M.execute_migration_step(step.id, results.final_config, options)
        
        if step_result.success then
            table.insert(results.steps_completed, {
                id = step.id,
                name = step.name,
                result = step_result
            })
            
            -- Update final config if step produced a new config
            if step_result.result then
                results.final_config = step_result.result
            end
        else
            table.insert(results.steps_failed, {
                id = step.id,
                name = step.name,
                error = step_result.message
            })
            
            if step.required then
                results.success = false
                break
            end
        end
    end
    
    -- Generate migration report
    results.report = M.generate_migration_report(results)
    
    return results
end

-- Generate migration report  
function M.generate_migration_report(migration_results)
    local report = {
        "🔄 Suikimuku.nvim Migration Report",
        "=" .. string.rep("=", 35),
        ""
    }
    
    if migration_results.success then
        table.insert(report, "✅ Migration completed successfully!")
    else
        table.insert(report, "❌ Migration failed or was aborted")
    end
    
    table.insert(report, "")
    table.insert(report, string.format("Steps completed: %d", #migration_results.steps_completed))
    table.insert(report, string.format("Steps failed: %d", #migration_results.steps_failed))
    
    if migration_results.backup_path then
        table.insert(report, string.format("Backup saved to: %s", migration_results.backup_path))
    end
    
    table.insert(report, "")
    
    -- Completed steps
    if #migration_results.steps_completed > 0 then
        table.insert(report, "Completed Steps:")
        for _, step in ipairs(migration_results.steps_completed) do
            table.insert(report, string.format("  ✅ %s", step.name))
            if step.result.changes then
                if type(step.result.changes) == "table" then
                    for _, change in ipairs(step.result.changes) do
                        table.insert(report, "     " .. change)
                    end
                else
                    table.insert(report, "     " .. step.result.changes)
                end
            end
        end
        table.insert(report, "")
    end
    
    -- Failed steps
    if #migration_results.steps_failed > 0 then
        table.insert(report, "Failed Steps:")
        for _, step in ipairs(migration_results.steps_failed) do
            table.insert(report, string.format("  ❌ %s: %s", step.name, step.error))
        end
        table.insert(report, "")
    end
    
    -- Manual actions required
    local manual_actions = {}
    for _, step in ipairs(migration_results.steps_completed) do
        if step.result.manual_action_required then
            table.insert(manual_actions, step.name)
        end
    end
    
    if #manual_actions > 0 then
        table.insert(report, "Manual Actions Required:")
        for _, action in ipairs(manual_actions) do
            table.insert(report, "  ⚠️  " .. action)
        end
        table.insert(report, "")
    end
    
    -- New configuration preview
    if migration_results.final_config and migration_results.success then
        table.insert(report, "Updated Configuration:")
        table.insert(report, "require('suikimuku').setup({")
        
        local function format_config(config, indent)
            indent = indent or "  "
            for k, v in pairs(config) do
                if type(v) == "table" then
                    table.insert(report, indent .. k .. " = {")
                    format_config(v, indent .. "  ")
                    table.insert(report, indent .. "},")
                elseif type(v) == "string" then
                    table.insert(report, string.format("%s%s = '%s',", indent, k, v))
                else
                    table.insert(report, string.format("%s%s = %s,", indent, k, tostring(v)))
                end
            end
        end
        
        format_config(migration_results.final_config)
        table.insert(report, "})")
    end
    
    return table.concat(report, "\n")
end

-- Interactive migration wizard
function M.migration_wizard()
    print("🧙 Suikimuku.nvim Migration Wizard")
    print("==================================")
    print()
    
    -- Detect current configuration
    local current_config = nil
    if vim.g.suikimuku_config then
        current_config = vim.g.suikimuku_config
        print("📋 Found legacy global configuration")
    else
        print("🔍 No global configuration found - migration may be needed for manual configurations")
        print("    If you have a setup() call, the wizard will guide you through updating it.")
    end
    
    -- Detect legacy usage
    local legacy_usage = M.detect_legacy_usage()
    if #legacy_usage > 0 then
        print("🔍 Found legacy usage patterns:")
        for _, usage in ipairs(legacy_usage) do
            print(string.format("  • %s in %s", usage.pattern, usage.file))
        end
    end
    
    print()
    
    -- Generate migration plan
    local plan = M.generate_migration_plan(current_config)
    
    if plan.message then
        print(plan.message)
        return
    end
    
    print("📋 Migration Plan:")
    print(string.format("  • %d steps required", #plan.steps))
    print(string.format("  • Estimated time: %d minutes", plan.estimated_time))
    if plan.breaking_changes then
        print("  ⚠️  Contains breaking changes")
    end
    print()
    
    for i, step in ipairs(plan.steps) do
        local required_text = step.required and " (required)" or " (optional)"
        print(string.format("%d. %s%s", i, step.name, required_text))
        print("   " .. step.description)
    end
    
    print()
    
    local proceed = vim.fn.confirm("Start migration?", "&Yes\n&No", 1)
    if proceed ~= 1 then
        print("Migration cancelled.")
        return
    end
    
    -- Run migration
    local results = M.run_migration(current_config, {
        interactive = true,
        backup = true,
        dry_run = false
    })
    
    -- Show results
    print()
    print(results.report)
    
    return results
end

-- Quick migration (non-interactive)
function M.quick_migrate(current_config)
    return M.run_migration(current_config, {
        interactive = false,
        backup = true,
        dry_run = false
    })
end

-- Migration health check
function M.health_check()
    local health = {
        status = "ok",
        issues = {},
        warnings = {},
        info = {}
    }
    
    -- Check for legacy usage
    local legacy_usage = M.detect_legacy_usage()
    if #legacy_usage > 0 then
        health.status = "warning"
        for _, usage in ipairs(legacy_usage) do
            table.insert(health.warnings, string.format("Legacy usage detected: %s in %s", usage.pattern, usage.file))
        end
    end
    
    -- Check migration status
    if vim.g.suikimuku_config then
        local compat = require("suikimuku.core.compat")
        if compat.migration.needs_migration(vim.g.suikimuku_config) then
            health.status = "warning"
            table.insert(health.warnings, "Global configuration needs migration")
        end
    end
    
    if health.status == "ok" then
        table.insert(health.info, "No migration issues detected")
    end
    
    return health
end

return M