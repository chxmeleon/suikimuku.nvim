# ATDD Operational Rules

**Simple actionable rules** for evidence-based ATDD development.

## Core Rules

### File Operations
- Always use Read tool before Write or Edit operations
- Use absolute paths only, prevent path traversal attacks
- Prefer batch operations and transaction-like behavior
- Never commit automatically unless explicitly requested

### Quality Gates
- TodoRead() → TodoWrite(3+ tasks) → Execute → Track progress
- Use batch tool calls when possible, sequential only when dependencies exist
- Always validate before execution, verify after completion
- Run lint/typecheck before marking tasks complete

### Framework Compliance  
- Check package.json/pyproject.toml before using libraries
- Follow existing project patterns and conventions
- Use project's existing import styles and organization
- Respect framework lifecycles and best practices

### Evidence-Based Development
- Customer evidence required for major decisions
- All technical claims supported by measurable data
- Test coverage ≥80% for critical paths
- Performance benchmarks for optimization claims

### BDD→TDD Integration
- Stakeholder collaboration creates feature.yaml files
- Given/When/Then scenarios drive test creation
- Red → Green → Refactor cycles based on BDD scenarios
- Implementation validates against acceptance criteria

## Do ✅
- Read before Write/Edit/Update
- Use absolute paths
- Batch tool calls when possible
- Validate before execution
- Check framework compatibility
- Auto-activate sub-agents based on context
- Preserve context across operations
- Complete discovery before codebase changes
- Verify completion with evidence

## Don't ❌
- Skip Read operations
- Use relative paths  
- Auto-commit without permission
- Ignore framework patterns
- Skip validation steps
- Override safety protocols
- Make reactive codebase changes
- Mark complete without verification

## Auto-Triggers
- Sub-agent activation: domain keywords + complexity assessment
- Quality gates: all operations apply validation framework
- Evidence requirements: automatic for customer-facing decisions
- BDD workflow: collaborative scenario creation for requirements

## Smart Defaults

### Workflow Selection
- **Core ATDD**: Enterprise teams, complex systems, formal requirements
- **Indie Hacker**: Solo developers, startups, customer-validated MVPs  
- **Agent Collaboration**: Complex projects requiring multi-agent coordination
- **Teaching Integration**: Learning contexts with educational guidance

### Quality Standards
- **Customer satisfaction over internal perfection**
- **Business value over technical elegance** 
- **Evidence-based decisions over assumptions**
- **Automated quality gates over manual processes**

### Communication Standards
- **Customer language** in all business-facing communication
- **Business impact focus** in all technical decisions  
- **Evidence citation** for all claims and recommendations
- **Structured delivery** enabling automation and clarity

## Ambiguity Resolution

### Decision Hierarchy
1. **Customer Priority**: When unclear, check customer feedback or usage data
2. **Business Value**: When multiple options exist, choose higher customer/business value
3. **Quality Standards**: When quality conflicts with speed, automate quality to enable speed
4. **Scope Decisions**: When scope unclear, reduce scope and validate with customers
5. **Research Requirements**: When external library needed, use Context7 research first

### Context-Aware Defaults
- **Small teams (1-3)**: Indie Hacker patterns with quality automation
- **Medium teams (4-8)**: Core ATDD with agent collaboration  
- **Large teams (9+)**: Structured ATDD with clear role definitions
- **Learning contexts**: Teaching integration with appropriate base workflow

### Complexity-Based Escalation
- **Simple tasks**: Direct execution with minimal overhead
- **Medium complexity**: Core ATDD with quality gates
- **High complexity**: Full agent collaboration with comprehensive validation
- **Critical systems**: Maximum quality gates with evidence requirements

## Session Awareness

### Context Preservation
- **Customer Problem Context**: Maintain customer needs throughout session
- **Business Value Tracking**: Track value delivery across all activities
- **Quality Momentum**: Maintain standards without sacrificing delivery speed
- **Workflow Continuity**: Preserve workflow state and customer validation
- **Agent Context**: Preserve session state across multi-agent collaboration

### Progress Management
- **Milestone Tracking**: Clear progress indicators and completion criteria
- **Quality Checkpoints**: Regular validation against quality standards
- **Context Updates**: Continuous context enrichment and synchronization
- **Learning Capture**: Document decisions, rationale, and insights
- **Knowledge Transfer**: Preserve learning for future sessions and team members