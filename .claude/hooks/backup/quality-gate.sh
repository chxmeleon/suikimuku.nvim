#!/bin/bash
# quality-gate.sh - Automated quality gates for code changes
# Hook: PostToolUse - Runs quality checks after Write/Edit/MultiEdit operations

set -euo pipefail

# Configuration
QUALITY_LOG=".claude/sessions/quality.log"
QUALITY_CONFIG=".claude/quality-config.json"

# Hook context
TOOL_NAME="${CLAUDE_TOOL_NAME:-unknown}"
TOOL_RESULT="${CLAUDE_TOOL_RESULT:-}"
FILE_PATH="${CLAUDE_FILE_PATH:-}"

# Ensure log directory exists
mkdir -p "$(dirname "$QUALITY_LOG")"

# Log function
log() {
    echo "[$(date '+%H:%M:%S')] Quality Gate → $1" >> "$QUALITY_LOG"
}

# Initialize quality configuration if not exists
init_quality_config() {
    if [[ ! -f "$QUALITY_CONFIG" ]]; then
        cat > "$QUALITY_CONFIG" << 'EOF'
{
  "enabled": true,
  "auto_format": true,
  "auto_lint": true,
  "auto_test": false,
  "coverage_threshold": 80,
  "formatters": {
    "javascript": "prettier --write",
    "typescript": "prettier --write",
    "python": "black",
    "go": "gofmt -w",
    "rust": "rustfmt"
  },
  "linters": {
    "javascript": "eslint",
    "typescript": "tsc --noEmit && eslint",
    "python": "flake8",
    "go": "golint",
    "rust": "cargo clippy"
  },
  "test_commands": {
    "javascript": "{{package_manager}} test",
    "typescript": "{{package_manager}} test",
    "python": "pytest",
    "go": "go test ./...",
    "rust": "cargo test"
  },
  "package_manager_detection": {
    "enabled": true,
    "priority": ["bun", "pnpm", "yarn", "npm"],
    "fallback": "bun"
  }
}
EOF
        log "Initialized quality configuration"
    fi
}

# Detect file language based on extension
detect_language() {
    local file="$1"
    local ext="${file##*.}"
    
    case "$ext" in
        "js"|"jsx"|"mjs") echo "javascript" ;;
        "ts"|"tsx") echo "typescript" ;;
        "py") echo "python" ;;
        "go") echo "go" ;;
        "rs") echo "rust" ;;
        "md") echo "markdown" ;;
        "yml"|"yaml") echo "yaml" ;;
        "json") echo "json" ;;
        *) echo "unknown" ;;
    esac
}

# Check if tool/command is available
has_command() {
    command -v "$1" >/dev/null 2>&1
}

# Get configuration value
get_config() {
    local key="$1"
    if has_command jq && [[ -f "$QUALITY_CONFIG" ]]; then
        jq -r ".$key // empty" "$QUALITY_CONFIG" 2>/dev/null || echo ""
    fi
}

# Detect package manager using Agent Toolkit pattern
detect_package_manager() {
    # Check for lockfiles in priority order (bun -> pnpm -> yarn -> npm)
    if [[ -f "bun.lockb" ]]; then
        echo "bun"
    elif [[ -f "pnpm-lock.yaml" ]]; then
        echo "pnpm"
    elif [[ -f "yarn.lock" ]]; then
        echo "yarn"
    elif [[ -f "package-lock.json" ]]; then
        echo "npm"
    else
        # Check package.json for packageManager field
        if [[ -f "package.json" ]] && has_command jq; then
            local pm_field=$(jq -r '.packageManager // empty' package.json 2>/dev/null)
            if [[ -n "$pm_field" ]]; then
                echo "$pm_field" | cut -d'@' -f1
            else
                # Fallback to bun as modern default
                echo "bun"
            fi
        else
            echo "bun"
        fi
    fi
}

# Get package manager command with fallback
get_package_manager_command() {
    local pm_type="$1"
    local command_type="$2"  # test, install, run, etc.
    
    case "$pm_type" in
        "bun")
            case "$command_type" in
                "test") echo "bun test" ;;
                "install") echo "bun install" ;;
                "run") echo "bun run" ;;
                *) echo "bun $command_type" ;;
            esac
            ;;
        "pnpm")
            case "$command_type" in
                "test") echo "pnpm test" ;;
                "install") echo "pnpm install" ;;
                "run") echo "pnpm run" ;;
                *) echo "pnpm $command_type" ;;
            esac
            ;;
        "yarn")
            case "$command_type" in
                "test") echo "yarn test" ;;
                "install") echo "yarn install" ;;
                "run") echo "yarn run" ;;
                *) echo "yarn $command_type" ;;
            esac
            ;;
        "npm")
            case "$command_type" in
                "test") echo "npm test" ;;
                "install") echo "npm install" ;;
                "run") echo "npm run" ;;
                *) echo "npm run $command_type" ;;
            esac
            ;;
        *)
            # Fallback to npm for unknown package managers
            echo "npm $command_type"
            ;;
    esac
}

# Run formatter for file
run_formatter() {
    local file="$1"
    local language="$2"
    
    if [[ "$(get_config "auto_format")" != "true" ]]; then
        return 0
    fi
    
    local formatter=$(get_config "formatters.$language")
    if [[ -z "$formatter" ]]; then
        log "No formatter configured for $language"
        return 0
    fi
    
    # Extract command name (first word)
    local cmd=$(echo "$formatter" | awk '{print $1}')
    
    if ! has_command "$cmd"; then
        log "Formatter $cmd not available for $language"
        return 0
    fi
    
    log "Running formatter for $file ($language): $formatter"
    
    # Run formatter and capture result
    if eval "$formatter \"$file\"" 2>/dev/null; then
        log "✓ Formatted $file successfully"
        return 0
    else
        log "✗ Formatting failed for $file"
        return 1
    fi
}

# Run linter for file
run_linter() {
    local file="$1"
    local language="$2"
    
    if [[ "$(get_config "auto_lint")" != "true" ]]; then
        return 0
    fi
    
    local linter=$(get_config "linters.$language")
    if [[ -z "$linter" ]]; then
        log "No linter configured for $language"
        return 0
    fi
    
    local cmd=$(echo "$linter" | awk '{print $1}')
    
    if ! has_command "$cmd"; then
        log "Linter $cmd not available for $language"
        return 0
    fi
    
    log "Running linter for $file ($language): $linter"
    
    # Run linter and capture output
    local lint_output
    if lint_output=$(eval "$linter \"$file\"" 2>&1); then
        log "✓ Linting passed for $file"
        return 0
    else
        log "⚠ Linting issues found in $file:"
        echo "$lint_output" | head -10 >> "$QUALITY_LOG"
        return 1
    fi
}

# Run tests related to file changes
run_tests() {
    local file="$1"
    local language="$2"
    
    if [[ "$(get_config "auto_test")" != "true" ]]; then
        return 0
    fi
    
    # Get base test command template and replace with detected package manager
    local test_cmd_template=$(get_config "test_commands.$language")
    if [[ -z "$test_cmd_template" ]]; then
        log "No test command configured for $language"
        return 0
    fi
    
    # For JavaScript/TypeScript, use detected package manager
    local test_cmd="$test_cmd_template"
    if [[ "$language" == "javascript" || "$language" == "typescript" ]]; then
        local detected_pm=$(detect_package_manager)
        local pm_test_cmd=$(get_package_manager_command "$detected_pm" "test")
        test_cmd="$pm_test_cmd"
        log "Using detected package manager '$detected_pm' for testing"
    fi
    
    local cmd=$(echo "$test_cmd" | awk '{print $1}')
    
    if ! has_command "$cmd"; then
        log "Test command $cmd not available for $language"
        return 0
    fi
    
    # Check if this is a test file itself
    if echo "$file" | grep -q -E "(test|spec)"; then
        log "Running tests for test file changes: $test_cmd"
        
        if eval "$test_cmd" >/dev/null 2>&1; then
            log "✓ Tests passed"
            return 0
        else
            log "✗ Tests failed"
            return 1
        fi
    fi
    
    return 0
}

# Check test coverage
check_coverage() {
    local language="$1"
    local threshold=$(get_config "coverage_threshold")
    
    if [[ -z "$threshold" ]] || [[ "$threshold" == "null" ]]; then
        return 0
    fi
    
    case "$language" in
        "javascript"|"typescript")
            local detected_pm=$(detect_package_manager)
            local pm_test_cmd=$(get_package_manager_command "$detected_pm" "test")
            
            # Try coverage with detected package manager
            if [[ "$detected_pm" == "bun" ]] && has_command "bun"; then
                local coverage=$(bun test --coverage 2>/dev/null | grep -o "[0-9]*%" | head -1 | tr -d '%' || echo "0")
                if (( $(echo "$coverage >= $threshold" | bc -l 2>/dev/null || echo "0") )); then
                    log "✓ Coverage $coverage% meets threshold $threshold% (bun)"
                else
                    log "⚠ Coverage $coverage% below threshold $threshold% (bun)"
                fi
            elif has_command "nyc"; then
                local coverage=$(nyc --reporter=json $pm_test_cmd 2>/dev/null | jq -r '.total.lines.pct // 0' 2>/dev/null || echo "0")
                if (( $(echo "$coverage >= $threshold" | bc -l 2>/dev/null || echo "0") )); then
                    log "✓ Coverage $coverage% meets threshold $threshold% ($detected_pm)"
                else
                    log "⚠ Coverage $coverage% below threshold $threshold% ($detected_pm)"
                fi
            else
                log "⚠ No coverage tool available for $language with $detected_pm"
            fi
            ;;
        "python")
            if has_command "coverage"; then
                local coverage=$(coverage report --format=json 2>/dev/null | jq -r '.totals.percent_covered // 0' 2>/dev/null || echo "0")
                if (( $(echo "$coverage >= $threshold" | bc -l 2>/dev/null || echo "0") )); then
                    log "✓ Coverage $coverage% meets threshold $threshold%"
                else
                    log "⚠ Coverage $coverage% below threshold $threshold%"
                fi
            fi
            ;;
    esac
}

# Validate specific file types
validate_file_type() {
    local file="$1"
    local language="$2"
    
    case "$language" in
        "json")
            if has_command jq; then
                if jq empty "$file" 2>/dev/null; then
                    log "✓ Valid JSON: $file"
                else
                    log "✗ Invalid JSON: $file"
                    return 1
                fi
            fi
            ;;
        "yaml")
            if has_command "yq"; then
                if yq eval . "$file" >/dev/null 2>&1; then
                    log "✓ Valid YAML: $file"
                else
                    log "✗ Invalid YAML: $file"
                    return 1
                fi
            elif has_command "python3"; then
                if python3 -c "import yaml; yaml.safe_load(open('$file'))" 2>/dev/null; then
                    log "✓ Valid YAML: $file"
                else
                    log "✗ Invalid YAML: $file"
                    return 1
                fi
            fi
            ;;
        "markdown")
            # Basic markdown validation
            if [[ -f "$file" ]]; then
                log "✓ Markdown file exists: $file"
            fi
            ;;
    esac
    
    return 0
}

# Generate quality report
generate_quality_report() {
    local file="$1"
    local language="$2"
    local status="$3"
    
    local report_file=".claude/sessions/quality-report.json"
    local timestamp=$(date -Iseconds)
    
    # Create or update quality report
    if [[ ! -f "$report_file" ]]; then
        echo '{"files": {}, "summary": {}}' > "$report_file"
    fi
    
    if has_command jq; then
        jq --arg file "$file" \
           --arg lang "$language" \
           --arg status "$status" \
           --arg time "$timestamp" \
           '.files[$file] = {
             "language": $lang,
             "status": $status,
             "timestamp": $time,
             "checks": {
               "formatted": true,
               "linted": true,
               "tested": false
             }
           } | 
           .summary.last_check = $time' \
           "$report_file" > "$report_file.tmp" && \
        mv "$report_file.tmp" "$report_file"
    fi
}

# Process file changes
process_file_changes() {
    # Extract file paths from tool result
    local files_changed=()
    
    # Parse different tool result formats
    case "$TOOL_NAME" in
        "Write")
            if [[ -n "$FILE_PATH" ]]; then
                files_changed+=("$FILE_PATH")
            fi
            ;;
        "Edit"|"MultiEdit")
            # Extract file path from result
            local file_path=$(echo "$TOOL_RESULT" | grep -o "File.*updated\|has been updated" | head -1 || echo "")
            if [[ -n "$file_path" ]] && [[ -n "$FILE_PATH" ]]; then
                files_changed+=("$FILE_PATH")
            fi
            ;;
    esac
    
    # Process each changed file
    for file in "${files_changed[@]}"; do
        if [[ ! -f "$file" ]]; then
            continue
        fi
        
        local language=$(detect_language "$file")
        local overall_status="passed"
        
        log "Processing file: $file (language: $language)"
        
        # Run quality checks
        if ! validate_file_type "$file" "$language"; then
            overall_status="failed"
        fi
        
        if ! run_formatter "$file" "$language"; then
            overall_status="warning"
        fi
        
        if ! run_linter "$file" "$language"; then
            overall_status="warning"
        fi
        
        if ! run_tests "$file" "$language"; then
            overall_status="failed"
        fi
        
        check_coverage "$language"
        
        generate_quality_report "$file" "$language" "$overall_status"
        
        log "Completed quality checks for $file: $overall_status"
    done
}

# Main execution
main() {
    init_quality_config
    
    # Only process code modification tools
    case "$TOOL_NAME" in
        "Write"|"Edit"|"MultiEdit")
            if [[ "$(get_config "enabled")" == "true" ]]; then
                log "Quality gate triggered by $TOOL_NAME"
                process_file_changes
                log "Quality gate completed"
            fi
            ;;
        *)
            # Silent for other tools
            ;;
    esac
}

# Execute main function
main "$@"