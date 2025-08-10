# Advanced Execution Patterns

**Comprehensive execution patterns** for complex workflows and advanced coordination.

*Core lifecycle patterns available in .claude/framework/EXECUTION-CORE.md*

## Advanced Flow Control Patterns

### Sequential Flow (A → B → C)
**Pattern**: Linear progression with context handoff and enrichment

**Implementation**:
1. Command A completes and enriches shared context with results
2. Command B uses A's context and adds its own insights and artifacts
3. Command C builds on accumulated context for comprehensive outcomes

**Use Cases**:
- **ATDD Workflow**: `analyze → design → implement → test → ship`
- **Feature Development**: `requirements → architecture → development → deployment`
- **Quality Pipeline**: `code → test → review → deploy → monitor`

**Context Management**: Each command enriches context for next command in sequence

### Conditional Flow (A → (condition) → B || C)
**Pattern**: Branching based on execution results and quality assessments

**Implementation**:
1. Command A executes and returns condition result with context
2. Based on result evaluation, either B or C executes with appropriate context
3. Context preserved and enriched across branches for consistency

**Use Cases**:
- **Quality Branching**: `test → (passed) → ship || debug`
- **Complexity Routing**: `analyze → (complexity) → rapid_design || comprehensive_design`
- **Error Handling**: `implement → (success) → test || fix_and_retry`

**Decision Logic**: Evidence-based branching with documented rationale

### Parallel Flow (A & B & C → D)
**Pattern**: Concurrent execution with result aggregation and synchronization

**Implementation**:
1. Commands A, B, C execute concurrently with shared context access
2. Results are aggregated and synchronized with conflict resolution
3. Command D processes combined results with comprehensive validation

**Use Cases**:
- **Multi-Layer Development**: `frontend_impl & backend_impl & testing → integration`
- **Comprehensive Analysis**: `security_scan & performance_test & quality_review → validation`
- **Parallel Design**: `ui_design & api_design & data_design → architecture_integration`

**Synchronization**: Coordination points ensure consistent shared state

### Session-Based Flow (session_start → coordination → session_end)
**Pattern**: Agent collaboration with role management and knowledge transfer

**Implementation**:
1. Initialize session with role assignments and shared objectives
2. Coordinate role transitions and handoffs with context preservation
3. Maintain session context across interactions with quality tracking
4. Summarize and archive session results with learning capture

**Use Cases**:
- **Pair Programming**: Multi-agent collaborative development with role switching
- **Feature Development**: Cross-functional team coordination for complex features
- **Knowledge Transfer**: Learning-focused sessions with mentor integration

**Session Management**: Role coordination, context preservation, outcome tracking

## ATDD/BDD Workflow Integration

### Feature Development Flow
**Sequence**: `analyze → design → implement → test → ship`

#### Context Handoff Points

**analyze → design**:
- **Input**: Requirements and stakeholder needs with customer evidence
- **Output**: `features/*.feature.yaml` with Given/When/Then scenarios
- **Validation**: BDD-STANDARDS template compliance and stakeholder approval

**design → implement**:
- **Input**: feature.yaml scenarios and technical requirements
- **Output**: Architecture specifications and implementation plan
- **Validation**: Design addresses all acceptance criteria with technical feasibility

**implement → test**:
- **Input**: Implementation plan and feature.yaml scenarios
- **Output**: Working code with comprehensive unit test coverage
- **Validation**: TDD discipline followed, all acceptance criteria implementable

**test → ship**:
- **Input**: Tested implementation with coverage reports
- **Output**: Deployment-ready software with validation results
- **Validation**: All acceptance criteria verified, performance acceptable

### TDD Cycle Integration
**Micro-Flow**: RED → GREEN → REFACTOR with quality gates

#### RED Phase (Write Failing Test)
- **Prep**: Load feature.yaml scenario and acceptance criteria context
- **Exec**: Write minimal failing test that validates specific BDD scenario
- **Post**: Confirm test fails for expected reason, ready for implementation

#### GREEN Phase (Make Test Pass)
- **Prep**: Load failing test context and implementation requirements
- **Exec**: Implement minimal code to make test pass without breaking existing tests
- **Post**: Confirm test passes, no regressions, implementation complete

#### REFACTOR Phase (Improve Code Quality)
- **Prep**: Ensure all tests passing, identify improvement opportunities
- **Exec**: Apply Tidy First principles for structural improvements only
- **Post**: Confirm tests still pass, code quality improved, commit changes

## Agent Collaboration Patterns

### Session Management Lifecycle

#### Initialization
- **Prep**: Create session context with unique identifier and objectives
- **Exec**: Assign roles (Navigator, Driver, Coordinator) based on complexity
- **Post**: Establish communication protocols and shared workspace access

#### Active Coordination
- **Prep**: Load current session state and role assignments
- **Exec**: Facilitate role-based interactions with knowledge sharing
- **Post**: Update session state, progress tracking, and context enrichment

#### Role Transitions
- **Prep**: Validate transition conditions and handoff readiness
- **Exec**: Transfer context between roles with validation checkpoints
- **Post**: Confirm successful role switch and resumed collaboration

#### Session Completion
- **Prep**: Gather session artifacts and outcome documentation
- **Exec**: Generate comprehensive session summary with learning capture
- **Post**: Archive session context and trigger follow-up actions

### Multi-Agent Coordination Roles

#### Navigator Role (Strategic)
- **Prep**: Load architectural context and quality standards
- **Exec**: Provide high-level direction, code review, strategic guidance
- **Post**: Document decisions, rationale, and architectural insights

#### Driver Role (Tactical)
- **Prep**: Load implementation context and development tools
- **Exec**: Execute specific development tasks with quality focus
- **Post**: Report progress, seek validation, document learning outcomes

#### Coordinator Role (Orchestration)
- **Prep**: Initialize session state and role assignment tracking
- **Exec**: Manage transitions, resolve conflicts, facilitate handoffs
- **Post**: Track outcomes, update session state, plan next actions

## Error Handling & Recovery

### Retry Patterns

#### Simple Retry
- **Max Attempts**: 3 with exponential backoff
- **Conditions**: Transient failures, network issues, temporary resource constraints
- **Recovery**: Wait and retry with same parameters and context

#### Context Retry
- **Max Attempts**: 2 with immediate retry
- **Conditions**: Context resolution failures, state inconsistencies
- **Recovery**: Reload context from authoritative source and retry with fresh state

#### Fallback Retry
- **Max Attempts**: 1 with no backoff
- **Conditions**: Critical failures, resource exhaustion, timeout exceeded
- **Recovery**: Switch to alternative implementation or graceful degradation

### Recovery Strategies

#### Graceful Degradation
- **Description**: Reduce functionality while maintaining core operation value
- **Triggers**: Partial failures, resource constraints, service unavailability
- **Implementation**: Disable non-essential features, use cached data, simplified workflows

#### State Rollback
- **Description**: Restore previous known good state with data consistency
- **Triggers**: Corruption detected, inconsistency identified, critical failure
- **Implementation**: Restore from checkpoint, rollback transactions, reset context

#### Alternative Path
- **Description**: Use different approach to achieve same objective
- **Triggers**: Primary method fails repeatedly, resource unavailable
- **Implementation**: Switch to backup algorithm, use alternative service, manual workflow

## Performance Optimization

### Execution Optimization

#### Lazy Loading
- **Description**: Load resources only when required for execution
- **Application**: Large configuration files, expensive operations, optional features
- **Implementation**: Defer loading until prep phase explicitly requires resource

#### Result Caching
- **Description**: Cache expensive computation results with intelligent invalidation
- **Application**: Analysis results, API responses, complex calculations
- **Implementation**: Store in shared context with TTL and validation

#### Parallel Execution
- **Description**: Execute independent operations concurrently for efficiency
- **Application**: Multi-file processing, API calls, independent validations
- **Implementation**: Use parallel flow patterns with result synchronization

### Context Optimization

#### Context Pruning
- **Description**: Remove irrelevant context to reduce memory and processing
- **Triggers**: Context size exceeds thresholds, performance degradation
- **Implementation**: Keep only essential data for next command, archive historical data

#### Context Compression
- **Description**: Compress context for efficient transfer and storage
- **Triggers**: Large context transfers, session handoffs, memory constraints
- **Implementation**: Use structured summaries, compressed serialization, reference caching

## Quality Gates & Validation

### Pre-Command Validation
- **Input Validation**: Ensure command can execute successfully with provided parameters
- **Context Preparation**: Prepare optimal context for command execution
- **Permission Checks**: Verify necessary permissions and access rights
- **Dependency Verification**: Confirm all required resources and services available

### Execution Monitoring
- **Progress Tracking**: Monitor execution progress against expected milestones
- **Quality Checkpoints**: Regular validation against quality standards during execution
- **Resource Monitoring**: Track resource usage and performance metrics
- **Error Detection**: Proactive error detection and recovery triggering

### Post-Command Validation  
- **Output Verification**: Verify command executed successfully with expected outcomes
- **Context Updates**: Update shared context with results and learning artifacts
- **Quality Assessment**: Validate results against acceptance criteria and standards
- **Cleanup Verification**: Confirm proper resource cleanup and state consistency

## Integration Hooks

### Pre-Command Hooks
- **Validation Hook**: Comprehensive prerequisite and input validation
- **Context Preparation Hook**: Optimal context loading and sub-agent preparation
- **Audit Hook**: Compliance logging with command, user, timestamp, arguments

### Post-Command Hooks
- **Results Validation Hook**: Verify successful execution with outcome validation
- **Context Update Hook**: Merge results, update state, trigger workflow transitions
- **Cleanup Hook**: Resource cleanup, connection closure, temporary file removal

### Session Hooks
- **Session Start Hook**: Initialize collaborative context and role assignments
- **Role Transition Hook**: Manage context handoff and role switching
- **Session End Hook**: Archive results, capture learning, cleanup session state

## Monitoring & Metrics

### Execution Metrics
- **Timing Metrics**: Command duration, phase breakdown, context loading time
- **Quality Metrics**: Success/failure rates, error frequency and types, retry attempts
- **Context Metrics**: Context size, update frequency, transfer efficiency
- **Collaboration Metrics**: Session duration, role transitions, knowledge transfer quality

### Performance Baselines
- **Fast Execution**: < 2 seconds for simple commands
- **Normal Execution**: 2-10 seconds for standard operations
- **Complex Execution**: 10-30 seconds for comprehensive analysis
- **Timeout Threshold**: > 30 seconds triggers alternative approaches

### Quality Indicators
- **Success Rate**: Percentage of commands completing successfully
- **Context Efficiency**: Context utilization and transfer effectiveness
- **Learning Capture**: Knowledge retention and transfer success rates
- **Customer Value**: Business impact and customer satisfaction correlation