---
allowed-tools: [Read, Write, Glob, Grep, LS, Task, TodoWrite, Bash]
description: "Multi-session parallel development coordination"
---

# /coordinate - Parallel Development Management

## Usage
```
/coordinate [features] [flags]
```

Coordinate multiple concurrent development streams with tmux integration and real-time synchronization.

## Key Flags
- `--setup`: Initialize parallel environment with tmux/worktrees
- `--monitor`: Real-time coordination dashboard
- `--integrate`: Smart feature integration when ready
- `--tmux`: Tmux session management
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
/coordinate auth,cart,payment --setup --tmux
/coordinate --monitor --real-time --dashboard
/coordinate --integrate --auto-detect --test-compatibility
```

## Execution
1. Setup parallel development environment (tmux + worktrees)
2. Monitor development streams and dependencies
3. Coordinate integration points and conflict resolution
4. Manage cross-session communication and state
5. Provide coordination recommendations

## Output
- **Default**: `✓ coordinate → 3 streams active, 1 ready for integration`
- **Verbose**: Complete coordination dashboard with stream status, integration points, and dependency mapping
- **Format**: Real-time coordination status with tmux session management and integration recommendations