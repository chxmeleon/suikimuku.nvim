# Comprehensive ATDD Methodology

**Complete workflow patterns** for professional ATDD/BDD development and collaboration.

*Quick reference workflows available in .claude/framework/WORKFLOW-CORE.md*

## Detailed ATDD Development Cycle

#### Analysis Phase (`/analyze`)
**Smart analysis with automatic mode detection based on target and context**

##### Requirements Analysis (`/analyze --requirements`)
- **Command**: `analyze --requirements --collaborate --evidence`
- **Input**: Stakeholder needs and business requirements
- **Process**: Gather customer evidence, define user stories, create BDD scenarios
- **Output**: `features/*.feature.yaml` following BDD-STANDARDS template
- **Quality Gate**: All requirements clear, testable, and evidence-based
- **Sub-Agent**: **bdd-analyst** facilitates stakeholder collaboration

##### Codebase Analysis (`/analyze --codebase`)
- **Command**: `analyze --codebase --quality --performance`
- **Input**: Existing codebase, directories, or specific files
- **Process**: Code quality assessment, pattern analysis, technical debt identification
- **Output**: Quality report with metrics and improvement recommendations
- **Quality Gate**: Code assessment complete with actionable recommendations
- **Sub-Agent**: **backend-engineer** or **frontend-engineer** based on code type

##### Architecture Analysis (`/analyze --architecture`)
- **Command**: `analyze --architecture --scalability --patterns`
- **Input**: System design, configuration files, architectural documentation
- **Process**: System architecture assessment, design pattern evaluation, scalability analysis
- **Output**: Architecture assessment with design recommendations and insights
- **Quality Gate**: Architectural analysis complete with improvement roadmap
- **Sub-Agent**: **system-architect** provides architectural expertise

##### Technical Debt Analysis (`/analyze --debt`)
- **Command**: `analyze --debt --refactor --priority`
- **Input**: Codebase, legacy systems, performance bottlenecks
- **Process**: Technical debt identification, impact assessment, refactoring prioritization
- **Output**: Technical debt report with prioritized action plan and effort estimates
- **Quality Gate**: Debt assessment complete with structured improvement plan
- **Sub-Agent**: Multiple specialists based on debt category (performance, security, etc.)

#### Design Phase (`/design`)
- **Command**: `design --architecture --ui --security`
- **Input**: feature.yaml with acceptance criteria
- **Process**:
  - Translate requirements into technical specifications
  - Design system architecture and component interactions
  - Define API contracts and data models aligned with BDD scenarios
  - Plan for scalability, security, and performance requirements
- **Output**: Technical specifications with architecture decision records
- **Quality Gate**: Design addresses all acceptance criteria and is implementable
- **Sub-Agents**: **system-architect** + **ux-designer** coordinate design decisions

#### Implementation Phase (`/implement`)
- **Command**: `implement --frontend --backend --tdd --coverage`
- **Input**: Technical specifications and feature.yaml scenarios
- **Process**:
  - Follow Outside-In TDD: E2E RED → Frontend TDD → Backend TDD → E2E GREEN
  - Implement from feature.yaml scenarios using RED-GREEN-REFACTOR cycles
  - Apply Tidy First principles for structural vs behavioral changes
  - Maintain quality standards: ≥90% unit, ≥85% integration, ≥95% E2E coverage
- **Output**: Working software with comprehensive test coverage
- **Quality Gate**: All acceptance criteria met with proper test validation
- **Sub-Agents**: **frontend-engineer** + **backend-engineer** coordinate layer implementation

#### Testing Phase (`/test`)
- **Command**: `test --scenarios --acceptance --e2e --coverage`
- **Input**: Implementation with comprehensive test suite
- **Process**:
  - Execute complete test suite validating all BDD scenarios
  - Perform integration testing across all system boundaries
  - Run E2E tests covering critical user workflows
  - Generate coverage reports and quality metrics
- **Output**: Test results validating all acceptance criteria
- **Quality Gate**: All tests pass, coverage targets met, performance acceptable
- **Sub-Agent**: **qa-validator** ensures comprehensive BDD scenario validation

#### Deployment Phase (`/ship`)
- **Command**: `ship --increment --customer --feedback`
- **Input**: Tested and validated implementation
- **Process**:
  - Deploy to production with automated monitoring
  - Collect customer feedback and usage analytics
  - Measure business value delivery against objectives
  - Validate customer satisfaction and acceptance
- **Output**: Live software with active feedback collection
- **Quality Gate**: Customer acceptance and measurable business value delivery
- **Sub-Agent**: **bdd-analyst** (customer focus) manages delivery and feedback

## BDD Feature Development Discipline

### Executable Specifications
- **feature.yaml as single source of truth** for all development decisions
- **Given/When/Then scenarios** drive all implementation and testing
- **Anti-deception measures** ensure realistic, domain-specific examples
- **API contracts** align technical implementation with business scenarios

### Feature Definition Standards
```yaml
structure:
  story: "As a [specific role] I want [concrete capability] so that [measurable benefit]"
  acceptance_criteria: "Given [specific context] When [precise action] Then [observable outcome]"
  scenarios: "Concrete examples with realistic domain-specific test data"
  api_contracts: "Technical interfaces supporting BDD scenarios"
```

### Validation Rules
- Each acceptance criterion must have corresponding executable scenario
- Each scenario must include realistic, domain-specific test data
- All examples must avoid generic placeholders (no "user@example.com")
- Error scenarios must be explicitly defined with recovery paths
- Edge cases must be identified and tested comprehensively

## TDD Implementation Discipline

### RED Phase (Failing Test)
- **Objective**: Write minimal failing test for next BDD scenario
- **Process**:
  - Select next unimplemented scenario from feature.yaml
  - Write simplest possible test that fails for expected reason
  - Ensure test failure message is clear and informative
  - Reference acceptance criteria ID and scenario name
- **Commit**: `test(scope): add failing test for [scenario] (AC-ID)`
- **Time Budget**: Maximum 10 minutes per test
- **Quality Standard**: Test fails for expected reason, no false failures

### GREEN Phase (Passing Implementation)
- **Objective**: Write minimal code to make test pass
- **Process**:
  - Implement simplest solution that makes test pass
  - Avoid premature optimization or extra functionality
  - Focus on making test pass, not perfect implementation
  - Ensure no existing tests are broken
- **Commit**: `feat(scope): implement [feature] to pass tests`
- **Time Budget**: Maximum 15 minutes per implementation
- **Quality Standard**: Test passes, no regressions, minimal implementation

### REFACTOR Phase (Code Improvement)
- **Objective**: Improve code structure while maintaining behavior
- **Process**:
  - Apply Tidy First principles (structural changes only)
  - Eliminate duplication and improve naming clarity
  - Extract methods and apply appropriate design patterns
  - Ensure all tests continue passing after each change
- **Commit**: `refactor(scope): improve [aspect] while maintaining tests`
- **Time Budget**: Maximum 5 minutes per refactor
- **Quality Standard**: All tests pass, code quality improved, no behavior change

## Indie Hacker Rapid Development

### Philosophy
**Customer validation drives all development decisions with weekly delivery cadence**

### Rapid Cycle: Customer Analysis → Rapid Design → Sprint Implementation → Weekly Shipping

#### Customer Analysis (`/analyze --customer --rapid`)
- **Focus**: Real customer needs and measurable business value
- **Process**:
  - Analyze customer feedback, usage analytics, and behavior tracking
  - Identify highest-value features based on customer evidence
  - Validate assumptions with actual customer data, not opinions
  - Prioritize by business impact and customer satisfaction potential
- **Output**: Customer-validated feature requirements with evidence
- **Time Budget**: Maximum 2 hours
- **Quality Gate**: All requirements backed by customer evidence

#### Rapid Design (`/design --mvp --rapid`)
- **Focus**: Simple, valuable solutions with automated quality
- **Process**:
  - Design minimal viable solution addressing core customer need
  - Choose proven technologies over experimental approaches
  - Plan automated quality gates for rapid feedback
  - Design for iteration based on customer feedback
- **Output**: MVP design with quality automation strategy
- **Time Budget**: Maximum 4 hours  
- **Quality Gate**: Design supports customer value with quality automation

#### Sprint Implementation (`/implement --rapid --tdd`)
- **Focus**: Weekly deliverables with automated quality assurance
- **Process**:
  - Implement core customer value functionality first
  - Use TDD discipline for quality without slowing delivery
  - Automate testing, linting, and deployment pipelines
  - Focus on customer value delivery over technical perfection
- **Output**: Working software increment with automated quality
- **Time Budget**: 1 week maximum
- **Quality Gate**: Customer value delivered with quality automation

#### Weekly Shipping (`/ship --increment --feedback`)
- **Focus**: Regular value delivery with active feedback collection
- **Process**:
  - Deploy working software on weekly cadence minimum
  - Collect real user feedback through usage analytics and surveys
  - Measure business impact: conversion, retention, satisfaction
  - Iterate based on actual customer usage patterns, not assumptions
- **Output**: Live software with active customer feedback loop
- **Time Budget**: Weekly delivery cadence
- **Quality Gate**: Customer satisfaction and measurable business value

## Quality Automation Integration

### Automated Testing Strategy
- **Unit Tests**: Core business logic validation (≥90% coverage)
- **Integration Tests**: API and component interaction validation (≥85% coverage)
- **E2E Tests**: Critical user workflows validation (≥95% coverage)
- **Performance Tests**: Response time and throughput validation

### Continuous Integration Gates
- **Triggers**: Every commit and pull request
- **Quality Gates**: All tests pass, security scans clear, performance benchmarks met
- **Deployment**: Automated to staging, validated deployment to production
- **Monitoring**: Real-time application health and customer experience tracking

### Customer Feedback Loops
- **Usage Analytics**: Track feature adoption, user engagement, workflow completion
- **Performance Monitoring**: Response times, error rates, system availability
- **Business Metrics**: Revenue impact, conversion rates, customer retention
- **Direct Feedback**: Customer surveys, support interactions, user interviews

## Teaching Integration Patterns

### Educational Workflow Enhancement
**Learning while building, building while learning**

#### Guided ATDD (`--teach --explain`)
- **Commands**: 
  - `analyze --requirements --teach --step-by-step`
  - `design --architecture --guide --patterns --explain`
  - `implement --tdd --teach --discipline`
  - `test --scenarios --guide --validation`
- **Educational Value**:
  - Understand ATDD principles and customer-focused development
  - Learn BDD scenario creation and stakeholder collaboration
  - Master TDD discipline and quality automation
  - Develop comprehensive testing and validation skills

#### Mentored Indie Development (`--guide --business-value`)
- **Commands**:
  - `analyze --customer --explain --business-value --evidence`
  - `design --mvp --guide --rapid-techniques --automation`
  - `implement --rapid --teach --quality-balance --delivery`
  - `ship --increment --explain --feedback-loops --measurement`
- **Educational Value**:
  - Understand customer validation and evidence-based development
  - Learn rapid development with quality automation techniques
  - Master business value focus and customer-centric decision making
  - Develop feedback-driven iteration and continuous improvement

#### Collaborative Learning (`--session --teach`)
- **Commands**:
  - `coordinate feature-auth --session=learning --teach --roles`
  - `pair --start --session=learning --guide --collaboration`
  - `implement --session=learning --teach --knowledge-transfer`
- **Educational Value**:
  - Experience professional collaborative development practices
  - Learn multi-agent coordination and knowledge sharing
  - Develop communication and teamwork skills
  - Practice real-world software development workflows

### Adaptive Teaching Strategies

#### Beginner Adaptations
- Start with ATDD fundamentals and clear customer value explanations
- Use simple, realistic examples with comprehensive step-by-step guidance
- Provide frequent validation checkpoints and confidence building
- Focus on understanding principles before advancing to complex techniques

#### Intermediate Adaptations  
- Build on existing development knowledge and practical experience
- Introduce advanced patterns, quality automation, and collaboration techniques
- Provide challenging but achievable projects with real customer scenarios
- Focus on professional practices and industry-standard methodologies

#### Advanced Adaptations
- Assume strong technical foundation and development experience
- Explore trade-offs, optimization strategies, and architectural decisions
- Discuss expert-level considerations and leadership techniques
- Focus on innovation, team coordination, and continuous improvement

## Workflow Selection Guide

### Project Context Patterns
- **Startup/MVP**: Indie Hacker patterns with customer validation focus
- **Enterprise/Team**: ATDD patterns with comprehensive collaboration
- **Learning/Skill Development**: Teaching integration with any workflow
- **Maintenance/Refactoring**: ATDD with quality and technical debt focus

### Team Composition Adaptations
- **Solo Developer**: Indie Hacker with automated quality gates
- **Small Team (2-5)**: ATDD with agent collaboration patterns
- **Large Team (6+)**: Structured ATDD with clear role definitions
- **Mixed Experience**: Teaching integration throughout all workflows

### Domain Requirements
- **High Quality/Compliance**: Comprehensive ATDD with strict validation
- **Rapid Market Validation**: Indie Hacker with customer feedback loops
- **Complex Systems**: ATDD with multi-agent collaboration and systematic approach
- **Learning/Education**: Teaching integration overlay on appropriate base workflow