---
allowed-tools: [Read, Write, Edit, MultiEdit, Glob, Grep, LS, Task, WebFetch, WebSearch]
description: "Solution architecture and technical planning"
---

# /design - System Design

## Usage
```
/design [target] [flags]
```

Creates technical architecture and implementation plans from requirements.

## Key Flags
- `--architecture`: System architecture focus
- `--api`: API design and specifications
- `--ui`: User interface design
- `--security`: Security architecture
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
/design user-authentication-system
/design --api payment-service --security
/design --ui dashboard-components
```

## Execution
1. Analyze requirements and constraints
2. Create system architecture and component design
3. Define API contracts and data models
4. Plan implementation strategy and dependencies
5. Generate technical specifications and ADRs

## Output
- **Default**: `✓ design → architecture (API + UI specs)`
- **Verbose**: Complete technical specifications with architecture diagrams, API contracts, component designs, and implementation guides
- **Format**: Technical documentation with system diagrams and implementation plans