# Essential ATDD Workflows

**Quick reference patterns** for ATDD/BDD and Indie Hacker development.

## Core ATDD Cycle

### Outside-In Development
**Customer acceptance criteria drive all development decisions**

### 4-Phase Workflow
1. **Analysis**: Requirements (`/analyze`) and Technical (`/assess`) analysis
   - **Requirements** (`/analyze`): Stakeholder collaboration → `features/*.feature.yaml`
   - **Technical** (`/assess`): Code quality, architecture, debt → improvement recommendations
2. **Design** (`/design`): Technical specifications from analysis results
3. **Implementation** (`/implement`): TDD cycles driven by design specifications
4. **Testing** (`/test`): Validation against analysis acceptance criteria

### Sub-Agent Coordination
- **analyze** → **bdd-analyst** (stakeholder collaboration)
- **assess --architecture** → **system-architect** (system design analysis)
- **assess --codebase** → **backend-engineer**/**frontend-engineer** (code analysis)
- **assess --debt** → **multiple specialists** (debt-specific expertise)
- **design** → **system-architect** + **ux-designer** (architecture + UI)
- **implement** → **frontend-engineer** + **backend-engineer** (TDD)
- **test** → **qa-validator** (validation)

## TDD Discipline

### RED-GREEN-REFACTOR Cycle
1. **RED**: Write failing test for BDD scenario (≤10 min)
2. **GREEN**: Minimal code to pass test (≤15 min) 
3. **REFACTOR**: Improve structure, maintain behavior (≤5 min)

### Quality Standards
- **Unit Tests**: ≥90% coverage for critical paths
- **Integration**: ≥85% coverage for API/component interaction
- **E2E Tests**: ≥95% coverage for critical user workflows

## Indie Hacker Rapid Development

### Customer-Driven Cycle
1. **Customer Analysis** (`--customer --rapid`): Evidence-based requirements (≤2 hours)
2. **Rapid Design** (`--mvp --rapid`): Simple, valuable solutions (≤4 hours)
3. **Sprint Implementation** (`--rapid --tdd`): Weekly deliverables (≤1 week)
4. **Weekly Shipping** (`--increment --feedback`): Active feedback loops

### Focus Areas
- **Customer validation** over technical perfection
- **Business value** delivery with quality automation
- **Evidence-based decisions** from usage analytics
- **Weekly delivery** cadence minimum

## Teaching Integration

### Educational Flags
- `--teach --explain`: Step-by-step ATDD guidance
- `--guide --patterns`: Best practices and methodology  
- `--session --teach`: Collaborative learning with mentoring

---
*Load .claude/framework/WORKFLOW-PATTERNS.md for comprehensive methodology*