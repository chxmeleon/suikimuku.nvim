---
allowed-tools: [Read, Write, Glob, Grep, LS, Task, WebFetch, WebSearch]
description: "BDD requirements analysis: stakeholder collaboration → feature.yaml creation"
---

# /analyze - BDD Requirements Analysis

## Usage
```
/analyze [requirement_description] [flags]
```

**Pure BDD focus**: Requirements analysis through stakeholder collaboration creating `features/*.feature.yaml` files.

## Purpose
Transform user requirements and business needs into structured BDD scenarios through collaborative stakeholder engagement.

## Key Flags
- `--collaborate`: Enable stakeholder collaboration mode (default)
- `--evidence`: Require measurable acceptance criteria
- `--customer`: Customer-focused validation and business value
- `--scenarios`: Generate comprehensive BDD test scenarios
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
# BDD Requirements Analysis
/analyze "user authentication system" --collaborate --evidence
/analyze "payment checkout flow" --customer --scenarios
/analyze "admin dashboard features" --evidence

# Customer-focused analysis
/analyze "mobile app onboarding" --customer --collaborate
```

## Execution Process
1. **Stakeholder Identification**: Business stakeholders, developers, testers
2. **Requirements Discovery**: Collaborative discussion and validation
3. **BDD Template Creation**: Use `.claude/core/BDD-STANDARDS.md` for feature.yaml
4. **Scenario Development**: Complete Given/When/Then scenarios
5. **Acceptance Criteria**: Measurable, testable acceptance criteria
6. **Feature.yaml Generation**: Structured BDD feature files

## Output Format
- **Default**: `✓ analyze → features/[name].feature.yaml (Given/When/Then scenarios)`
- **Structure**: BDD feature.yaml file with stakeholder validation
- **Contents**: Feature description, scenarios, acceptance criteria, examples

## Sub-Agent Activation
- **Primary**: bdd-analyst (stakeholder collaboration specialist)
- **Focus**: Requirements → BDD scenarios through evidence-based collaboration

## ATDD Integration
Perfect integration with ATDD workflow:
```bash
/analyze "feature requirements" → /design → /implement → /test → /ship
```

## Related Commands
- **Technical Analysis**: Use `/assess` for codebase, architecture, or technical debt analysis
- **Design**: Use `/design` to create technical specifications from BDD scenarios
- **Implementation**: Use `/implement` for TDD cycles driven by BDD scenarios