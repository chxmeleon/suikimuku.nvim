---
allowed-tools: [Bash, Read, Write, Glob, Grep, LS]
description: "Complete git workflow automation: add → commit → push"
---

# /git - Complete Git Workflow

## Usage
```
/git [operation] [flags]
```

Automates complete git workflows: `git add .` → `git commit` → `git push`

## Key Flags
- `--auto`: Complete workflow (add → commit → push)
- `--commit`: Generate and execute commits only
- `--conventional`: Conventional commit format
- `--uc`: Ultra-compressed output (default)

## Examples
```bash
/git --auto                    # Complete: add → commit → push
/git --commit --conventional   # Commit only with conventional format
/git status                    # Check repository status
```

## Execution
### Complete Workflow (--auto) - MANDATORY VERIFICATION:
**CRITICAL**: All 7 steps must complete. Stopping at commit without push is **WORKFLOW FAILURE**.

1. **git status** - Check repository state
2. **git add .** - Stage all changes (verify: no "fatal" errors)
3. **Generate message** - Intelligent commit message based on changes
4. **git commit -m "[message]"** - Commit with generated message (verify: commit hash returned)
5. **git push** - Push to remote repository (verify: successful push or "up-to-date")
6. **git status** - Final verification (verify: "up to date with origin/main")
7. **Report success** - Confirm complete workflow: "✓ git → add → commit → push"

### Workflow Completion Checklist
When using `--auto`, the following are **MANDATORY**:
- [ ] **Step 1**: Execute `git add .`
- [ ] **Verify**: No "fatal" errors in add output
- [ ] **Step 2**: Execute `git commit` with conventional message
- [ ] **Verify**: Commit hash generated successfully
- [ ] **Step 3**: Execute `git push`
- [ ] **Verify**: Push succeeded ("up-to-date" or successful push message)
- [ ] **Final**: `git status` shows "up to date with origin/main"

### Commit Only (--commit):
1. **git status** - Analyze current state
2. **Generate message** - Create appropriate commit message  
3. **git commit** - Execute commit safely
4. **Validate state** - Confirm repository consistency

## TDD Commit Patterns

### Red Phase Commits
- **Format**: `test(scope): add failing test for [feature description]`
- **Requirements**: Test must be failing, reference AC ID, use scenario name from feature.yaml
- **Example**: `test(auth): add failing test for user login validation (AC1)`

### Green Phase Commits  
- **Format**: `feat(scope): implement [feature description] to pass tests`
- **Requirements**: All tests passing, minimal implementation, reference test commit
- **Example**: `feat(auth): implement user login validation logic`

### Refactor Phase Commits
- **Format**: `refactor(scope): improve [improvement] while maintaining tests`
- **Requirements**: All tests remain passing, no behavioral changes, single-purpose
- **Example**: `refactor(auth): extract user validation into service layer`

### Tidy First Commits
- **Structural**: `refactor(scope): [structural change] - no behavior change`
- **Behavioral**: `feat(scope): [new functionality]` 
- **Rule**: Never mix structural and behavioral changes in same commit

## Failure Handling & Recovery

### Common Failure Scenarios
- **Git Add Failures**: Large files, permission issues, disk space problems
- **Git Commit Failures**: Empty commits, pre-commit hook failures, message format issues
- **Git Push Failures**: Authentication failures, remote conflicts, network issues, branch protection

### Recovery Procedures
```bash
# Authentication failure recovery
if git push fails with "authentication":
  1. Verify git credentials and SSH key configuration
  2. Re-authenticate if necessary
  3. Retry push operation

# Conflict resolution recovery  
if git push fails with "conflicts":
  1. Execute git pull --rebase
  2. Resolve any merge conflicts
  3. Continue rebase if needed
  4. Retry push operation

# Pre-commit hook failure recovery
if commit fails due to hooks:
  1. Review hook failure messages
  2. Fix code quality issues
  3. Re-add modified files
  4. Retry commit operation
```

### Success Verification Indicators
```bash
# Successful add output (no "fatal" errors)
# Successful commit output
[main abc1234] feat: example commit message
 5 files changed, 123 insertions(+), 45 deletions(-)

# Successful push output
To github.com:user/repo.git
   def5678..abc1234  main -> main

# Final verification
On branch main
Your branch is up to date with 'origin/main'.
nothing to commit, working tree clean
```

## Smart Sub-Agent Integration

### Complexity-Based Activation
- **Simple Operations** (direct tools): `--auto`, `--commit`, basic git commands
- **Complex Operations** (git-specialist sub-agent): `--workflow`, `--coordination`, `--deploy`, conflict resolution
- **Learning Mode** (mentor-specialist): `--teach`, `--guide`, `--explain` flags

### Auto-Activation Triggers
- **git-specialist**: Repository conflicts, multi-branch operations, deployment workflows
- **mentor-specialist**: Teaching flags (`--teach`, `--guide`, `--explain`)
- **Direct execution**: Standard add/commit/push workflows with verification

## Output
- **Default**: `✓ git → add → commit → push (feat: user auth)`
- **Verbose**: Complete git status with operation details, TDD phase detection, and conventional commit format
- **Format**: Git operation results with TDD-aware commit messages and repository status