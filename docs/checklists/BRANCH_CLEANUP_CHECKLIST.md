# Branch Cleanup Checklist

**Practical Checklist for Branch Cleanup Sessions**

Use this checklist each time you perform a branch cleanup session. Copy this template to track your progress and document decisions.

> **📖 Reference**: For detailed procedures and guidelines, see [Branch Cleanup Process](../BRANCH_CLEANUP_PROCESS.md)

---

## Cleanup Session Information

**Date**: ___________  
**Performed By**: ___________  
**Issue/PR Reference**: ___________

---

## Pre-Cleanup Preparation

### 1. Environment Setup
- [ ] Repository is up to date: `git fetch --all --prune`
- [ ] On main branch: `git checkout main`
- [ ] Main branch is current: `git pull origin main`
- [ ] Working directory is clean: `git status`

### 2. Generate Branch Reports
- [ ] List all local branches with dates:
  ```bash
  git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short) %(upstream:track)'
  ```
- [ ] List all remote branches with dates:
  ```bash
  git for-each-ref --sort=-committerdate refs/remotes/origin/ --format='%(committerdate:short) %(refname:short)'
  ```
- [ ] Identify branches older than threshold (30/60/90 days)
- [ ] Count total branches: `git branch -a | wc -l`

### 3. Create Tracking Document
- [ ] Open issue using [Branch Cleanup Template](.github/ISSUE_TEMPLATE/branch-cleanup.md)
- [ ] Or create local tracking file for this session
- [ ] List all candidate branches for review

---

## Branch Analysis

For each candidate branch, complete this section:

### Branch: `________________________`

#### Basic Information
- [ ] Last commit date: ___________
- [ ] Number of commits: ___________
- [ ] Author(s): ___________
- [ ] Purpose/description: ___________

#### PR Status Check
- [ ] Has associated PR: Yes / No / Not Found
- [ ] PR Number: #___________
- [ ] PR Status: Open / Closed / Merged / N/A
- [ ] PR merged date: ___________

#### Merge Status
- [ ] Run: `git branch --merged main | grep branch-name`
- [ ] Branch is fully merged: Yes / No
- [ ] Run: `git log main..branch-name --oneline`
- [ ] Unique commits count: ___________
- [ ] Unique commits need preservation: Yes / No

#### Decision
- [ ] **Delete**: Fully merged, no unique work
- [ ] **Keep**: Active development or unique unmerged work
- [ ] **Archive**: Create backup before deleting
- [ ] **Question**: Needs team input

**Reason for decision**: _________________________________

---

## Deletion Checklist

### Safety Verification

Before deleting each branch:

- [ ] Verified merge status (fully merged or work not needed)
- [ ] Confirmed associated PR is closed/merged (or no PR exists)
- [ ] Checked for unique commits
- [ ] Reviewed with team if uncertain
- [ ] Documented decision

### Backup Procedure (If Needed)

For branches with questionable status:

- [ ] Create backup tag: `git tag archive/branch-name branch-name`
- [ ] Or create backup branch: `git branch backup/branch-name branch-name`
- [ ] Push backup: `git push origin backup/branch-name` or `git push origin archive/branch-name`
- [ ] Document backup location

### Delete Branch

- [ ] Delete local branch:
  ```bash
  git branch -d branch-name  # Safe delete
  # or
  git branch -D branch-name  # Force delete
  ```
- [ ] Delete remote branch:
  ```bash
  git push origin --delete branch-name
  ```
- [ ] Or use GitHub UI: Branches → Find branch → Click trash icon

### Post-Deletion Verification

- [ ] Confirm local deletion: `git branch | grep branch-name`
- [ ] Confirm remote deletion: `git branch -r | grep branch-name`
- [ ] Run: `git fetch --prune` to clean up remote refs
- [ ] Verify CI/CD not affected

---

## Branches Deleted (This Session)

| Branch Name | PR # | Merge Status | Reason | Backup Created |
|------------|------|--------------|--------|----------------|
| | | | | |
| | | | | |
| | | | | |
| | | | | |
| | | | | |

---

## Branches Preserved (This Session)

| Branch Name | PR # | Status | Reason to Keep |
|------------|------|--------|----------------|
| | | | |
| | | | |
| | | | |

---

## Team Communication

### Pre-Cleanup Announcement
- [ ] Posted list of branches to delete in team chat/Slack
- [ ] Waited 2-3 days for team feedback
- [ ] Addressed all concerns and questions
- [ ] Received approval to proceed

### Post-Cleanup Notification
- [ ] Notified team of completed cleanup
- [ ] Documented branches deleted
- [ ] Posted summary in team chat/Slack
- [ ] Updated relevant PRs/issues with comments

### Communication Template

```markdown
## Branch Cleanup Completed - [Date]

**Summary:**
- Branches reviewed: X
- Branches deleted: Y
- Branches preserved: Z

**Deleted branches:**
- branch-name-1 (PR #X, merged [date])
- branch-name-2 (PR #Y, merged [date])

**Preserved branches:**
- branch-name-3 (active PR #Z)
- branch-name-4 (contains unique work)

**Notes:**
[Any important observations or concerns]
```

---

## Final Steps

### Documentation
- [ ] Updated cleanup log/issue with results
- [ ] Documented any lessons learned
- [ ] Noted any branches requiring follow-up
- [ ] Saved this checklist for reference

### Repository Status
- [ ] Total branches after cleanup: ___________
- [ ] Reduction in branch count: ___________
- [ ] No broken workflows or references
- [ ] CI/CD operating normally

### Schedule Next Cleanup
- [ ] Scheduled next cleanup session: ___________
- [ ] Created calendar reminder
- [ ] Assigned responsible person: ___________

---

## Notes and Observations

**Issues Encountered:**


**Improvements for Next Time:**


**Questions for Team:**


**Action Items:**
- [ ] 
- [ ] 
- [ ] 

---

## Verification Commands Reference

Quick reference for common verification commands:

```bash
# List branches by age
git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'

# Check if branch is merged
git branch --merged main | grep branch-name

# Count unique commits
git log main..branch-name --oneline | wc -l

# See unique commits
git log main..branch-name --oneline

# Check PR status (requires GitHub CLI)
gh pr list --state all --search "branch-name"

# Fetch and prune
git fetch --all --prune

# List all local branches
git branch

# List all remote branches
git branch -r

# Delete local branch (safe)
git branch -d branch-name

# Delete remote branch
git push origin --delete branch-name
```

---

## Resources

- [Branch Cleanup Process](../BRANCH_CLEANUP_PROCESS.md) - Full documentation
- [CONTRIBUTING.md](../../CONTRIBUTING.md) - Branch management guidelines
- [Branch Cleanup Issue Template](../../.github/ISSUE_TEMPLATE/branch-cleanup.md) - GitHub template

---

**Template Version**: 1.0  
**Last Updated**: January 2026  
**Next Review**: Quarterly or as needed
