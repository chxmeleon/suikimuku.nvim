---
allowed-tools: [Bash, Read, Write, Edit, MultiEdit, Glob, Grep, LS, Task, TodoWrite]
description: "TDD implementation driven by BDD feature.yaml scenarios"
---

# /implement - TDD from BDD Scenarios

## Usage
```
/implement [feature-name] [flags]
```

Implements features using TDD driven by existing BDD feature.yaml scenarios from `/analyze` phase.

## Key Flags
- `--feature`: Specify feature.yaml file to implement (auto-detected if not provided)
- `--tdd`: Test-driven development mode (default)
- `--coverage`: Track and enforce code coverage
- `--security`: Security-focused implementation
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
/implement user-authentication --feature=features/user-auth.feature.yaml
/implement payment-checkout --coverage --security
/implement dashboard --tdd --uc
```

## Execution (ATDD Develop Phase)
1. **Load BDD Scenarios**: Read feature.yaml file from `/analyze` phase
2. **Test Creation**: Create failing tests based on Given/When/Then scenarios  
3. **Red Phase**: Verify tests fail (no implementation yet)
4. **Green Phase**: Implement minimal code to make tests pass
5. **Refactor Phase**: Improve code quality while keeping tests green
6. **Acceptance Validation**: Ensure implementation satisfies BDD scenarios

## Output
- **Default**: `✓ implement → TDD cycle complete (feature.yaml satisfied)`
- **Verbose**: Complete TDD implementation with test suite driven by BDD scenarios, production code, and traceability back to feature.yaml
- **Format**: Implementation files with tests that validate Given/When/Then scenarios from BDD feature file