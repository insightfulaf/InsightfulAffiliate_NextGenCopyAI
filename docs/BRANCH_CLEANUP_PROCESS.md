# Branch Cleanup Process

**Comprehensive Guide to Branch Management and Cleanup**

This document provides guidelines and processes for maintaining a clean branch structure in the repository. Regular branch cleanup helps maintain repository hygiene, reduces confusion, and makes it easier to understand the current state of development work.

---

## Table of Contents

1. [Introduction](#introduction)
2. [Current Branch Status](#current-branch-status)
3. [Cleanup Criteria](#cleanup-criteria)
4. [Cleanup Process](#cleanup-process)
5. [Safety Guidelines](#safety-guidelines)
6. [Maintenance Schedule](#maintenance-schedule)
7. [Automation Opportunities](#automation-opportunities)
8. [Resources](#resources)

---

## Introduction

### Why Branch Hygiene Matters

Maintaining clean branch hygiene is essential for several reasons:

- **Clarity**: A clean branch list makes it easier to see what work is currently in progress
- **Performance**: Fewer stale branches can improve repository operations and reduce clutter
- **Security**: Old branches may contain outdated dependencies or security issues
- **Team Coordination**: Clear branch status helps team members understand what work is active
- **Reduced Confusion**: Eliminates questions about which branches are still relevant

### Regular Cleanup Benefits

- Easier to identify active development work
- Reduced risk of accidentally working on stale branches
- Clearer repository history
- Improved CI/CD performance (fewer branches to track)
- Better understanding of project status

---

## Current Branch Status

**As of January 2026**

The repository has the following branch structure:

### Main Branch

- **`main`** - Base branch (commit: `15ac84dd00c89ae1e3f6f02ff06c33d5d6903a19`)
  - Date: January 20, 2026
  - Status: Active, up-to-date
  - Purpose: Production-ready code

### Historical Branches (Pre-January 2026)

The following branches predate the January 20, 2026 update to main:

1. **`workflow-consolidation`**
   - Status: Appears merged via PR #3
   - Behind main: Yes
   - Recommendation: Review for deletion after confirming merge

2. **`workflow-consolidation-2`**
   - Status: Duplicate branch
   - Behind main: Yes
   - Recommendation: Candidate for deletion (duplicate work)

3. **`copilot/fix-secrets-usage-errors`**
   - Status: Significantly behind main
   - Behind main: Yes
   - Recommendation: Review for unique commits before deletion

4. **`copilot/setup-copilot-instructions`**
   - Status: 3 weeks behind main
   - Last activity: December 30, 2025
   - Behind main: Yes
   - Recommendation: Review for merge status

### Branch Naming Patterns

The repository uses the following branch naming conventions:

- `feature/*` - New features
- `fix/*` or `bugfix/*` - Bug fixes
- `copilot/*` - Copilot-generated branches
- `workflow/*` - Workflow-related changes
- Direct descriptive names (e.g., `workflow-consolidation`)

---

## Cleanup Criteria

### When to Clean Up a Branch

A branch should be considered for cleanup when it meets **one or more** of these criteria:

#### 1. Fully Merged

- [ ] Branch has been fully merged into `main`
- [ ] All commits from the branch exist in `main`
- [ ] No unique work remains on the branch

**How to check:**
```bash
# Check if branch is fully merged
git branch --merged main
```

#### 2. Associated PR is Closed

- [ ] Pull request has been merged
- [ ] Pull request has been closed without merging (work abandoned)
- [ ] PR description indicates work is complete

**How to check:**
- Review PR history on GitHub
- Check PR status (merged/closed)
- Look for "This branch was merged" message

#### 3. No Unique Commits

- [ ] Branch contains no commits that aren't in `main`
- [ ] All changes have been integrated through other means
- [ ] Branch is effectively redundant

**How to check:**
```bash
# List commits on branch that aren't on main
git log main..branch-name --oneline
```

#### 4. Stale Branches

- [ ] No commits in the last 3 months (or team-defined threshold)
- [ ] No open PR associated with the branch
- [ ] No active development discussion

**How to check:**
```bash
# Show branches with last commit date
git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'
```

### When NOT to Delete a Branch

**Never delete a branch if:**

- ❌ It has an open, active pull request
- ❌ It contains unmerged work that's still needed
- ❌ It's a protected branch (main, develop, etc.)
- ❌ Team members are actively developing on it
- ❌ It serves as a long-term integration branch
- ❌ You haven't verified merge status

---

## Cleanup Process

### Step-by-Step Guide

Follow these steps for safe branch cleanup:

#### Step 1: Identify Stale Branches

**List all branches with dates:**
```bash
# Local branches
git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short) %(upstream:track)'

# Remote branches
git for-each-ref --sort=-committerdate refs/remotes/origin/ --format='%(committerdate:short) %(refname:short)'
```

**Filter by age:**
```bash
# Branches older than 3 months
git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)' | head -20
```

#### Step 2: Check for Open PRs

For each candidate branch:

1. Go to GitHub repository
2. Navigate to Pull Requests
3. Search for the branch name
4. Check PR status (Open/Closed/Merged)

**GitHub CLI method:**
```bash
# If you have gh CLI installed
gh pr list --state all --search "branch-name"
```

#### Step 3: Verify Merge Status

**Check if branch is merged into main:**
```bash
# Is this branch fully merged?
git branch --merged main | grep "branch-name"
```

**Check for unique commits:**
```bash
# Any commits not in main?
git log main..branch-name --oneline

# If output is empty, branch is fully merged
```

**Check merge-base:**
```bash
# Find common ancestor
git merge-base main branch-name

# Compare with branch tip
git rev-parse branch-name
```

#### Step 4: Check for Unique Unmerged Commits

**Review commits not in main:**
```bash
# Detailed view of unique commits
git log main..branch-name --oneline --decorate

# See the diff
git diff main...branch-name
```

**Questions to ask:**
- Does this work still need to be integrated?
- Was this work superseded by other changes?
- Should we extract any commits before deleting?

#### Step 5: Document Decisions

Before deleting, create a record:

```markdown
## Branch Cleanup Log - [Date]

### Branches Reviewed
- branch-name: [Reason for keeping/deleting]

### Branches Deleted
- branch-name: [Reason] - PR #X merged on [date]

### Branches Preserved
- branch-name: [Reason for keeping]
```

Use the [Branch Cleanup Checklist](checklists/BRANCH_CLEANUP_CHECKLIST.md) for structured tracking.

#### Step 6: Safe Deletion Procedure

**Delete local branch:**
```bash
# Safe delete (only if merged)
git branch -d branch-name

# Force delete (if you're sure)
git branch -D branch-name
```

**Delete remote branch:**
```bash
# Delete from GitHub
git push origin --delete branch-name

# Or use GitHub UI: Branches → Click trash icon
```

**Using GitHub CLI:**
```bash
# Delete remote branch
gh api -X DELETE /repos/:owner/:repo/git/refs/heads/branch-name
```

#### Step 7: Verification Steps

After deletion:

1. **Confirm local deletion:**
   ```bash
   git branch | grep branch-name
   # Should return nothing
   ```

2. **Confirm remote deletion:**
   ```bash
   git fetch --prune
   git branch -r | grep branch-name
   # Should return nothing
   ```

3. **Update team:**
   - Post in team chat/Slack
   - Comment on related PRs if needed
   - Update project documentation

4. **Check CI/CD:**
   - Verify no workflows are broken
   - Confirm no references to deleted branches

---

## Safety Guidelines

### Critical Safety Rules

#### Rule 1: Verify Before Deleting

**Always verify:**
- [ ] Branch merge status
- [ ] Associated PR status
- [ ] Unique commit check
- [ ] Team member confirmation (if uncertain)

#### Rule 2: Never Delete Active PRs

**Before deleting:**
- [ ] Check for open PRs
- [ ] Verify PR is merged or closed
- [ ] Get team confirmation if PR is closed without merging

**If PR is open:**
- Contact the PR author
- Ask if work is still active
- Get explicit approval before deletion

#### Rule 3: Check for Unmerged Work

**Questions to answer:**
- Does the branch contain unique commits?
- Are those commits still needed?
- Should we cherry-pick any commits before deleting?

**How to preserve work:**
```bash
# Create backup tag before deleting
git tag archive/branch-name branch-name

# Or create backup branch
git branch backup/branch-name branch-name
```

#### Rule 4: Document All Deletions

**Record:**
- Branch name
- Deletion date
- Reason for deletion
- Associated PR number
- Person who approved/performed deletion

**Use:**
- GitHub issue with [branch cleanup template](.github/ISSUE_TEMPLATE/branch-cleanup.md)
- Team wiki or documentation
- Cleanup checklist

#### Rule 5: Coordinate with Team

**Communication:**
- Announce cleanup plans in advance
- Post list of branches to be deleted
- Give team 2-3 days to review
- Respond to concerns before proceeding

#### Rule 6: Protect Important Branches

**Configure branch protection:**
```bash
# Set up protected branches on GitHub
# Settings → Branches → Add rule
```

**Protect:**
- `main`
- `develop` (if used)
- Long-running release branches
- Integration branches

### Recovery Procedures

If you accidentally delete a branch:

#### Method 1: Reflog (Local Branches)

```bash
# Find the branch commit
git reflog | grep branch-name

# Recreate the branch
git branch branch-name <commit-hash>
```

#### Method 2: Remote Recovery

```bash
# If still on remote
git fetch origin branch-name:branch-name
```

#### Method 3: Tag Recovery

```bash
# If you created a backup tag
git checkout -b branch-name archive/branch-name
```

---

## Maintenance Schedule

### Recommended Cadence

#### Monthly Reviews (Recommended)

**Best for:**
- Active repositories with frequent branches
- Teams with multiple contributors

**Tasks:**
- Review branches older than 30 days
- Clean up merged branches
- Archive completed work

#### Quarterly Reviews (Minimum)

**Best for:**
- Smaller teams
- Repositories with slower change rates

**Tasks:**
- Comprehensive branch audit
- Clean up branches older than 90 days
- Review branch naming conventions
- Update cleanup documentation

### Cleanup Workflow

**Week 1: Preparation**
- [ ] Generate branch report
- [ ] Identify cleanup candidates
- [ ] Post list for team review

**Week 2: Review**
- [ ] Team reviews proposed deletions
- [ ] Resolve questions/concerns
- [ ] Document decisions

**Week 3: Execution**
- [ ] Delete approved branches
- [ ] Verify deletions
- [ ] Update documentation

**Week 4: Follow-up**
- [ ] Confirm no issues
- [ ] Update cleanup log
- [ ] Schedule next review

### Using GitHub Issues

Create a recurring issue using the [Branch Cleanup Template](.github/ISSUE_TEMPLATE/branch-cleanup.md):

1. Open new issue from template
2. Fill in branch list
3. Assign to reviewer
4. Track progress with checkboxes
5. Close when complete

---

## Automation Opportunities

### Current Manual Process

The current cleanup process is manual, which ensures careful review but can be time-consuming.

### Potential Automations

#### 1. Branch Age Reports

**GitHub Actions workflow:**
```yaml
# .github/workflows/branch-report.yml
name: Branch Age Report
on:
  schedule:
    - cron: '0 0 1 * *'  # Monthly
jobs:
  report:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Generate Branch Report
        run: |
          # Script to list old branches
          # Post to issue or PR
```

#### 2. Stale Branch Warnings

**Auto-label old PRs:**
- Add "stale" label after 60 days
- Comment on PR with cleanup reminder
- Second reminder after 90 days

#### 3. Merged Branch Cleanup

**GitHub settings:**
- Enable "Automatically delete head branches" in repo settings
- Automatically cleans up merged PR branches

**To enable:**
1. Go to Settings → General
2. Scroll to "Pull Requests"
3. Check "Automatically delete head branches"

#### 4. CLI Tools

**Custom scripts:**
```bash
# scripts/cleanup-branches.sh
#!/bin/bash
# Interactive branch cleanup tool
# Lists candidates and prompts for confirmation
```

### Recommended First Steps

1. Enable automatic deletion of merged branches
2. Create monthly calendar reminder for reviews
3. Use GitHub issue template for tracking
4. Consider automation after process is established

---

## Resources

### Internal Documentation

- [Branch Cleanup Checklist](checklists/BRANCH_CLEANUP_CHECKLIST.md) - Practical checklist format
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Repository contribution guidelines
- [Branch Cleanup Issue Template](.github/ISSUE_TEMPLATE/branch-cleanup.md) - GitHub issue template

### GitHub Documentation

- [Managing Branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-branches-in-your-repository)
- [Deleting and Restoring Branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-branches-in-your-repository/deleting-and-restoring-branches-in-a-pull-request)
- [About Protected Branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)

### Git Documentation

- [Git Branch Documentation](https://git-scm.com/docs/git-branch)
- [Git Reflog Documentation](https://git-scm.com/docs/git-reflog)

### Best Practices

- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Trunk Based Development](https://trunkbaseddevelopment.com/)

---

## Questions?

If you have questions about branch cleanup:

1. Review this documentation
2. Check the [Branch Cleanup Checklist](checklists/BRANCH_CLEANUP_CHECKLIST.md)
3. Consult [CONTRIBUTING.md](../CONTRIBUTING.md) for branch management guidelines
4. Open an issue using the [Branch Cleanup Template](.github/ISSUE_TEMPLATE/branch-cleanup.md)
5. Contact repository maintainers

---

**Last Updated**: January 2026  
**Review Frequency**: Quarterly or after major cleanups  
**Owner**: Repository Maintainers
