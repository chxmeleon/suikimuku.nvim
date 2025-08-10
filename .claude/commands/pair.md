---
allowed-tools: [Read, Write, Edit, Glob, Grep, LS, Task, TodoWrite]
description: "Agent-to-agent collaboration with role coordination"
---

# /pair - Agent Collaboration

## Usage
```
/pair [operation] [flags]
```

Manage multi-agent development sessions with role coordination and knowledge transfer.

## Key Flags
- `--start`: Initialize collaborative session
- `--navigate`: Strategic guidance mode
- `--drive`: Tactical implementation mode
- `--switch`: Exchange navigator/driver roles
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
/pair --start --session=feature-auth
/pair --navigate --session=architecture
/pair --drive --session=implementation --tdd
```

## Execution
1. Initialize collaborative session with role assignments
2. Coordinate strategic guidance and tactical execution
3. Manage role transitions and context preservation
4. Track knowledge transfer and learning outcomes
5. Generate session summaries and insights

## Output
- **Default**: `✓ pair → session active (navigator + driver)`
- **Verbose**: Complete collaboration status with role activity, knowledge transfer metrics, and session insights
- **Format**: Session coordination with context preservation and learning documentation