---
allowed-tools: [Read, Write, Edit, MultiEdit, Glob, Grep, LS, Bash, Task, TodoWrite]
description: "Project cleanup and maintenance optimization"
---

# /cleanup - Project Cleanup

## Usage
```
/cleanup [target] [flags]
```

Removes legacy code, optimizes dependencies, and reduces technical debt.

## Key Flags
- `--outdated`: Remove outdated code patterns
- `--dependencies`: Optimize project dependencies
- `--performance`: Performance cleanup
- `--security`: Security issue cleanup
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
/cleanup --outdated legacy-components
/cleanup --dependencies package.json
/cleanup --security vulnerability-scan
```

## Execution
1. Analyze codebase for cleanup opportunities
2. Identify legacy patterns and technical debt
3. Plan safe cleanup strategy
4. Execute cleanup with validation
5. Report improvements and recommendations

## Output
- **Default**: `✓ cleanup → 12 files cleaned, 3 deps removed`
- **Verbose**: Complete cleanup report with removed code, optimized dependencies, and performance improvements
- **Format**: Cleanup summary with before/after metrics and maintenance recommendations