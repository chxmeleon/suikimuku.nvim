---
allowed-tools: [Read, Write, Glob, Grep, LS, Task, WebFetch, WebSearch]
description: "Technical analysis: codebase quality, architecture assessment, technical debt evaluation"
---

# /assess - Technical Analysis

## Usage
```
/assess [target] [--type codebase|architecture|debt] [flags]
```

**Technical focus**: Codebase quality assessment, architecture analysis, and technical debt evaluation.

## Purpose
Systematic technical analysis of existing systems, code quality, architectural patterns, and technical debt to provide actionable improvement recommendations.

## Analysis Types
- `--codebase` (default): Code quality assessment, patterns, maintainability
- `--architecture`: System architecture analysis, design patterns, scalability
- `--debt`: Technical debt assessment, refactoring opportunities, risk analysis

## Key Flags
- `--quality`: Focus on code quality metrics and maintainability
- `--performance`: Include performance analysis and optimization
- `--security`: Security assessment and vulnerability analysis
- `--patterns`: Design pattern analysis and recommendations
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
# Codebase Analysis
/assess src/components --codebase --quality
/assess . --codebase --performance --security
/assess api/ --codebase --patterns

# Architecture Analysis  
/assess --architecture --scalability
/assess package.json --architecture --performance
/assess docker-compose.yml --architecture --patterns

# Technical Debt Analysis
/assess . --debt --performance
/assess src/ --debt --quality --patterns
/assess --debt --security
```

## Execution Modes

### Codebase Analysis (--codebase)
1. **Code Discovery**: Systematic file and pattern analysis
2. **Quality Assessment**: Code quality, maintainability, complexity metrics
3. **Pattern Recognition**: Design patterns, anti-patterns, architectural issues
4. **Issue Identification**: Bugs, vulnerabilities, improvement opportunities
5. **Recommendations**: Actionable improvement suggestions with priorities

### Architecture Analysis (--architecture)
1. **System Overview**: High-level architecture and component analysis
2. **Design Patterns**: Pattern usage and architectural decisions
3. **Dependency Analysis**: Component relationships and coupling assessment
4. **Scalability Assessment**: Performance and growth considerations
5. **Architecture Recommendations**: Structural improvement suggestions

### Technical Debt Analysis (--debt)
1. **Debt Identification**: Technical debt hotspots and impact assessment
2. **Risk Assessment**: Impact and effort estimation for improvements
3. **Refactoring Opportunities**: Prioritized refactoring recommendations
4. **Cost-Benefit Analysis**: Return on investment for debt reduction
5. **Action Plan**: Structured approach to debt reduction with timelines

## Output Formats

### Codebase Analysis
- **Default**: `✓ assess → code quality report (X issues, Y recommendations)`
- **Structure**: Quality metrics, issue summary, improvement recommendations
- **Contents**: Complexity scores, maintainability index, security findings

### Architecture Analysis
- **Default**: `✓ assess → architecture assessment (design patterns, scalability)`
- **Structure**: System overview, architectural recommendations, design insights
- **Contents**: Component analysis, dependency graphs, scalability recommendations

### Technical Debt Analysis
- **Default**: `✓ assess → technical debt report (debt score, refactoring priorities)`
- **Structure**: Debt assessment, prioritized action plan, effort estimates
- **Contents**: Debt metrics, refactoring opportunities, risk analysis

## Smart Sub-Agent Activation
- **Codebase**: backend-engineer or frontend-engineer (based on code type)
- **Architecture**: system-architect (design and scalability specialist)
- **Technical Debt**: Multiple specialists based on debt type (performance, security, refactoring)
- **Quality Focus**: qa-validator for quality assessment and testing recommendations
- **Security Focus**: security-specialist for vulnerability assessment

## Integration Patterns
Perfect complement to ATDD workflow:
```bash
# Technical assessment → improvement → validation
/assess src/ --codebase --quality → /implement --refactor → /test --coverage

# Architecture review → design → implementation  
/assess --architecture → /design --refactor → /implement → /test

# Debt analysis → cleanup → quality gates
/assess . --debt → /cleanup --priority → /test --regression
```

## Related Commands
- **Requirements Analysis**: Use `/analyze` for BDD requirements and feature.yaml creation
- **Design**: Use `/design` to create technical specifications from assessment results
- **Implementation**: Use `/implement` for improvement-driven development
- **Cleanup**: Use `/cleanup` for systematic technical debt reduction