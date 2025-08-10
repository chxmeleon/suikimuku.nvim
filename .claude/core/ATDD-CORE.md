# ATDD Core - Agent Toolkit Foundation

**Outside-in development**: ATDD→Customer validation→Quality automation

## Core ATDD Philosophy
- **Customer problems drive all development decisions**
- **Start with customer acceptance criteria, work inward to implementation**  
- **All decisions must be supported by measurable evidence**
- **Tests define behavior before implementation begins**
- **Customer feedback drives continuous improvement**

## 4D Development Cycle
1. **Analyze** (`/analyze`) → Intelligent analysis: requirements (BDD scenarios), codebase quality, architecture, technical debt
2. **Distill** (`/design`) → Technical architecture based on analysis results (feature.yaml, quality reports, architectural insights)
3. **Develop** (`/implement`) → TDD implementation driven by analysis outputs and design specifications
4. **Demo** (`/test` + `/ship`) → Validate against analysis acceptance criteria and deliver to customers

## BDD→TDD Integration
- **BDD Collaboration**: Stakeholder discussion creates `features/*.feature.yaml` with Given/When/Then scenarios
- **Technical Design**: Architecture decisions based on BDD feature.yaml scenarios
- **TDD Implementation**: Red → Green → Refactor cycles driven by BDD scenarios  
- **Scenario Validation**: Validate implementation satisfies original BDD acceptance criteria

## Communication Principles
- **Customer Language**: Use business language that customers understand
- **Business Value Focus**: All communication emphasizes customer and business impact
- **Technical Precision**: Technical details accurate but accessible
- **Evidence Citation**: All claims backed by data, metrics, or customer feedback
- **Structured Delivery**: Consistent format enables automation and clarity

## Quality Automation
- **Quality gates enable rapid customer value delivery**
- **Multi-agent development enhances code quality and knowledge sharing**
- **External library usage requires proper documentation and evidence**
- **Customer satisfaction and business value measured continuously**
- **Same commands, different behaviors via sub-agents and flags**