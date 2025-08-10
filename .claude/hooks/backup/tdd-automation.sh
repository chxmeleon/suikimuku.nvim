#!/bin/bash

# TDD Automation Hook - Intelligent Git Automation for TDD Cycles
# Integrates with Agent Toolkit v3.0 for automated commit generation
# Supports conventional commits with scope detection and TDD patterns

set -euo pipefail

# Configuration
HOOK_NAME="tdd-automation"
LOG_FILE="/tmp/claude-tdd-automation.log"
STATE_DIR="/tmp/claude-tdd-state"
COMMIT_TEMPLATE_DIR=".claude/templates/commits"
STANDARDS_FILE=".claude/core/standards.yml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$HOOK_NAME] $1" | tee -a "$LOG_FILE"
}

# Error handling
error_exit() {
    log "ERROR: $1" >&2
    exit 1
}

# Initialize state directory
init_state() {
    mkdir -p "$STATE_DIR"
    touch "$STATE_DIR/tdd_cycle_state"
    touch "$STATE_DIR/current_feature"
    touch "$STATE_DIR/test_results"
    touch "$STATE_DIR/commit_history"
}

# Detect TDD cycle phase based on test results and file changes
detect_tdd_phase() {
    local git_status
    local test_results
    local changed_files
    
    git_status=$(git status --porcelain)
    changed_files=$(echo "$git_status" | awk '{print $2}' | sort)
    
    # Check for test files
    test_files=$(echo "$changed_files" | grep -E '\.(test|spec)\.(js|ts|jsx|tsx|py|rb|go|java|php|cs)$' || true)
    impl_files=$(echo "$changed_files" | grep -vE '\.(test|spec)\.' || true)
    
    # Detect package manager and run tests
    local test_cmd=""
    if [ -f "package.json" ]; then
        # Use Agent Toolkit universal package manager detection
        if [ -f "bun.lockb" ]; then
            test_cmd="bun test"
        elif [ -f "pnpm-lock.yaml" ]; then
            test_cmd="pnpm test"
        elif [ -f "yarn.lock" ]; then
            test_cmd="yarn test"
        elif [ -f "package-lock.json" ]; then
            test_cmd="npm test"
        else
            # Fallback to bun as modern default
            test_cmd="bun test"
        fi
        
        if command -v ${test_cmd%% *} &> /dev/null; then
            $test_cmd > "$STATE_DIR/test_results" 2>&1 || true
        fi
    elif command -v pytest &> /dev/null; then
        pytest > "$STATE_DIR/test_results" 2>&1 || true
    elif command -v go &> /dev/null && [ -f "go.mod" ]; then
        go test ./... > "$STATE_DIR/test_results" 2>&1 || true
    fi
    
    test_results=$(cat "$STATE_DIR/test_results" 2>/dev/null || echo "")
    
    # TDD Phase Detection Logic
    if [ -n "$test_files" ] && [ -z "$impl_files" ]; then
        # Only test files changed - likely RED phase
        if echo "$test_results" | grep -q "FAIL\|ERROR\|failed\|error"; then
            echo "RED"
        else
            echo "GREEN"
        fi
    elif [ -n "$impl_files" ] && [ -z "$test_files" ]; then
        # Only implementation files changed - likely GREEN phase
        if echo "$test_results" | grep -q "PASS\|OK\|passed\|success"; then
            echo "GREEN"
        else
            echo "RED"
        fi
    elif [ -n "$test_files" ] && [ -n "$impl_files" ]; then
        # Both test and implementation files changed - likely REFACTOR phase
        if echo "$test_results" | grep -q "PASS\|OK\|passed\|success"; then
            echo "REFACTOR"
        else
            echo "GREEN"
        fi
    else
        echo "UNKNOWN"
    fi
}

# Auto-detect scope from changed files
detect_scope() {
    local changed_files
    local scope
    
    changed_files=$(git diff --cached --name-only | head -10)
    
    # Apply scope detection rules from standards.yml
    while IFS= read -r file; do
        case "$file" in
            src/api/*) scope="api" ;;
            src/services/*) scope="service" ;;
            src/models/*) scope="model" ;;
            src/components/*) scope="component" ;;
            src/pages/*) scope="page" ;;
            src/utils/*) scope="utils" ;;
            src/auth/*) scope="auth" ;;
            src/middleware/*) scope="middleware" ;;
            tests/e2e/*) scope="e2e" ;;
            tests/integration/*) scope="integration" ;;
            tests/unit/*) scope="test" ;;
            docs/*) scope="docs" ;;
            *.md) scope="docs" ;;
            package.json) scope="deps" ;;
            .github/*) scope="ci" ;;
            docker/*) scope="build" ;;
            migrations/*) scope="db" ;;
            *) scope="feature" ;;
        esac
        
        if [ -n "$scope" ]; then
            break
        fi
    done <<< "$changed_files"
    
    # Fallback to feature if no specific scope detected
    [ -z "$scope" ] && scope="feature"
    
    echo "$scope"
}

# Extract feature name from current context
extract_feature_name() {
    local branch_name
    local feature_name
    local changed_files
    
    branch_name=$(git rev-parse --abbrev-ref HEAD)
    changed_files=$(git diff --cached --name-only | head -1)
    
    # Extract feature name from branch name patterns
    if [[ "$branch_name" =~ ^feature/(.+)$ ]]; then
        feature_name=$(echo "${BASH_REMATCH[1]}" | sed 's/-/ /g')
    elif [[ "$branch_name" =~ ^([a-z-]+)-([0-9]+)-(.+)$ ]]; then
        feature_name=$(echo "${BASH_REMATCH[3]}" | sed 's/-/ /g')
    elif [[ "$changed_files" =~ test.*auth ]]; then
        feature_name="user authentication"
    elif [[ "$changed_files" =~ test.*login ]]; then
        feature_name="user login"
    else
        # Simple fallback based on changed files
        feature_name=$(basename "$changed_files" .js | sed 's/[_-]/ /g' | sed 's/test //')
        [ -z "$feature_name" ] && feature_name="current feature"
    fi
    
    echo "$feature_name"
}

# Generate TDD-aware commit message
generate_tdd_commit_message() {
    local phase="$1"
    local scope="$2"
    local feature="$3"
    local test_results="$4"
    
    local commit_type
    local commit_message
    local commit_body
    
    case "$phase" in
        "RED")
            commit_type="test"
            commit_message="add failing test for $feature"
            commit_body="- Test written for expected behavior
- Follows TDD RED phase discipline
- Validates acceptance criteria requirements
- Test properly isolated and focused"
            ;;
        "GREEN")
            commit_type="feat"
            commit_message="implement $feature to pass tests"
            commit_body="- Minimal implementation to pass tests
- All tests now passing
- Maintains code quality standards
- Addresses specific test requirements"
            ;;
        "REFACTOR")
            commit_type="refactor"
            commit_message="improve $feature while maintaining tests"
            commit_body="- Code quality improvements applied
- All tests remain passing
- Enhanced maintainability and performance
- No behavioral changes to functionality"
            ;;
        *)
            commit_type="chore"
            commit_message="update $feature implementation"
            commit_body="- Implementation updates
- Test status: $(echo "$test_results" | grep -E "(PASS|FAIL|ERROR)" | head -1 || echo "Unknown")
- Code quality maintained"
            ;;
    esac
    
    # Generate full commit message
    cat << EOF
$commit_type($scope): $commit_message

$commit_body

TDD Phase: $phase
Coverage: $(get_coverage_info)
AC: $(get_acceptance_criteria_refs)

🤖 Generated with Agent Toolkit TDD Automation

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
}

# Get coverage information
get_coverage_info() {
    local coverage_info
    
    # Use detected package manager for coverage
    if [ -f "package.json" ]; then
        # Detect package manager
        local pm=""
        if [ -f "bun.lockb" ]; then
            pm="bun"
        elif [ -f "pnpm-lock.yaml" ]; then
            pm="pnpm"
        elif [ -f "yarn.lock" ]; then
            pm="yarn"
        elif [ -f "package-lock.json" ]; then
            pm="npm"
        else
            pm="bun"  # Default fallback
        fi
        
        # Try package manager specific coverage
        if [ "$pm" = "bun" ] && command -v bun &> /dev/null; then
            coverage_info=$(bun test --coverage 2>/dev/null | grep -o "[0-9]*%" | head -1 || echo "N/A")
        elif command -v nyc &> /dev/null; then
            coverage_info=$(nyc report --reporter=text-summary 2>/dev/null | grep "Lines" | awk '{print $3}' || echo "N/A")
        else
            coverage_info="N/A"
        fi
    elif command -v pytest &> /dev/null; then
        coverage_info=$(pytest --cov-report=term-missing --cov=. -q 2>/dev/null | grep "TOTAL" | awk '{print $4}' || echo "N/A")
    elif command -v go &> /dev/null; then
        coverage_info=$(go test -cover ./... 2>/dev/null | grep "coverage:" | tail -1 | awk '{print $5}' || echo "N/A")
    else
        coverage_info="N/A"
    fi
    
    echo "$coverage_info"
}

# Get acceptance criteria references
get_acceptance_criteria_refs() {
    local ac_refs
    
    # Search for AC references in recent commits and files
    ac_refs=$(git log --oneline -10 | grep -o "AC: [A-Z0-9-]*" | head -3 | tr '\n' ' ' || echo "")
    
    # If no AC refs found, try to extract from feature files
    if [ -z "$ac_refs" ]; then
        ac_refs=$(find . -name "*.feature.yaml" -o -name "*.feature.yml" 2>/dev/null | xargs grep -l "acceptance_criteria" | head -1 | xargs grep -o "AC[0-9]*" 2>/dev/null | head -3 | tr '\n' ' ' || echo "")
    fi
    
    [ -z "$ac_refs" ] && ac_refs="N/A"
    
    echo "$ac_refs"
}

# Validate commit quality
validate_commit_quality() {
    local commit_msg="$1"
    local errors=()
    
    # Check commit message format
    if [[ ! "$commit_msg" =~ ^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)\([a-z-]+\):.+ ]]; then
        errors+=("Commit message must follow conventional commit format")
    fi
    
    # Check subject line length
    subject_line=$(echo "$commit_msg" | head -1)
    if [ ${#subject_line} -gt 50 ]; then
        errors+=("Subject line must be under 50 characters")
    fi
    
    # Check for tests passing (if not in RED phase)
    if [ "$phase" != "RED" ]; then
        local test_passed=false
        
        if [ -f "package.json" ]; then
            # Use detected package manager
            local pm=""
            if [ -f "bun.lockb" ]; then pm="bun"
            elif [ -f "pnpm-lock.yaml" ]; then pm="pnpm"
            elif [ -f "yarn.lock" ]; then pm="yarn"
            elif [ -f "package-lock.json" ]; then pm="npm"
            else pm="bun"
            fi
            
            if [ "$pm" = "bun" ] && command -v bun &>/dev/null; then
                bun test &>/dev/null && test_passed=true
            elif [ "$pm" = "pnpm" ] && command -v pnpm &>/dev/null; then
                pnpm test &>/dev/null && test_passed=true
            elif [ "$pm" = "yarn" ] && command -v yarn &>/dev/null; then
                yarn test &>/dev/null && test_passed=true
            elif [ "$pm" = "npm" ] && command -v npm &>/dev/null; then
                npm test &>/dev/null && test_passed=true
            fi
        elif command -v pytest &>/dev/null; then
            pytest &>/dev/null && test_passed=true
        elif command -v go &>/dev/null; then
            go test ./... &>/dev/null && test_passed=true
        fi
        
        if [ "$test_passed" = false ]; then
            errors+=("Tests must be passing for non-RED phase commits")
        fi
    fi
    
    # Report errors
    if [ ${#errors[@]} -gt 0 ]; then
        log "❌ Commit quality validation failed:"
        for error in "${errors[@]}"; do
            log "  - $error"
        done
        return 1
    fi
    
    log "✅ Commit quality validation passed"
    return 0
}

# Update TDD cycle state
update_tdd_state() {
    local phase="$1"
    local feature="$2"
    local scope="$3"
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    
    # Update state files
    echo "$phase" > "$STATE_DIR/tdd_cycle_state"
    echo "$feature" > "$STATE_DIR/current_feature"
    echo "$timestamp|$phase|$scope|$feature" >> "$STATE_DIR/commit_history"
    
    # Generate TDD cycle report
    generate_tdd_cycle_report "$phase" "$feature" "$scope"
}

# Generate TDD cycle report
generate_tdd_cycle_report() {
    local phase="$1"
    local feature="$2"
    local scope="$3"
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    local coverage=$(get_coverage_info)
    local test_count=$(find . -name "*.test.*" -o -name "*.spec.*" | wc -l)
    
    cat << EOF > "$STATE_DIR/tdd_cycle_report_$timestamp.md"
# TDD Cycle Report - $feature

## Cycle Summary
- **Phase**: $phase
- **Scope**: $scope
- **Timestamp**: $timestamp
- **Coverage**: $coverage
- **Test Count**: $test_count

## Phase Details
$(case "$phase" in
    "RED")
        echo "- 🔴 RED Phase: New failing test written"
        echo "- 🎯 Test validates expected behavior"
        echo "- 📋 Follows acceptance criteria requirements"
        ;;
    "GREEN")
        echo "- 🟢 GREEN Phase: Minimal implementation added"
        echo "- 🧪 All tests now passing"
        echo "- 📊 Code quality maintained"
        ;;
    "REFACTOR")
        echo "- 🏗️ REFACTOR Phase: Code quality improvements"
        echo "- 🧪 All tests remain passing"
        echo "- 📈 Enhanced maintainability"
        ;;
esac)

## Test Results
$(cat "$STATE_DIR/test_results" 2>/dev/null | tail -10)

## Files Changed
$(git diff --cached --name-only | head -10)

## Next Steps
$(case "$phase" in
    "RED")
        echo "- Implement minimal code to make test pass"
        echo "- Focus on single responsibility"
        echo "- Avoid over-implementation"
        ;;
    "GREEN")
        echo "- Review code for refactoring opportunities"
        echo "- Consider extracting methods/functions"
        echo "- Optimize for readability and performance"
        ;;
    "REFACTOR")
        echo "- Consider next feature or acceptance criteria"
        echo "- Review overall architecture"
        echo "- Plan next TDD cycle"
        ;;
esac)

---
*Generated by Agent Toolkit TDD Automation*
EOF
}

# Check if TDD-specific flags are present
is_tdd_context() {
    local args="$1"
    
    # Only activate for TDD-specific flags
    if [[ "$args" =~ (--tdd|--red|--green|--refactor|--tdd-cycle|--auto-commit) ]]; then
        return 0
    fi
    
    return 1
}

# Main execution function
main() {
    local tool_name="${1:-unknown}"
    local args="${2:-}"
    
    log "TDD Automation Hook activated"
    log "Tool: $tool_name, Args: $args"
    
    # Check if this is a TDD context
    if ! is_tdd_context "$args"; then
        log "Not a TDD context, skipping TDD automation"
        exit 0
    fi
    
    # Initialize state
    init_state
    
    # Only proceed if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log "⚠️ Not in a git repository, skipping TDD automation"
        exit 0
    fi
    
    # Check if there are staged changes
    if ! git diff --cached --quiet; then
        log "📝 Staged changes detected, analyzing TDD context"
        
        # Detect TDD phase and context
        local phase=$(detect_tdd_phase)
        local scope=$(detect_scope)
        local feature=$(extract_feature_name)
        
        log "🔍 TDD Analysis:"
        log "  Phase: $phase"
        log "  Scope: $scope"
        log "  Feature: $feature"
        
        # Generate commit message
        local test_results=$(cat "$STATE_DIR/test_results" 2>/dev/null || echo "")
        local commit_msg=$(generate_tdd_commit_message "$phase" "$scope" "$feature" "$test_results")
        
        log "📝 Generated commit message:"
        log "$commit_msg"
        
        # Validate commit quality
        if validate_commit_quality "$commit_msg"; then
            # Create commit
            echo "$commit_msg" > "$STATE_DIR/commit_message"
            
            # Update TDD state
            update_tdd_state "$phase" "$feature" "$scope"
            
            # Auto-commit if enabled
            if [ "${AUTO_COMMIT:-false}" = "true" ]; then
                git commit -F "$STATE_DIR/commit_message"
                log "✅ Auto-commit completed"
            else
                log "💾 Commit message saved to $STATE_DIR/commit_message"
                log "🔧 To commit: git commit -F $STATE_DIR/commit_message"
            fi
            
            # Generate cycle report
            log "📊 TDD cycle report generated"
            
        else
            log "❌ Commit quality validation failed"
            exit 1
        fi
    else
        log "ℹ️ No staged changes detected"
    fi
    
    log "✅ TDD Automation Hook completed"
}

# Execute main function with all arguments
main "$@"