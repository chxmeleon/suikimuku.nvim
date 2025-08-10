---
allowed-tools: [Bash, Read, Write, Edit, Glob, Grep, LS, Task, TodoWrite]
description: "Deployment and release management"
---

# /ship - Deploy & Release

## Usage
```
/ship [target] [flags]
```

Deploys features and manages releases with quality validation.

## Key Flags
- `--increment`: Incremental deployment
- `--feedback`: Customer feedback integration
- `--rollback`: Rollback capabilities
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
/ship user-authentication
/ship --increment payment-feature
/ship --feedback dashboard-updates
```

## Execution
1. Validate deployment readiness
2. Run pre-deployment quality gates
3. Execute deployment strategy
4. Monitor deployment health
5. Collect feedback and metrics

## Output
- **Default**: `✓ ship → deployed (health: good)`
- **Verbose**: Complete deployment report with health metrics, performance data, and user feedback
- **Format**: Deployment status with monitoring dashboards and feedback collection