# ATDD Commands Reference

**BDD→TDD command integration** with automatic sub-agent routing.

## Core ATDD Commands

### Analysis & Requirements
**`/analyze [requirement_description] [flags]`** → **bdd-analyst**
- **Purpose**: BDD requirements analysis through stakeholder collaboration
- **Focus**: Requirements → BDD scenarios → feature.yaml creation
- **Key Flags**: `--collaborate --evidence --customer --scenarios`
- **Output**: `features/*.feature.yaml` with Given/When/Then scenarios
- **Integration**: Pure BDD focus → stakeholder collaboration → ATDD workflow

**`/assess [target] [--type codebase|architecture|debt] [flags]`** → **Smart Sub-Agent Selection**
- **Purpose**: Technical analysis of existing systems and code
- **Analysis Types**: 
  - `--codebase`: Code quality assessment (→ backend-engineer/frontend-engineer)
  - `--architecture`: System design analysis (→ system-architect)
  - `--debt`: Technical debt assessment (→ multiple specialists)
- **Key Flags**: `--quality --performance --security --patterns`
- **Output**: Technical reports, quality metrics, improvement recommendations
- **Integration**: Technical assessment → improvement planning → systematic enhancement

### Design & Architecture  
**`/design [domain] [flags]`** → **ux-designer** | **system-architect**
- **Purpose**: Technical architecture and UI/UX design from BDD scenarios
- **Key Flags**: `--ui --architecture --accessibility --api --responsive`
- **Output**: Design systems + technical architecture aligned with BDD
- **Integration**: BDD scenarios → design decisions → implementation guidance

### Implementation
**`/implement [scope] [flags]`** → **frontend-engineer** | **backend-engineer**  
- **Purpose**: TDD implementation driven by feature.yaml scenarios
- **Key Flags**: `--frontend --backend --components --api --database`
- **Output**: Working code with test coverage validating BDD scenarios
- **Integration**: feature.yaml → Red/Green/Refactor → BDD validation

### Quality & Testing
**`/test [type] [flags]`** → **qa-validator**
- **Purpose**: BDD scenario validation and acceptance testing
- **Key Flags**: `--scenarios --acceptance --e2e --coverage`
- **Output**: Test results validating original BDD acceptance criteria
- **Integration**: Implementation → BDD validation → customer acceptance

### Delivery & Workflow
**`/ship [scope] [flags]`** → **bdd-analyst** (customer focus)
- **Purpose**: Customer delivery and feedback collection
- **Key Flags**: `--increment --feedback --customer --evidence`
- **Output**: Deployed features with customer validation metrics
- **Integration**: Validated features → customer delivery → feedback loop

**`/git [operation] [flags]`** → **git-specialist**
- **Purpose**: Complete git workflow automation (add → commit → push)
- **Key Flags**: `--auto --commit --conventional`
- **Output**: Conventional commits with ATDD phase context
- **Integration**: ATDD phase → commit message → workflow automation

## Collaboration Commands

**`/pair [mode] [flags]`** → **pair-coordinator**
- **Purpose**: Multi-agent collaboration and coordination
- **Key Flags**: `--start --navigate --drive --session`
- **Output**: Coordinated multi-agent development workflows
- **Integration**: ATDD phases → agent coordination → quality outcomes

**`/coordinate [scope] [flags]`** → **pair-coordinator**
- **Purpose**: Parallel development coordination across multiple domains
- **Key Flags**: `--setup --monitor --integrate --parallel`
- **Output**: Synchronized multi-agent development with quality gates
- **Integration**: Complex ATDD → parallel execution → integrated delivery

## Workflow Commands

**`/track [scope] [flags]`** → **pair-coordinator**
- **Purpose**: Progress monitoring and session management
- **Key Flags**: `--all --session --feedback --evidence`
- **Output**: ATDD progress metrics and quality indicators
- **Integration**: Continuous monitoring → evidence collection → improvement

**`/cleanup [target] [flags]`**
- **Purpose**: Technical debt reduction and maintenance
- **Key Flags**: `--outdated --dependencies --quality`
- **Output**: Cleaned codebase maintaining ATDD quality standards

**`/alias [shortcuts]`**
- **Purpose**: Workflow shortcuts for common ATDD patterns
- **Shortcuts**: `a` (analyze), `d` (design), `i` (implement), `t` (test), `s` (ship)
- **Integration**: Rapid ATDD workflow execution with full traceability

## Command Integration Patterns

### Complete ATDD Workflow (Requirements-Driven)
```bash
/analyze "user auth system" --evidence → /design --ui --architecture → /implement --frontend --backend → /test --scenarios → /ship --increment → /git --auto
```

### Technical Assessment & Improvement
```bash
/assess src/ --codebase --quality → /implement --refactor → /test --coverage → /git --auto
```

### Architecture Assessment & Enhancement
```bash
/assess --architecture --scalability → /design --refactor --patterns → /implement --incremental → /test --integration
```

### Technical Debt Reduction
```bash
/assess --debt --performance → /cleanup --priority --safe → /test --regression → /git --auto
```

### Clear Command Separation
```bash
/analyze "new payment feature"   # → BDD requirements analysis
/assess src/                    # → Technical codebase analysis
/assess package.json            # → Architecture analysis
/assess --debt                  # → Technical debt analysis
```

### Quality-First Implementation
```bash
/analyze "feature requirements" --collaborate --evidence → /design --architecture --security → /implement --tdd --coverage → /test --scenarios --e2e
```