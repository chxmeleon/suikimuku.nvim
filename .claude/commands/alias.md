---
allowed-tools: [Bash, Read, Write]
description: "Centralized command alias resolver"
---

# /alias - Command Aliases

## Usage
```
/alias [alias] [args]
```

Execute command aliases with intelligent routing and context optimization.

## Key Aliases
- `a`: `analyze --requirements --evidence --uc`
- `d`: `design --architecture --think-hard --uc`  
- `i`: `implement --tdd --coverage --uc`
- `t`: `test --comprehensive --coverage --uc`
- `s`: `ship --increment --feedback --uc`

## Workflow Aliases
- `rapid`: Ultra-fast customer validation cycle
- `atdd`: Full ATDD workflow sequence
- `indie`: Indie hacker rapid development
- `security`: Security-focused development

## Examples
```bash
/alias a user-authentication
/alias rapid checkout-flow
/alias atdd payment-system
```

## Execution
1. Resolve alias from centralized configuration
2. Apply intelligent routing and auto-activation
3. Execute command with optimized flags
4. Provide context-aware output formatting
5. Track alias usage and optimization

## Output
- **Default**: `✓ alias → executed (analyze user-auth)`
- **Verbose**: Complete alias resolution with command mapping, flag optimization, and execution results
- **Format**: Alias execution results with intelligent routing and context preservation