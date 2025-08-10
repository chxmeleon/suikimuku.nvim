---
allowed-tools: [Read, TodoWrite, Bash, LS]
description: "Progress tracking and project monitoring"
---

# /track - Progress Tracking

## Usage
```
/track [scope] [flags]
```

Tracks project progress and provides status insights.

## Key Flags
- `--all`: Track all active work
- `--session`: Current session tracking  
- `--feedback`: Feedback integration
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
/track --all
/track --session current-feature
/track --feedback user-testing
```

## Execution
1. Analyze current project state
2. Review active tasks and progress
3. Generate status reports
4. Identify blockers and next steps
5. Provide recommendations

## Output
- **Default**: `✓ track → 3 active, 2 complete`
- **Verbose**: Complete progress report with task status, timeline analysis, and recommendations
- **Format**: Progress dashboard with metrics and actionable insights