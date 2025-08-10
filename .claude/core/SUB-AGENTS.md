# ATDD Sub-Agents

**9 intelligent specialists** with automatic activation for ATDD workflows.

## Automatic Activation Patterns

### Analysis & Requirements
**bdd-analyst** → `/analyze` commands
- **Focus**: Requirements → BDD scenarios through stakeholder collaboration
- **Triggers**: requirements, stakeholders, collaboration, evidence, "feature", "user story"
- **Outputs**: features/*.feature.yaml with Given/When/Then scenarios
- **Smart Activation**: Auto-activates for all /analyze commands (pure BDD focus)

**system-architect** → `/assess --architecture` commands
- **Focus**: System architecture analysis, design patterns, scalability assessment
- **Triggers**: architecture, system, design, scalability, "package.json", "docker"
- **Outputs**: Architecture assessment with design recommendations
- **Smart Activation**: Auto-activates for architectural analysis and system design

**backend-engineer** → `/assess --codebase` (backend code)
- **Focus**: Backend code quality, API patterns, technical debt assessment
- **Triggers**: codebase, quality, "src/api/", "server/", backend patterns
- **Outputs**: Code quality report with backend-specific recommendations
- **Smart Activation**: Auto-activates when analyzing backend codebases

**frontend-engineer** → `/assess --codebase` (frontend code)
- **Focus**: Frontend code quality, component patterns, UI technical debt
- **Triggers**: codebase, quality, "src/components/", "frontend/", UI patterns
- **Outputs**: Code quality report with frontend-specific recommendations
- **Smart Activation**: Auto-activates when analyzing frontend codebases

### Design & Architecture  
**ux-designer** → `/design --ui` commands
- **Focus**: BDD scenarios → UI/UX design with accessibility
- **Triggers**: ui, design, component, accessibility, responsive
- **Outputs**: User-centered design systems and components

**system-architect** → `/design` commands  
- **Focus**: BDD scenarios → backend architecture and technical design
- **Triggers**: architecture, api, system, backend, design
- **Outputs**: Technical architecture aligned with BDD scenarios

### Implementation
**frontend-engineer** → `/implement --frontend` commands
- **Focus**: feature.yaml → frontend TDD implementation
- **Triggers**: frontend, component, ui, implement, tdd
- **Outputs**: React/Vue/Angular components with test coverage
- **TDD Layer**: Component/UI layer with ≥85% coverage for components and UI interactions
- **Integration**: Consumes backend API contracts, drives frontend-specific test scenarios

**backend-engineer** → `/implement --backend` commands
- **Focus**: feature.yaml → backend TDD implementation  
- **Triggers**: backend, api, server, database, implement
- **Outputs**: APIs and services with comprehensive testing
- **TDD Layer**: API/Service/Database layer with ≥90% unit coverage and full integration testing
- **Integration**: Provides API contracts for frontend, implements business logic from BDD scenarios

### Quality & Delivery
**qa-validator** → `/test` commands
- **Focus**: Implementation → BDD scenario validation
- **Triggers**: test, validation, quality, scenarios, acceptance
- **Outputs**: Test results validating BDD acceptance criteria
- **TDD Layer**: E2E/Acceptance layer with ≥95% coverage for critical user workflows
- **Integration**: Validates complete system against original BDD scenarios and acceptance criteria

### Workflow Support
**git-specialist** → Complex `/git` operations
- **Focus**: Advanced git workflows with verification and recovery
- **Smart Activation**: 
  - **Direct Tools** (90%): `--auto`, `--commit` basic operations (800 tokens)
  - **Sub-Agent** (10%): `--workflow`, `--coordination`, `--deploy`, conflicts (2,000 tokens)
- **Triggers**: workflow, coordination, deploy, conflicts, multi-branch, recovery
- **Outputs**: Verified complete workflows with failure recovery
- **Verification**: Mandatory 7-step checklist for `--auto` workflows
- **Recovery**: Automatic conflict resolution and rollback procedures

**mentor-specialist** → `--teach` flags
- **Focus**: Educational guidance and knowledge transfer
- **Triggers**: teach, learn, explain, guide, mentor
- **Outputs**: Step-by-step learning with ATDD methodology

**pair-coordinator** → `/pair` `/coordinate` commands
- **Focus**: Multi-agent coordination and collaboration
- **Triggers**: pair, coordinate, session, collaboration
- **Outputs**: Orchestrated multi-agent development workflows

## Activation Algorithm
1. **Keyword Detection** (30%): Domain-specific terms in request
2. **Context Analysis** (40%): Command patterns and flag combinations  
3. **Project Context** (20%): Current ATDD phase and complexity
4. **User History** (10%): Past successful activation patterns

## Multi-Agent Coordination

### TDD Layer Integration
- **Outside-In Flow**: E2E RED (qa-validator) → Frontend TDD (frontend-engineer) → Backend TDD (backend-engineer) → E2E GREEN (qa-validator)
- **Layer Dependencies**: Frontend depends on backend API contracts, E2E depends on both layers
- **Coordination Points**: API contract validation, cross-layer error handling, integrated testing
- **Quality Gates**: Each layer must meet coverage requirements before next layer activation

### Agent Handoff Protocol
- **Primary Agent**: Leads execution within domain expertise
- **Supporting Agents**: Provide cross-domain input and validation
- **Layer Boundaries**: Clear handoff when crossing TDD layers (E2E ↔ Frontend ↔ Backend)
- **Quality Validation**: All agents validate against BDD acceptance criteria and layer-specific coverage requirements