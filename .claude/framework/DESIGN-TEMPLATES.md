# Design Templates for ATDD

**Structured design specifications** for complex `/design` operations with BDD→TDD integration.

## Frontend Design Template

### Component Architecture
```yaml
components:
  - name: "{{COMPONENT_NAME}}"
    type: "{{COMPONENT_TYPE}}" # container|presentational|form|layout
    responsibility: "{{COMPONENT_PURPOSE}}"
    bdd_scenarios: ["{{SCENARIO_REFERENCES}}"] # Links to feature.yaml scenarios
    props:
      - name: "{{PROP_NAME}}"
        type: "{{PROP_TYPE}}"
        required: {{REQUIRED_BOOLEAN}}
        description: "{{PROP_DESCRIPTION}}"
        validation: "{{PROP_VALIDATION_RULES}}"
    state:
      - name: "{{STATE_NAME}}"
        type: "{{STATE_TYPE}}"
        initial: "{{INITIAL_VALUE}}"
        description: "{{STATE_PURPOSE}}"
    behaviors:
      - trigger: "{{EVENT_TRIGGER}}"
        action: "{{ACTION_DESCRIPTION}}"
        result: "{{EXPECTED_RESULT}}"
        test_scenario: "{{BDD_SCENARIO_REF}}"
```

### UI Specifications
```yaml
ui_patterns:
  - pattern: "{{UI_PATTERN_NAME}}"
    implementation: "{{IMPLEMENTATION_DETAILS}}"
    accessibility: "{{A11Y_REQUIREMENTS}}" # WCAG 2.1 AA compliance
    responsive: "{{RESPONSIVE_BEHAVIOR}}" # Mobile-first approach
    bdd_validation: "{{USER_SCENARIO_VALIDATION}}"

design_system:
  colors: "{{COLOR_PALETTE_REF}}"
  typography: "{{TYPOGRAPHY_SCALE}}"
  spacing: "{{SPACING_SYSTEM}}"
  components: "{{EXISTING_COMPONENT_USAGE}}"
```

### API Integration Points
```yaml
api_integration:
  - endpoint: "{{API_ENDPOINT}}"
    method: "{{HTTP_METHOD}}"
    component: "{{CONSUMING_COMPONENT}}"
    error_handling: "{{ERROR_STRATEGY}}"
    loading_states: "{{LOADING_UI_BEHAVIOR}}"
    bdd_contract: "{{FEATURE_YAML_API_CONTRACT}}"
```

### Frontend Test Strategy
```yaml
test_approach:
  component_tests:
    framework: "{{TEST_FRAMEWORK}}" # Jest, Vitest, etc.
    coverage_target: "≥85%"
    test_types: ["rendering", "props", "state", "events"]
    bdd_integration: "Tests validate Given/When/Then scenarios"
  
  integration_tests:
    api_mocking: "{{MOCKING_STRATEGY}}"
    user_workflows: "{{USER_JOURNEY_TESTS}}"
    cross_component: "{{COMPONENT_INTERACTION_TESTS}}"
  
  ui_tests:
    framework: "{{E2E_FRAMEWORK}}" # Playwright, Cypress
    accessibility: "{{A11Y_TEST_STRATEGY}}"
    visual_regression: "{{VISUAL_TEST_APPROACH}}"
    bdd_scenarios: "Direct validation of feature.yaml scenarios"
```

## Backend Design Template

### API Architecture
```yaml
endpoints:
  - path: "{{API_PATH}}"
    method: "{{HTTP_METHOD}}"
    description: "{{ENDPOINT_PURPOSE}}"
    bdd_scenario: "{{FEATURE_YAML_SCENARIO_REF}}"
    authentication: "{{AUTH_REQUIREMENTS}}"
    rate_limiting: "{{RATE_LIMIT_RULES}}"
    request_schema:
      type: object
      properties:
        {{REQUEST_PROPERTIES}}
      required: [{{REQUIRED_FIELDS}}]
    response_schema:
      type: object
      properties:
        {{RESPONSE_PROPERTIES}}
    error_responses:
      - status: {{ERROR_CODE}}
        message: "{{ERROR_MESSAGE}}"
        conditions: "{{ERROR_CONDITIONS}}"
        bdd_scenario: "{{ERROR_SCENARIO_REF}}"
```

### Data Models
```yaml
models:
  - name: "{{MODEL_NAME}}"
    table: "{{TABLE_NAME}}"
    bdd_context: "{{FEATURE_DOMAIN_CONTEXT}}"
    fields:
      - name: "{{FIELD_NAME}}"
        type: "{{FIELD_TYPE}}"
        constraints: "{{FIELD_CONSTRAINTS}}"
        description: "{{FIELD_PURPOSE}}"
        bdd_usage: "{{SCENARIO_FIELD_USAGE}}"
    relationships:
      - type: "{{RELATIONSHIP_TYPE}}" # hasMany|belongsTo|hasOne|manyToMany
        model: "{{RELATED_MODEL}}"
        foreign_key: "{{FOREIGN_KEY}}"
        cascade: "{{CASCADE_BEHAVIOR}}"
    validations:
      - field: "{{VALIDATION_FIELD}}"
        rules: "{{VALIDATION_RULES}}"
        error_message: "{{VALIDATION_ERROR}}"
```

### Business Logic Services
```yaml
services:
  - name: "{{SERVICE_NAME}}"
    responsibility: "{{SERVICE_PURPOSE}}"
    bdd_scenarios: ["{{SCENARIO_REFERENCES}}"]
    methods:
      - name: "{{METHOD_NAME}}"
        parameters: "{{METHOD_PARAMETERS}}"
        return_type: "{{RETURN_TYPE}}"
        business_rules: "{{BUSINESS_LOGIC}}"
        error_handling: "{{ERROR_STRATEGY}}"
        test_scenarios: "{{BDD_TEST_SCENARIOS}}"
    dependencies:
      - service: "{{DEPENDENCY_SERVICE}}"
        relationship: "{{DEPENDENCY_TYPE}}"
        interface: "{{SERVICE_CONTRACT}}"
```

### Backend Test Strategy
```yaml
test_approach:
  unit_tests:
    framework: "{{TEST_FRAMEWORK}}" # Jest, Vitest, PyTest
    coverage_target: "≥90%"
    test_types: ["business_logic", "validation", "error_handling"]
    bdd_integration: "Unit tests validate individual Given/When/Then steps"
  
  integration_tests:
    database: "{{DB_TEST_STRATEGY}}"
    external_services: "{{SERVICE_TEST_STRATEGY}}"
    api_endpoints: "{{ENDPOINT_TEST_STRATEGY}}"
    bdd_integration: "Integration tests validate complete BDD scenarios"
  
  contract_tests:
    api_schemas: "{{SCHEMA_VALIDATION}}"
    database_constraints: "{{DB_CONSTRAINT_TESTS}}"
    service_interfaces: "{{SERVICE_CONTRACT_TESTS}}"
```

## Full-Stack Design Template

### System Architecture
```yaml
architecture:
  pattern: "{{ARCHITECTURAL_PATTERN}}" # MVC|MVP|MVVM|Clean|Hexagonal
  bdd_alignment: "{{BDD_ARCHITECTURE_RATIONALE}}"
  layers:
    - name: "{{LAYER_NAME}}"
      responsibility: "{{LAYER_PURPOSE}}"
      dependencies: [{{LAYER_DEPENDENCIES}}]
      communication: "{{COMMUNICATION_PATTERN}}"
      bdd_role: "{{BDD_SCENARIO_ROLE}}"
```

### Data Flow Design
```yaml
data_flow:
  - direction: "{{FLOW_DIRECTION}}" # frontend_to_backend|backend_to_frontend|bidirectional
    trigger: "{{FLOW_TRIGGER}}"
    bdd_scenario: "{{SCENARIO_TRIGGER_REF}}"
    steps:
      - component: "{{COMPONENT_NAME}}"
        action: "{{ACTION_DESCRIPTION}}"
        data_format: "{{DATA_FORMAT}}"
        validation: "{{DATA_VALIDATION}}"
        error_handling: "{{ERROR_STRATEGY}}"
```

### API Contracts
```yaml
contracts:
  - name: "{{CONTRACT_NAME}}"
    version: "{{CONTRACT_VERSION}}"
    frontend_consumer: "{{FRONTEND_COMPONENT}}"
    backend_provider: "{{BACKEND_SERVICE}}"
    bdd_scenarios: ["{{SCENARIO_REFERENCES}}"]
    schema:
      request: "{{REQUEST_SCHEMA}}"
      response: "{{RESPONSE_SCHEMA}}"
      errors: "{{ERROR_SCHEMA}}"
    breaking_change_policy: "{{BREAKING_CHANGE_RULES}}"
    backward_compatibility: "{{COMPATIBILITY_STRATEGY}}"
```

### Cross-Layer Coordination
```yaml
coordination:
  shared_state: "{{SHARED_STATE_MANAGEMENT}}"
  event_flow: "{{EVENT_COORDINATION}}"
  error_boundaries: "{{ERROR_BOUNDARY_STRATEGY}}"
  bdd_consistency: "{{CROSS_LAYER_BDD_VALIDATION}}"
  
  tdd_coordination:
    e2e_first: "{{E2E_REQUIREMENTS_DEFINITION}}"
    frontend_contracts: "{{FRONTEND_API_EXPECTATIONS}}"
    backend_implementation: "{{BACKEND_CONTRACT_FULFILLMENT}}"
    integration_validation: "{{CROSS_LAYER_TESTING}}"
```

## Design Validation Rules

### Frontend Requirements
- [ ] All components have defined props interface with validation
- [ ] Component responsibilities are single-purpose and BDD-aligned
- [ ] API integration points include comprehensive error handling
- [ ] Accessibility requirements specified (WCAG 2.1 AA minimum)
- [ ] Performance considerations documented (loading, rendering, code splitting)
- [ ] BDD scenarios directly testable through component interface

### Backend Requirements  
- [ ] All endpoints have defined request/response schemas
- [ ] Business logic separated from API layer with clear service boundaries
- [ ] Error responses cover all failure scenarios from BDD error cases
- [ ] Security considerations documented (auth, authz, data protection)
- [ ] Performance and scaling strategy defined
- [ ] Database design supports BDD scenario data requirements

### Full-Stack Requirements
- [ ] Data flow clearly defined between all layers
- [ ] API contracts versioned and documented with breaking change policies
- [ ] Cross-layer error handling coordinated and consistent
- [ ] Testing strategy covers all integration points
- [ ] BDD scenarios traceable from frontend through to backend
- [ ] Outside-in TDD flow clearly defined (E2E → Frontend → Backend → E2E)

## Template Usage Guidelines

### When to Use Design Templates
- **Complex `/design` operations** with multiple components or services
- **Full-stack features** requiring frontend and backend coordination
- **Enterprise projects** needing comprehensive design documentation
- **Team collaboration** where design decisions need clear communication
- **Stakeholder review** requiring structured design presentation

### Template Customization
- **Replace all {{PLACEHOLDER}} variables** with specific project details
- **Adapt sections** to match project technology stack and requirements
- **Link BDD scenarios** from feature.yaml files to design decisions
- **Include project-specific** validation rules and quality standards
- **Align with existing** architecture patterns and design systems

### Integration with ATDD Workflow
1. **Discuss Phase**: Requirements from `/analyze` inform template variable definitions
2. **Distill Phase**: Templates structure design decisions based on BDD scenarios
3. **Develop Phase**: Templates provide implementation guidance for TDD cycles  
4. **Demo Phase**: Templates enable validation that design meets BDD acceptance criteria