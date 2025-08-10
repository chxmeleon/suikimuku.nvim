# Essential Command Execution

**Core lifecycle patterns** for efficient command execution with quality gates.

## Universal Command Lifecycle

### Three-Phase Architecture
All commands follow **Prep → Exec → Post** lifecycle for consistent quality.

#### Prep Phase (Preparation)
- Validate inputs and load configurations
- Initialize shared state and session context
- Check dependencies, permissions, prerequisites  
- Apply sub-agent preparations

**Quality Gates**: Input validation, permission checks, dependency verification

#### Exec Phase (Execution)
- Execute core functionality with error handling
- Apply sub-agent behavior patterns
- Generate outputs following standards
- Maintain progress tracking

**Quality Gates**: Output validation, progress checkpoints, error recovery

#### Post Phase (Post-Processing)  
- Validate results against acceptance criteria
- Update shared state with outcomes
- Clean up resources and trigger follow-ups
- Generate completion reports

**Quality Gates**: Result validation, state consistency, resource cleanup

## Essential Flow Patterns

### Sequential Flow (A → B → C)
Linear progression with context handoff between commands.

### Conditional Flow (A → condition → B || C)
Branching based on execution results and quality assessments.

### Error Recovery
- **Simple Retry**: 3 attempts with exponential backoff
- **Context Retry**: 2 attempts with fresh context reload
- **Fallback**: Alternative implementation or graceful degradation

## Quality Gates

### Pre-Command Validation
- Input validation and context preparation
- Permission checks and dependency verification

### Execution Monitoring  
- Progress tracking against milestones
- Quality checkpoints during execution

### Post-Command Validation
- Output verification and context updates
- Quality assessment and cleanup verification

---
*Load .claude/framework/EXECUTION-PATTERNS.md for comprehensive patterns*