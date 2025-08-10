#!/bin/bash
# coordinate-sync.sh - Real-time session synchronization for parallel development
# Hook: PostToolUse - Syncs coordination state after tool usage

set -euo pipefail

# Configuration
SESSIONS_DIR=".claude/sessions"
COORDINATION_STATE="$SESSIONS_DIR/coordination-state.json"
SYNC_LOG="$SESSIONS_DIR/sync.log"

# Ensure sessions directory exists
mkdir -p "$SESSIONS_DIR"

# Parse hook context from environment variables
TOOL_NAME="${CLAUDE_TOOL_NAME:-unknown}"
TOOL_RESULT="${CLAUDE_TOOL_RESULT:-}"
SESSION_ID="${CLAUDE_SESSION_ID:-$(basename "$PWD")-$$}"

# Log function
log() {
    echo "[$(date '+%H:%M:%S')] $SESSION_ID → $1" >> "$SYNC_LOG"
}

# Update session state based on tool usage
update_session_state() {
    local tool="$1"
    local timestamp=$(date -Iseconds)
    
    # Create session state file if it doesn't exist
    if [[ ! -f "$COORDINATION_STATE" ]]; then
        cat > "$COORDINATION_STATE" << EOF
{
  "session_id": "coordination-$(date +%Y%m%d-%H%M)",
  "streams": {},
  "dependencies": {},
  "integration_points": [],
  "last_sync": "$timestamp"
}
EOF
    fi
    
    # Update session activity based on tool type
    case "$tool" in
        "Write"|"Edit"|"MultiEdit")
            if echo "$TOOL_RESULT" | grep -q "test\|spec"; then
                update_stream_status "testing"
                log "Updated stream status to testing (test files modified)"
            elif echo "$TOOL_RESULT" | grep -q "feature\.yaml"; then
                update_stream_status "analyzing"
                log "Updated stream status to analyzing (feature files modified)"
            else
                update_stream_status "implementing"
                log "Updated stream status to implementing (code files modified)"
            fi
            ;;
        "Bash")
            if echo "$TOOL_RESULT" | grep -q "test.*passed\|✓"; then
                update_stream_status "testing_passed"
                check_integration_readiness
                log "Tests passed - checking integration readiness"
            elif echo "$TOOL_RESULT" | grep -q "git.*merge\|git.*commit"; then
                update_stream_status "integration_ready"
                notify_other_sessions "integration_available"
                log "Integration completed - notifying other sessions"
            fi
            ;;
        "Task")
            if echo "$TOOL_RESULT" | grep -qi "coordinate"; then
                analyze_coordination_opportunities
                log "Coordination task detected - analyzing opportunities"
            fi
            ;;
    esac
}

# Update stream status in coordination state
update_stream_status() {
    local status="$1"
    local timestamp=$(date -Iseconds)
    
    # Use jq to update the coordination state
    if command -v jq >/dev/null; then
        local stream_name=$(detect_stream_name)
        jq --arg stream "$stream_name" \
           --arg status "$status" \
           --arg timestamp "$timestamp" \
           --arg session "$SESSION_ID" \
           '.streams[$stream] = {
             "status": $status,
             "last_update": $timestamp,
             "session_id": $session,
             "worktree": (env.PWD | split("/") | last),
             "progress": (if $status == "testing_passed" then 80 elif $status == "implementing" then 50 elif $status == "analyzing" then 20 else 0 end)
           } | .last_sync = $timestamp' \
           "$COORDINATION_STATE" > "$COORDINATION_STATE.tmp" && \
        mv "$COORDINATION_STATE.tmp" "$COORDINATION_STATE"
    fi
}

# Detect stream name from current context
detect_stream_name() {
    local pwd_name=$(basename "$PWD")
    
    # Check for worktree naming pattern
    if [[ "$pwd_name" =~ worktree-(.+) ]]; then
        echo "${BASH_REMATCH[1]}"
    # Check for feature files
    elif [[ -f "features"/*.feature.yaml ]]; then
        basename features/*.feature.yaml .feature.yaml | head -1
    # Fallback to directory name
    else
        echo "$pwd_name"
    fi
}

# Check if current stream is ready for integration
check_integration_readiness() {
    local stream_name=$(detect_stream_name)
    
    # Basic readiness criteria
    local has_tests=false
    local tests_pass=false
    local has_implementation=false
    
    # Check for test files and results
    if find . -name "*test*" -o -name "*spec*" | grep -q .; then
        has_tests=true
    fi
    
    if echo "$TOOL_RESULT" | grep -q "passed\|✓"; then
        tests_pass=true
    fi
    
    # Check for implementation files
    if find . -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" | grep -v test | grep -q .; then
        has_implementation=true
    fi
    
    if $has_tests && $tests_pass && $has_implementation; then
        update_stream_status "integration_ready"
        create_integration_notification "$stream_name"
    fi
}

# Create integration notification for other sessions
create_integration_notification() {
    local stream_name="$1"
    local notification_file="$SESSIONS_DIR/notifications/${stream_name}-integration-ready.json"
    
    mkdir -p "$SESSIONS_DIR/notifications"
    
    cat > "$notification_file" << EOF
{
  "type": "integration_ready",
  "stream": "$stream_name",
  "session": "$SESSION_ID",
  "timestamp": "$(date -Iseconds)",
  "message": "Stream $stream_name is ready for integration",
  "actions": [
    "Run integration tests",
    "Merge to main branch",
    "Update dependent streams"
  ]
}
EOF
    
    log "Created integration notification for $stream_name"
}

# Notify other sessions of important events
notify_other_sessions() {
    local event_type="$1"
    local stream_name=$(detect_stream_name)
    
    # Create broadcast notification
    local broadcast_file="$SESSIONS_DIR/broadcasts/$(date +%H%M%S)-${event_type}.json"
    mkdir -p "$SESSIONS_DIR/broadcasts"
    
    cat > "$broadcast_file" << EOF
{
  "event": "$event_type",
  "source_stream": "$stream_name",
  "source_session": "$SESSION_ID",
  "timestamp": "$(date -Iseconds)",
  "data": {
    "tool": "$TOOL_NAME",
    "result_preview": "$(echo "$TOOL_RESULT" | head -3 | tr '\n' ' ')"
  }
}
EOF
    
    log "Broadcasted $event_type event to other sessions"
}

# Analyze coordination opportunities
analyze_coordination_opportunities() {
    if [[ -f "$COORDINATION_STATE" ]] && command -v jq >/dev/null; then
        # Check for streams waiting for dependencies
        local waiting_streams=$(jq -r '.streams | to_entries[] | select(.value.status | contains("wait")) | .key' "$COORDINATION_STATE" 2>/dev/null || echo "")
        
        if [[ -n "$waiting_streams" ]]; then
            local ready_streams=$(jq -r '.streams | to_entries[] | select(.value.status == "integration_ready") | .key' "$COORDINATION_STATE" 2>/dev/null || echo "")
            
            if [[ -n "$ready_streams" ]]; then
                create_coordination_suggestion "$waiting_streams" "$ready_streams"
            fi
        fi
    fi
}

# Create coordination suggestion
create_coordination_suggestion() {
    local waiting="$1"
    local ready="$2"
    local suggestion_file="$SESSIONS_DIR/suggestions/coordination-$(date +%H%M%S).json"
    
    mkdir -p "$SESSIONS_DIR/suggestions"
    
    cat > "$suggestion_file" << EOF
{
  "type": "coordination_opportunity",
  "waiting_streams": "$waiting",
  "ready_streams": "$ready",
  "timestamp": "$(date -Iseconds)",
  "recommendations": [
    "Integrate ready streams: $ready",
    "Unblock waiting streams: $waiting",
    "Check dependency resolution"
  ]
}
EOF
    
    log "Created coordination suggestion: $ready → $waiting"
}

# Main execution
main() {
    # Only process relevant tools
    case "$TOOL_NAME" in
        "Write"|"Edit"|"MultiEdit"|"Bash"|"Task")
            update_session_state "$TOOL_NAME"
            ;;
        *)
            # Silent for other tools to avoid noise
            ;;
    esac
    
    # Clean up old notifications (older than 1 hour)
    find "$SESSIONS_DIR" -name "*.json" -mmin +60 -delete 2>/dev/null || true
}

# Execute main function
main "$@"