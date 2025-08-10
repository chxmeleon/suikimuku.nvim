#!/bin/bash
# Agent Toolkit Shell Integration
# Optional shell aliases for maximum efficiency with Claude Code

# ============================================================================
# QUICK COMMAND ALIASES
# ============================================================================

# Single-letter aliases for ultra-fast access
alias ca='claude -p "/alias a"'        # analyze
alias cde='claude -p "/alias d"'       # design (avoid conflict with cd command)
alias cim='claude -p "/alias i"'       # implement (avoid conflict with ci command)
alias cte='claude -p "/alias t"'       # test (avoid conflict with ct command)
alias csh='claude -p "/alias s"'       # ship (avoid conflict with cs command)
alias cgi='claude -p "/alias g"'       # git (avoid conflict with cg command)
alias ctr='claude -p "/alias tr"'      # track
alias ccl='claude -p "/alias cl"'      # cleanup
alias cpa='claude -p "/alias p"'       # pair (avoid conflict with cp command)
alias cco='claude -p "/alias co"'      # coordinate

# ============================================================================
# WORKFLOW ALIASES
# ============================================================================

# Workflow shortcuts
alias c-rapid='claude -p "/alias rapid"'
alias c-atdd='claude -p "/alias atdd"'
alias c-indie='claude -p "/alias indie"'
alias c-tdd='claude -p "/alias tdd-cycle"'
alias c-quality='claude -p "/alias quality-check"'
alias c-fullstack='claude -p "/alias full-stack"'

# ============================================================================
# PERSONA SHORTCUTS
# ============================================================================

alias c-analyst='claude -p "/alias analyst"'
alias c-architect='claude -p "/alias architect"'
alias c-engineer='claude -p "/alias engineer"'
alias c-shipper='claude -p "/alias shipper"'
alias c-navigator='claude -p "/alias navigator"'
alias c-driver='claude -p "/alias driver"'
alias c-orchestrator='claude -p "/alias orchestrator"'
alias c-qa='claude -p "/alias qa"'
alias c-devops='claude -p "/alias devops"'

# ============================================================================
# PRESET MODES
# ============================================================================

alias c-indie-mode='claude -p "/alias indie-mode"'
alias c-enterprise='claude -p "/alias enterprise-mode"'
alias c-learning='claude -p "/alias learning-mode"'
alias c-strict='claude -p "/alias strict-mode"'
alias c-fast='claude -p "/alias fast-mode"'
alias c-collab='claude -p "/alias collab-mode"'
alias c-debug='claude -p "/alias debug-mode"'

# ============================================================================
# SMART DYNAMIC FUNCTION
# ============================================================================

# Intelligent alias resolution with argument passing
function c() {
    case $1 in
        # Short aliases
        a|analyze)          claude -p "/alias a ${@:2}" ;;
        d|design)           claude -p "/alias d ${@:2}" ;;
        i|implement)        claude -p "/alias i ${@:2}" ;;
        t|test)             claude -p "/alias t ${@:2}" ;;
        s|ship)             claude -p "/alias s ${@:2}" ;;
        g|git)              claude -p "/alias g ${@:2}" ;;
        tr|track)           claude -p "/alias tr ${@:2}" ;;
        cl|cleanup)         claude -p "/alias cl ${@:2}" ;;
        p|pair)             claude -p "/alias p ${@:2}" ;;
        co|coordinate)      claude -p "/alias co ${@:2}" ;;
        
        # Workflow aliases
        rapid)              claude -p "/alias rapid ${@:2}" ;;
        atdd)               claude -p "/alias atdd ${@:2}" ;;
        indie)              claude -p "/alias indie ${@:2}" ;;
        tdd-cycle)          claude -p "/alias tdd-cycle ${@:2}" ;;
        quality-check)      claude -p "/alias quality-check ${@:2}" ;;
        full-stack)         claude -p "/alias full-stack ${@:2}" ;;
        
        # Persona shortcuts
        analyst)            claude -p "/alias analyst ${@:2}" ;;
        architect)          claude -p "/alias architect ${@:2}" ;;
        engineer)           claude -p "/alias engineer ${@:2}" ;;
        shipper)            claude -p "/alias shipper ${@:2}" ;;
        navigator)          claude -p "/alias navigator ${@:2}" ;;
        driver)             claude -p "/alias driver ${@:2}" ;;
        orchestrator)       claude -p "/alias orchestrator ${@:2}" ;;
        qa)                 claude -p "/alias qa ${@:2}" ;;
        devops)             claude -p "/alias devops ${@:2}" ;;
        
        # Preset modes
        indie-mode)         claude -p "/alias indie-mode ${@:2}" ;;
        enterprise-mode)    claude -p "/alias enterprise-mode ${@:2}" ;;
        learning-mode)      claude -p "/alias learning-mode ${@:2}" ;;
        strict-mode)        claude -p "/alias strict-mode ${@:2}" ;;
        fast-mode)          claude -p "/alias fast-mode ${@:2}" ;;
        collab-mode)        claude -p "/alias collab-mode ${@:2}" ;;
        debug-mode)         claude -p "/alias debug-mode ${@:2}" ;;
        
        # Utility commands
        list|ls)            claude -p "/alias --list" ;;
        help|h)             claude -p "/alias --help ${@:2}" ;;
        expand|ex)          claude -p "/alias --expand ${@:2}" ;;
        
        # Direct command execution (fallback)
        *)                  claude -p "$@" ;;
    esac
}

# ============================================================================
# COMPLETION FUNCTION
# ============================================================================

# Bash completion for the c function
_c_completion() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local aliases="a analyze d design i implement t test s ship g git tr track cl cleanup p pair co coordinate rapid atdd indie tdd-cycle quality-check full-stack analyst architect engineer shipper navigator driver orchestrator qa devops indie-mode enterprise-mode learning-mode strict-mode fast-mode collab-mode debug-mode list help expand"
    
    COMPREPLY=($(compgen -W "${aliases}" -- ${cur}))
}

# Enable completion for the c function
complete -F _c_completion c

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

# Show all available aliases
function c-aliases() {
    echo "🚀 Agent Toolkit Shell Aliases"
    echo ""
    echo "Short Commands:"
    echo "  c a <args>     → analyze"
    echo "  c d <args>     → design"
    echo "  c i <args>     → implement"
    echo "  c t <args>     → test"
    echo "  c s <args>     → ship"
    echo ""
    echo "Direct Aliases (avoid conflicts):"
    echo "  ca <args>      → analyze"
    echo "  cde <args>     → design"
    echo "  cim <args>     → implement"
    echo "  cte <args>     → test"
    echo "  csh <args>     → ship"
    echo ""
    echo "Workflows:"
    echo "  c rapid <args>     → rapid indie development"
    echo "  c atdd <args>      → full ATDD cycle"
    echo "  c indie <args>     → indie hacker workflow"
    echo ""
    echo "Personas:"
    echo "  c analyst <args>   → analyst persona"
    echo "  c engineer <args>  → engineer persona"
    echo "  c shipper <args>   → indie shipper persona"
    echo ""
    echo "Presets:"
    echo "  c indie-mode <args>     → indie development mode"
    echo "  c learning-mode <args>  → educational mode"
    echo "  c strict-mode <args>    → strict quality mode"
    echo ""
    echo "Utilities:"
    echo "  c list         → show all aliases"
    echo "  c help <alias> → show alias help"
    echo "  c expand <alias> → show expanded command"
}

# Quick setup function
function c-setup() {
    echo "🔧 Setting up Agent Toolkit shell integration..."
    
    # Add to shell profile
    local shell_profile=""
    if [[ "$SHELL" == */bash ]]; then
        shell_profile="$HOME/.bashrc"
    elif [[ "$SHELL" == */zsh ]]; then
        shell_profile="$HOME/.zshrc"
    else
        echo "⚠️  Unknown shell. Please manually add to your shell profile."
        return 1
    fi
    
    echo "# Agent Toolkit Shell Integration" >> "$shell_profile"
    echo "source $(realpath $0)" >> "$shell_profile"
    echo "✅ Added to $shell_profile"
    echo "🔄 Run 'source $shell_profile' or restart your shell to activate"
}

# ============================================================================
# HELP MESSAGE
# ============================================================================

# Show help when script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "🚀 Agent Toolkit Shell Integration"
    echo ""
    echo "Usage:"
    echo "  source $0                 # Load aliases into current shell"
    echo "  bash $0                   # Show this help message"
    echo ""
    echo "Setup:"
    echo "  c-setup                   # Add to shell profile permanently"
    echo "  c-aliases                 # Show all available aliases"
    echo ""
    echo "Examples:"
    echo "  c a user-auth             # Quick analyze (via c function)"
    echo "  ca user-auth              # Quick analyze (direct alias)"
    echo "  c rapid checkout-flow     # Rapid workflow"
    echo "  c indie-mode dashboard    # Indie mode preset"
    echo "  c list                    # Show all aliases"
    echo ""
    echo "For more info, run: c-aliases"
fi