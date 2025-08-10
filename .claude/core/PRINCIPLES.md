# ATDD Development Principles

**Evidence-based development** with customer validation and technical excellence.

## Evidence Requirements

### Customer Evidence
- **Required**: Customer interviews | Usage analytics | Satisfaction surveys | Behavior tracking
- **Prohibited**: Internal assumptions | Developer preferences | Untested hypotheses  
- **Validation**: Customer feedback must support all major development decisions
- **Standards**: Customer behavior data over customer opinion data

### Technical Evidence
- **Required**: Performance benchmarks | Test coverage metrics | Code quality scores | Security scans
- **Validation**: All technical decisions supported by measurable evidence
- **Standards**: Automated metrics over manual assessments

## TDD Discipline

### Red Phase
- Write simplest failing test first
- Use meaningful test names describing behavior (e.g., 'shouldSumTwoPositiveNumbers')
- Make test failures clear and informative
- Test one small increment of functionality at a time

### Green Phase  
- Write minimum code needed to make test pass - no more
- Focus on making test pass, not perfect implementation
- Implement simplest solution that could possibly work
- Avoid premature optimization

### Refactor Phase
- Refactor only when tests are passing (Green phase)
- One refactoring change at a time
- Run tests after each refactoring step
- Prioritize refactorings that remove duplication or improve clarity

## Tidy First Principles

### Change Separation
- **Structural Changes**: Rearranging code without changing behavior (renaming, extracting methods, moving code)
- **Behavioral Changes**: Adding or modifying actual functionality
- **Golden Rule**: Never mix structural and behavioral changes in the same commit
- **Sequence**: Always make structural changes first when both are needed

### Commit Discipline  
- **ALL tests must be passing** before any commit
- **ALL compiler/linter warnings resolved** before commit
- **One logical unit of work** per commit
- **Clear distinction** between structural vs behavioral changes in commit messages

## Outside-In TDD Flow

### Layer Coordination
- **E2E RED**: Define complete user requirements and workflows
- **Frontend TDD**: Implement user interface driven by E2E scenarios  
- **Backend TDD**: Implement APIs and business logic driven by frontend needs
- **E2E GREEN**: Validate complete integration and user value delivery

### Quality Gates
- **Unit Tests**: ≥90% coverage for business logic and components
- **Integration Tests**: ≥85% coverage for API endpoints and service integration
- **E2E Tests**: ≥95% coverage for critical user workflows and acceptance criteria
- **Cross-Layer Validation**: All layers must validate against original BDD scenarios

## Development Standards
- **Quality First**: Non-negotiable quality standards that cannot be compromised
- **Continuous Improvement**: Regularly raise quality standards and practices
- **Measurement-Driven**: Use metrics to track and improve quality over time
- **Preventive Measures**: Catch issues early when they're cheaper and easier to fix
- **Automated Enforcement**: Use tooling to enforce quality standards consistently

## Code Generation Standards
- **Context-Aware**: Every code generation must consider existing patterns and architecture
- **Incremental Enhancement**: Prefer enhancing existing code over creating new implementations
- **Pattern Recognition**: Identify and leverage established patterns within the codebase
- **Framework Alignment**: Generated code must align with existing framework conventions