# BDD Feature Standards

**Data-driven feature format** to ensure consistent BDD scenario creation and prevent agent deception.

## Feature Template Structure

### Complete Feature.yaml Template
```yaml
feature:
  name: "{{FEATURE_NAME}}"
  id: "{{FEATURE_ID}}"
  created: "{{DATE}}"
  
  story:
    as: "{{USER_ROLE}}"
    want: "{{USER_GOAL}}"
    so_that: "{{BUSINESS_VALUE}}"
    
  acceptance_criteria:
    - id: AC1
      given: "{{PRECONDITION}}"
      when: "{{ACTION}}"
      then: "{{EXPECTED_RESULT}}"
      
  scenarios:
    - name: "{{SCENARIO_NAME}}"
      covers: [AC1]
      steps:
        - given: "{{INITIAL_STATE}}"
        - when: "{{USER_ACTION}}"
        - then: "{{EXPECTED_OUTCOME}}"
      examples:
        - case: "{{TEST_CASE_NAME}}"
          input:
            {{INPUT_DATA}}
          expected:
            {{EXPECTED_OUTPUT}}
  
  test_data:
    {{SHARED_TEST_DATA}}
  
  api_contracts:
    - endpoint: "{{HTTP_METHOD}} {{API_PATH}}"
      description: "{{API_DESCRIPTION}}"
      request_schema:
        {{REQUEST_SCHEMA}}
      response_schema:
        {{RESPONSE_SCHEMA}}
      error_responses:
        - status: {{ERROR_CODE}}
          message: "{{ERROR_MESSAGE}}"
```

## Template Usage Guidelines

### For `/analyze` Commands
1. **bdd-analyst** uses this template for all feature.yaml creation
2. Stakeholder collaboration fills template variables through discussion
3. Multiple scenarios per acceptance criterion when complexity requires
4. Test data section populated with realistic customer data
5. API contracts defined when backend integration required

### Template Variables Reference

#### Core Feature Definition
- `{{FEATURE_NAME}}`: Short, descriptive feature name (kebab-case)
- `{{FEATURE_ID}}`: Unique identifier (prefix-number, e.g., auth-001)
- `{{DATE}}`: Creation date in YYYY-MM-DD format

#### User Story Elements
- `{{USER_ROLE}}`: Specific user persona (not generic "user")
- `{{USER_GOAL}}`: Concrete user objective or need
- `{{BUSINESS_VALUE}}`: Measurable business impact or customer benefit

#### BDD Scenario Elements
- `{{PRECONDITION}}`: Initial system state or context
- `{{ACTION}}`: Specific user action or trigger
- `{{EXPECTED_RESULT}}`: Observable, testable outcome
- `{{INITIAL_STATE}}`: Starting conditions for scenario
- `{{USER_ACTION}}`: User behavior or interaction
- `{{EXPECTED_OUTCOME}}`: Result that validates acceptance criteria

#### Testing & Integration
- `{{SCENARIO_NAME}}`: Descriptive scenario identifier
- `{{TEST_CASE_NAME}}`: Specific test case description
- `{{INPUT_DATA}}`: Realistic test input data
- `{{EXPECTED_OUTPUT}}`: Expected response or state
- `{{SHARED_TEST_DATA}}`: Common test data across scenarios

#### API Contracts (when applicable)
- `{{HTTP_METHOD}}`: GET, POST, PUT, DELETE, etc.
- `{{API_PATH}}`: Endpoint URL path
- `{{API_DESCRIPTION}}`: Clear endpoint purpose
- `{{REQUEST_SCHEMA}}`: JSON schema for request
- `{{RESPONSE_SCHEMA}}`: JSON schema for response
- `{{ERROR_CODE}}`: HTTP status code
- `{{ERROR_MESSAGE}}`: Error description

## Quality Standards

### Anti-Deception Measures
- **Concrete Examples**: All variables must contain specific, realistic data
- **Measurable Outcomes**: Expected results must be observable and testable
- **Customer Language**: Use business terminology, not technical jargon
- **Complete Scenarios**: Each scenario must have clear Given/When/Then structure
- **Validated Contracts**: API contracts must match implementation requirements

### Validation Checklist
- [ ] Feature name clearly describes customer capability
- [ ] User story follows "As/Want/So that" format with specific roles
- [ ] Acceptance criteria are measurable and testable
- [ ] Scenarios cover happy path, edge cases, and error conditions
- [ ] Test data represents realistic customer usage
- [ ] API contracts align with scenarios (when applicable)

## Integration with ATDD Workflow

### Discuss Phase (`/analyze`)
1. **bdd-analyst** guides stakeholder through template variables
2. Business requirements → structured feature.yaml
3. Customer evidence validates user story and acceptance criteria
4. Collaborative refinement ensures completeness

### Distill Phase (`/design`)
1. **ux-designer** uses scenarios for UI/UX design decisions
2. **system-architect** uses API contracts for backend architecture
3. Feature.yaml drives technical design alignment

### Develop Phase (`/implement`)
1. **frontend-engineer** implements UI matching Given/When/Then scenarios
2. **backend-engineer** implements APIs matching defined contracts
3. TDD cycles validate against acceptance criteria

### Demo Phase (`/test` + `/ship`)
1. **qa-validator** validates scenarios against implementation
2. Test data used for comprehensive scenario testing
3. Customer validation confirms business value delivery