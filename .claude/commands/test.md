---
allowed-tools: [Bash, Read, Write, Glob, Grep, LS, Task, TodoWrite]
description: "BDD scenario validation and acceptance testing"
---

# /test - BDD Scenario Validation

## Usage
```
/test [feature-name] [flags]
```

Validates implementation against original BDD scenarios and acceptance criteria from feature.yaml.

## Key Flags
- `--feature`: Specify feature.yaml to validate against (auto-detected if not provided)
- `--scenarios`: Run all Given/When/Then scenario tests  
- `--acceptance`: Validate acceptance criteria compliance
- `--coverage`: Ensure test coverage of BDD scenarios
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
/test user-authentication --scenarios --acceptance
/test payment-checkout --feature=features/payment.feature.yaml
/test dashboard --coverage --scenarios
```

## Execution (ATDD Demo Phase)
1. **Load BDD Feature**: Read original feature.yaml from `/analyze` phase
2. **Scenario Validation**: Execute tests for each Given/When/Then scenario
3. **Acceptance Criteria Check**: Validate all acceptance criteria are met
4. **Traceability Report**: Ensure implementation satisfies original BDD scenarios
5. **Quality Gates**: Verify coverage and quality standards
6. **Demo Readiness**: Confirm feature ready for customer demonstration

## Output
- **Default**: `✓ test → BDD scenarios validated (feature.yaml satisfied)`
- **Verbose**: Complete validation report showing BDD scenario compliance, acceptance criteria fulfillment, and traceability back to original feature.yaml
- **Format**: Test results with clear mapping between implementation, tests, and original BDD scenarios