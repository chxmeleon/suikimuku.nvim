# ATDD Flags System

**Comprehensive flag system** for ATDD workflow optimization and sub-agent coordination.

## Universal Flags (All Commands)
```bash
--plan          # Plan mode for complex tasks
--dry-run       # Simulate without execution  
--uc            # Ultra-compressed mode (default)
--think         # Enable thinking for complex problems
--evidence      # Require customer evidence
--customer      # Customer-focused validation
--rapid         # Rapid iteration mode
--session       # Multi-agent coordination
--teach         # Educational guidance with mentor persona
```

## ATDD Workflow Flags

### Evidence & Validation
- `--evidence`: Require measurable customer evidence for all decisions
- `--customer`: Customer-focused approach and validation throughout
- `--collaborate`: Enable collaborative stakeholder development mode (requirements analysis)
- `--scenarios`: Generate comprehensive BDD test scenarios (requirements analysis)
- `--acceptance`: Focus on acceptance criteria validation

### Analysis Type Flags
- `--requirements`: BDD requirements analysis with stakeholder collaboration (default for descriptive targets)
- `--codebase`: Technical codebase analysis and quality assessment (default for file/directory targets)
- `--architecture`: System architecture and design pattern analysis (default for config files)
- `--debt`: Technical debt assessment and refactoring prioritization
- `--quality`: Focus on code quality metrics and maintainability (codebase analysis)
- `--performance`: Include performance analysis and optimization recommendations

### Development Approach  
- `--rapid`: Rapid iteration and MVP development mode
- `--constraints`: Work within defined resource constraints
- `--incremental`: Incremental development and delivery approach
- `--quality-gates`: Enable automated quality enforcement
- `--coverage`: Enable code coverage tracking and validation

### Collaboration & Coordination
- `--session`: Multi-agent session coordination and state management
- `--parallel`: Enable parallel development coordination across domains
- `--coordinate`: Advanced multi-agent coordination with quality gates
- `--pair`: Pair programming mode with navigator/driver dynamics

## Sub-Agent Activation Flags

### Analysis & Requirements
- `--requirements`: Auto-activates **bdd-analyst** for stakeholder collaboration and BDD scenarios
- `--collaborate`: Enhances **bdd-analyst** with stakeholder discussion mode
- `--evidence`: Requires **bdd-analyst** to validate customer evidence
- `--scenarios`: Focuses **bdd-analyst** on comprehensive scenario generation
- `--codebase`: Auto-activates **backend-engineer** or **frontend-engineer** based on code type
- `--architecture`: Auto-activates **system-architect** for design and scalability analysis
- `--debt`: Auto-activates multiple specialists based on technical debt category
- `--quality`: Enhances code analysis with quality metrics and maintainability focus
- `--performance`: Adds performance analysis and optimization recommendations

### Design & Architecture
- `--ui`: Auto-activates **ux-designer** for user interface design
- `--accessibility`: Enhances **ux-designer** with accessibility focus
- `--responsive`: Adds responsive design patterns to **ux-designer**
- `--architecture`: Auto-activates **system-architect** for backend design
- `--api`: Focuses **system-architect** on API design and contracts
- `--security`: Enhances **system-architect** with security considerations

### Implementation
- `--frontend`: Auto-activates **frontend-engineer** for UI implementation  
- `--backend`: Auto-activates **backend-engineer** for server implementation
- `--components`: Focuses **frontend-engineer** on component development
- `--database`: Enhances **backend-engineer** with database integration
- `--tdd`: Enforces test-driven development across all engineers

### Quality & Testing
- `--scenarios`: Auto-activates **qa-validator** for BDD scenario testing
- `--e2e`: Focuses **qa-validator** on end-to-end testing workflows
- `--coverage`: Enhances **qa-validator** with coverage analysis
- `--acceptance`: Prioritizes acceptance criteria validation

### Workflow Support
- `--auto`: Activates **git-specialist** for complete workflow automation
- `--commit`: Focuses **git-specialist** on commit generation only
- `--conventional`: Enhances **git-specialist** with conventional commit format
- `--teach`: Auto-activates **mentor-specialist** for educational guidance
- `--coordinate`: Auto-activates **pair-coordinator** for multi-agent workflow

## Token Efficiency Flags

### Compression Modes
- `--uc`: Ultra-compressed mode for token efficiency (default)
- `--ultracompressed`: Maximum compression for large operations
- `--verbose`: Full detail mode (overrides compression)

### Processing Optimization
- `--batch`: Batch related operations to reduce context switching
- `--parallel`: Enable parallel processing when possible
- `--cache`: Use cached results for repeated operations

## Flag Combination Patterns

### Complete ATDD Workflow
```bash
--evidence --customer --collaborate --scenarios --tdd --coverage --auto
```

### Rapid MVP Development
```bash
--rapid --incremental --customer --uc --batch
```

### Enterprise Quality Focus
```bash
--evidence --quality-gates --coverage --security --acceptance --conventional
```

### Educational Mode
```bash
--teach --think --plan --verbose --evidence
```

### Multi-Agent Coordination
```bash
--session --parallel --coordinate --quality-gates --coverage
```

## Flag Precedence Rules
1. Safety flags (`--quality-gates`) > optimization flags
2. Explicit flags > auto-activation  
3. Customer flags (`--customer --evidence`) > internal preferences
4. ATDD workflow flags > generic development flags
5. Compression flags auto-activate based on context size
6. Sub-agent flags determine automatic specialist activation