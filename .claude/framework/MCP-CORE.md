# Essential MCP Integration

**Core MCP server routing** for ATDD workflows with intelligent activation.

## ATDD-Optimized MCP Servers

### Server Specializations
- **Context7**: Documentation & official patterns
- **Sequential**: Complex analysis & coordination  
- **Magic**: UI components & design systems
- **Playwright**: E2E testing & BDD validation

## Smart Server Routing

### Task-Server Affinity Matrix
| ATDD Phase | Primary Server | Secondary Server |
|-----------|---------------|-----------------|
| Analyze (BDD) | Sequential | Context7 |
| Design (UI) | Magic | Context7 |
| Design (Backend) | Context7 | Sequential |
| Implement (Frontend) | Magic | Context7 |
| Implement (Backend) | Context7 | Sequential |
| Test (BDD Validation) | Playwright | Sequential |
| Ship (Customer) | Sequential | Context7 |
| Coordinate (Multi-Agent) | Sequential | All |

### Auto-Activation Triggers
- **Context7**: `import`, `framework`, `api`, documentation keywords
- **Sequential**: `complex`, `analysis`, `coordinate`, multi-step workflows  
- **Magic**: `component`, `ui`, `design`, frontend implementation
- **Playwright**: `test`, `e2e`, `validation`, user workflow testing

### Sub-Agent Integration
**Automatic server activation** based on sub-agent specialization:
- **bdd-analyst** + stakeholder collaboration → Sequential
- **system-architect** + complex design → Sequential + Context7  
- **frontend-engineer** + component development → Magic + Context7
- **backend-engineer** + API implementation → Context7 + Sequential
- **qa-validator** + scenario testing → Playwright + Sequential

## Intelligent Escalation
- **Simple tasks**: Single MCP server based on domain
- **Medium complexity**: Primary + secondary server coordination
- **High complexity**: Multi-server orchestration
- **Critical systems**: Full MCP coordination with validation

---
*Load .claude/framework/MCP-ATDD.md for comprehensive orchestration patterns*