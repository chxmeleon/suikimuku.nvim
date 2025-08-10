#!/bin/bash
# workflow-guidance.sh - Intelligent workflow guidance and persona transitions
# Hook: Stop - Provides next-step guidance when agent completes

set -euo pipefail

# Configuration
WORKFLOW_LOG=".claude/sessions/workflow.log"
GUIDANCE_FILE=".claude/sessions/next-steps.json"
PERSONA_STATE=".claude/sessions/persona-state.json"

# Hook context
AGENT_RESULT="${CLAUDE_AGENT_RESULT:-}"
CURRENT_PERSONA="${CLAUDE_PERSONA:-unknown}"
SESSION_ID="${CLAUDE_SESSION_ID:-$(basename "$PWD")-$$}"

# Ensure directories exist
mkdir -p "$(dirname "$WORKFLOW_LOG")"

# Log function
log() {
    echo "[$(date '+%H:%M:%S')] Workflow → $1" >> "$WORKFLOW_LOG"
}

# Analyze current project state
analyze_project_state() {
    local state="unknown"
    local confidence=0
    
    # Check for different project phases
    if [[ -d "features" ]] && ls features/*.feature.yaml >/dev/null 2>&1; then
        local feature_count=$(ls features/*.feature.yaml | wc -l)
        if [[ $feature_count -gt 0 ]]; then
            state="requirements_defined"
            confidence=80
        fi
    fi
    
    # Check for design documents
    if find . -name "*.md" -exec grep -l "architecture\|design\|API" {} \; | head -1 >/dev/null 2>&1; then
        state="design_phase"
        confidence=70
    fi
    
    # Check for implementation
    if find . -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" | grep -v test | head -1 >/dev/null 2>&1; then
        state="implementation_phase"
        confidence=85
    fi
    
    # Check for tests
    if find . -name "*test*" -o -name "*spec*" | head -1 >/dev/null 2>&1; then
        state="testing_phase"
        confidence=90
    fi
    
    # Check for deployment/shipping artifacts
    if [[ -f "package.json" ]] || [[ -f "Dockerfile" ]] || [[ -f "docker-compose.yml" ]]; then
        state="shipping_ready"
        confidence=75
    fi
    
    echo "$state:$confidence"
}

# Determine next logical workflow step
determine_next_steps() {
    local current_state="$1"
    local confidence="$2"
    local steps=()
    
    case "$current_state" in
        "unknown"|"initial")
            steps+=("Run '/analyze' to understand requirements and create feature definitions")
            steps+=("Identify stakeholders and gather customer evidence")
            steps+=("Create .feature.yaml files with acceptance criteria")
            ;;
        "requirements_defined")
            steps+=("Run '/design' to create technical architecture")
            steps+=("Define API contracts and data models")
            steps+=("Plan implementation strategy and dependencies")
            ;;
        "design_phase")
            if [[ $(detect_parallel_opportunities) == "true" ]]; then
                steps+=("Run '/coordinate' to setup parallel development")
                steps+=("Use '/coordinate --setup --tmux' for multi-stream development")
            else
                steps+=("Run '/implement' to start TDD implementation")
            fi
            steps+=("Begin with core features and build incrementally")
            ;;
        "implementation_phase")
            steps+=("Run '/test' to validate implementation quality")
            steps+=("Ensure test coverage meets project standards")
            steps+=("Use '/track' to monitor development progress")
            ;;
        "testing_phase")
            steps+=("Run '/ship' to prepare for deployment")
            steps+=("Validate all acceptance criteria are met")
            steps+=("Prepare documentation and deployment artifacts")
            ;;
        "shipping_ready")
            steps+=("Deploy to staging environment for validation")
            steps+=("Gather customer feedback and iterate")
            steps+=("Plan next feature iteration with '/analyze'")
            ;;
    esac
    
    if [[ ${#steps[@]} -gt 0 ]]; then
        printf '%s\n' "${steps[@]}"
    fi
}

# Detect if parallel development would be beneficial
detect_parallel_opportunities() {
    local feature_count=0
    local complex_features=0
    
    if [[ -d "features" ]]; then
        feature_count=$(ls features/*.feature.yaml 2>/dev/null | wc -l)
        
        # Check for complex features (multiple scenarios)
        for feature in features/*.feature.yaml; do
            if [[ -f "$feature" ]] && grep -q "Scenario:" "$feature"; then
                local scenario_count=$(grep -c "Scenario:" "$feature")
                if [[ $scenario_count -gt 3 ]]; then
                    ((complex_features++))
                fi
            fi
        done
    fi
    
    # Recommend parallel development if:
    # - More than 2 features OR
    # - More than 1 complex feature
    if [[ $feature_count -gt 2 ]] || [[ $complex_features -gt 1 ]]; then
        echo "true"
    else
        echo "false"
    fi
}

# Suggest optimal persona for next steps
suggest_persona() {
    local current_state="$1"
    local next_steps="$2"
    
    case "$current_state" in
        "unknown"|"initial")
            echo "analyst"
            ;;
        "requirements_defined")
            echo "architect"
            ;;
        "design_phase")
            if echo "$next_steps" | grep -q "coordinate"; then
                echo "orchestrator"
            else
                echo "engineer"
            fi
            ;;
        "implementation_phase")
            echo "engineer"
            ;;
        "testing_phase")
            echo "engineer"  # or qa_specialist if available
            ;;
        "shipping_ready")
            echo "indie_shipper"
            ;;
        *)
            echo "orchestrator"
            ;;
    esac
}

# Check for blockers or issues
check_for_blockers() {
    local blockers=()
    
    # Check for missing dependencies
    if [[ -f "package.json" ]] && [[ ! -d "node_modules" ]]; then
        blockers+=("Missing node_modules - run 'npm install'")
    fi
    
    # Check for git issues
    if git status >/dev/null 2>&1; then
        local uncommitted=$(git status --porcelain | wc -l)
        if [[ $uncommitted -gt 10 ]]; then
            blockers+=("Many uncommitted changes ($uncommitted files) - consider committing")
        fi
        
        local untracked=$(git ls-files --others --exclude-standard | wc -l)
        if [[ $untracked -gt 5 ]]; then
            blockers+=("Many untracked files ($untracked files) - review and add/ignore")
        fi
    fi
    
    # Check for test failures
    if [[ -f ".claude/sessions/quality.log" ]]; then
        local recent_failures=0
        if grep -q "✗\|failed" ".claude/sessions/quality.log" 2>/dev/null; then
            recent_failures=$(tail -50 ".claude/sessions/quality.log" | grep -c "✗\|failed" 2>/dev/null || echo "0")
        fi
        if [[ $recent_failures -gt 0 ]]; then
            blockers+=("Recent quality gate failures ($recent_failures) - check quality.log")
        fi
    fi
    
    if [[ ${#blockers[@]} -gt 0 ]]; then
        printf '%s\n' "${blockers[@]}"
    fi
}

# Generate coordination insights
generate_coordination_insights() {
    local insights=()
    
    # Check if we're in a coordination context
    if [[ -f ".claude/sessions/coordination-state.json" ]]; then
        if command -v jq >/dev/null; then
            local ready_streams=$(jq -r '.streams | to_entries[] | select(.value.status == "integration_ready") | .key' ".claude/sessions/coordination-state.json" 2>/dev/null || echo "")
            local blocked_streams=$(jq -r '.streams | to_entries[] | select(.value.status | contains("wait")) | .key' ".claude/sessions/coordination-state.json" 2>/dev/null || echo "")
            
            if [[ -n "$ready_streams" ]]; then
                insights+=("Integration opportunities available: $ready_streams")
            fi
            
            if [[ -n "$blocked_streams" ]]; then
                insights+=("Blocked streams need attention: $blocked_streams")
            fi
        fi
    fi
    
    if [[ ${#insights[@]} -gt 0 ]]; then
        printf '%s\n' "${insights[@]}"
    fi
}

# Create comprehensive guidance
create_guidance() {
    local state_info=$(analyze_project_state)
    local current_state=$(echo "$state_info" | cut -d: -f1)
    local confidence=$(echo "$state_info" | cut -d: -f2)
    
    local next_steps_array=()
    while IFS= read -r line; do
        [[ -n "$line" ]] && next_steps_array+=("$line")
    done < <(determine_next_steps "$current_state" "$confidence")
    
    local blockers_array=()
    while IFS= read -r line; do
        [[ -n "$line" ]] && blockers_array+=("$line")
    done < <(check_for_blockers)
    
    local insights_array=()
    while IFS= read -r line; do
        [[ -n "$line" ]] && insights_array+=("$line")
    done < <(generate_coordination_insights)
    
    local suggested_persona=$(suggest_persona "$current_state" "${next_steps_array[0]:-}")
    local parallel_ready=$(detect_parallel_opportunities)
    
    # Create JSON guidance
    if command -v jq >/dev/null; then
        cat > "$GUIDANCE_FILE" << EOF
{
  "session_id": "$SESSION_ID",
  "timestamp": "$(date -Iseconds)",
  "current_state": {
    "phase": "$current_state",
    "confidence": $confidence,
    "persona": "$CURRENT_PERSONA"
  },
  "recommendations": {
    "next_steps": $(printf '%s\n' "${next_steps_array[@]}" | jq -R . | jq -s .),
    "suggested_persona": "$suggested_persona",
    "parallel_development": $parallel_ready
  },
  "issues": {
    "blockers": $(printf '%s\n' "${blockers_array[@]}" | jq -R . | jq -s .),
    "coordination_insights": $(printf '%s\n' "${insights_array[@]}" | jq -R . | jq -s .)
  },
  "workflow_metrics": {
    "feature_count": $(ls features/*.feature.yaml 2>/dev/null | wc -l),
    "implementation_files": $(find . -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" | grep -v test | wc -l),
    "test_files": $(find . -name "*test*" -o -name "*spec*" | wc -l)
  }
}
EOF
    else
        # Simple fallback without jq
        cat > "$GUIDANCE_FILE" << EOF
{
  "session_id": "$SESSION_ID",
  "timestamp": "$(date -Iseconds)",
  "current_state": {
    "phase": "$current_state",
    "confidence": $confidence,
    "persona": "$CURRENT_PERSONA"
  },
  "recommendations": {
    "suggested_persona": "$suggested_persona",
    "parallel_development": $parallel_ready
  },
  "workflow_metrics": {
    "feature_count": $(ls features/*.feature.yaml 2>/dev/null | wc -l),
    "implementation_files": $(find . -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" | grep -v test | wc -l),
    "test_files": $(find . -name "*test*" -o -name "*spec*" | wc -l)
  }
}
EOF
    fi
    
    log "Generated guidance for $current_state phase (confidence: $confidence%)"
}

# Update persona state
update_persona_state() {
    local suggested_persona="unknown"
    if command -v jq >/dev/null && [[ -f "$GUIDANCE_FILE" ]]; then
        suggested_persona=$(jq -r '.recommendations.suggested_persona' "$GUIDANCE_FILE" 2>/dev/null || echo "unknown")
    fi
    
    cat > "$PERSONA_STATE" << EOF
{
  "current_persona": "$CURRENT_PERSONA",
  "suggested_persona": "$suggested_persona",
  "last_transition": "$(date -Iseconds)",
  "session_id": "$SESSION_ID",
  "transition_reason": "Workflow phase completion"
}
EOF
    
    if [[ "$CURRENT_PERSONA" != "$suggested_persona" ]] && [[ "$suggested_persona" != "unknown" ]]; then
        log "Persona transition recommended: $CURRENT_PERSONA → $suggested_persona"
    fi
}

# Display guidance summary (if in interactive mode)
display_guidance_summary() {
    if [[ -t 1 ]] && [[ -f "$GUIDANCE_FILE" ]]; then
        echo
        echo "🎯 Workflow Guidance Summary"
        echo "=========================="
        
        if command -v jq >/dev/null; then
            local current_phase=$(jq -r '.current_state.phase' "$GUIDANCE_FILE" 2>/dev/null || echo "unknown")
            local confidence=$(jq -r '.current_state.confidence' "$GUIDANCE_FILE" 2>/dev/null || echo "0")
            local suggested_persona=$(jq -r '.recommendations.suggested_persona' "$GUIDANCE_FILE" 2>/dev/null || echo "unknown")
            
            echo "Current Phase: $current_phase ($confidence% confidence)"
            echo "Suggested Persona: $suggested_persona"
            echo
            
            echo "Next Steps:"
            jq -r '.recommendations.next_steps[]? // empty' "$GUIDANCE_FILE" 2>/dev/null | sed 's/^/  • /' || echo "  • No specific steps available"
            
            local blocker_count=$(jq -r '.issues.blockers | length' "$GUIDANCE_FILE" 2>/dev/null || echo "0")
            if [[ "$blocker_count" != "0" ]] && [[ "$blocker_count" != "null" ]]; then
                echo
                echo "⚠️  Issues to Address:"
                jq -r '.issues.blockers[]? // empty' "$GUIDANCE_FILE" 2>/dev/null | sed 's/^/  • /' || echo "  • No specific issues listed"
            fi
            
            local insights_count=$(jq -r '.issues.coordination_insights | length' "$GUIDANCE_FILE" 2>/dev/null || echo "0")
            if [[ "$insights_count" != "0" ]] && [[ "$insights_count" != "null" ]]; then
                echo
                echo "🔄 Coordination Insights:"
                jq -r '.issues.coordination_insights[]? // empty' "$GUIDANCE_FILE" 2>/dev/null | sed 's/^/  • /' || echo "  • No insights available"
            fi
        else
            echo "Workflow guidance file created (jq not available for detailed display)"
            echo "File: $GUIDANCE_FILE"
        fi
        
        echo
        echo "💡 Tip: Use '/track' for detailed progress analysis"
        echo
    fi
}

# Main execution
main() {
    log "Workflow guidance triggered by agent completion"
    
    create_guidance
    update_persona_state
    
    # Only display summary if guidance file was created successfully
    if [[ -f "$GUIDANCE_FILE" ]]; then
        display_guidance_summary
        log "Workflow guidance completed - see $GUIDANCE_FILE for details"
    else
        log "Failed to create workflow guidance"
    fi
}

# Execute main function
main "$@"