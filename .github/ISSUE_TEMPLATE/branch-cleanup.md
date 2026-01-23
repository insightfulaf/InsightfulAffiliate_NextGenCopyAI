---
name: Branch Cleanup
about: Track and document branch cleanup sessions
title: 'Branch Cleanup - [Month Year]'
labels: maintenance, housekeeping
assignees: ''

---

## Branch Cleanup Session

**Date**: [Insert Date]  
**Performed By**: @[username]  
**Session Type**: [ ] Monthly [ ] Quarterly [ ] Ad-hoc

---

## Overview

This issue tracks the branch cleanup process for [Month Year]. The goal is to maintain repository hygiene by removing stale, merged, and unnecessary branches while preserving active work.

**Reference Documentation**:
- [Branch Cleanup Process](../docs/BRANCH_CLEANUP_PROCESS.md)
- [Branch Cleanup Checklist](../docs/checklists/BRANCH_CLEANUP_CHECKLIST.md)

---

## Pre-Cleanup Summary

**Current Branch Count**:
- Local branches: [X]
- Remote branches: [Y]
- Total: [Z]

**Cleanup Threshold**: Branches older than [30/60/90] days

---

## Branches to Review

List all branches identified for review. Check off as you complete analysis for each.

### Candidate Branches for Deletion

- [ ] **`branch-name-1`**
  - Last commit: [date]
  - PR: #[number] or N/A
  - Status: [Open/Closed/Merged]
  - Reason: [Fully merged / Stale / Duplicate work]
  
- [ ] **`branch-name-2`**
  - Last commit: [date]
  - PR: #[number] or N/A
  - Status: [Open/Closed/Merged]
  - Reason: [Fully merged / Stale / Duplicate work]

- [ ] **`branch-name-3`**
  - Last commit: [date]
  - PR: #[number] or N/A
  - Status: [Open/Closed/Merged]
  - Reason: [Fully merged / Stale / Duplicate work]

### Branches to Preserve

- **`branch-name-X`** - [Reason: Active PR #Y / Contains unique work / etc.]
- **`branch-name-Y`** - [Reason]

---

## Cleanup Steps

### 1. Preparation
- [ ] Updated local repository: `git fetch --all --prune`
- [ ] On main branch: `git checkout main && git pull`
- [ ] Working directory is clean
- [ ] Generated branch reports

### 2. Analysis
- [ ] Identified stale branches (older than threshold)
- [ ] Checked PR status for each branch
- [ ] Verified merge status
- [ ] Documented unique unmerged commits
- [ ] Listed branches in sections above

### 3. Team Review
- [ ] Posted branch list for team review
- [ ] Waited [2-3] days for feedback
- [ ] Addressed all questions and concerns
- [ ] Received approval to proceed

### 4. Backup (If Needed)
- [ ] Created backup tags/branches for questionable cases
- [ ] Documented backup locations

### 5. Deletion
- [ ] Deleted local branches
- [ ] Deleted remote branches
- [ ] Ran `git fetch --prune` to clean up refs

### 6. Verification
- [ ] Confirmed branches are deleted
- [ ] Verified no broken CI/CD workflows
- [ ] Checked no broken references in documentation

### 7. Documentation
- [ ] Updated this issue with results
- [ ] Notified team of completed cleanup
- [ ] Documented lessons learned

---

## Actions Taken

### Branches Deleted

| Branch Name | PR # | Merge Status | Deletion Date | Reason |
|------------|------|--------------|---------------|--------|
| | | | | |
| | | | | |
| | | | | |

**Total branches deleted**: [X]

### Branches Preserved

| Branch Name | PR # | Status | Reason to Keep |
|------------|------|--------|----------------|
| | | | |
| | | | |

**Total branches preserved**: [X]

### Backups Created

| Original Branch | Backup Name | Type | Location |
|----------------|-------------|------|----------|
| | | Tag/Branch | |
| | | Tag/Branch | |

---

## Post-Cleanup Summary

**Final Branch Count**:
- Local branches: [X]
- Remote branches: [Y]
- Total: [Z]
- Reduction: [N] branches removed

**Time Taken**: [X] hours/minutes

---

## Concerns and Questions

**Issues Encountered**:
- [List any problems or complications]

**Questions for Team**:
- [List any questions that need team discussion]

**Follow-up Actions Needed**:
- [ ] [Action item 1]
- [ ] [Action item 2]
- [ ] [Action item 3]

---

## Team Notifications

### Pre-Cleanup Announcement
**Posted**: [Date]  
**Channel**: [Slack/Teams/etc.]  
**Response**: [Summary of feedback]

### Post-Cleanup Notification
**Posted**: [Date]  
**Channel**: [Slack/Teams/etc.]  
**Summary**: [Brief summary posted to team]

---

## Lessons Learned

**What Went Well**:
- 

**What Could Be Improved**:
- 

**Recommendations for Next Cleanup**:
- 

---

## Next Cleanup

**Scheduled Date**: [Date]  
**Assigned To**: @[username]  
**Reminder Set**: [ ] Yes [ ] No

---

## Checklist for Closing This Issue

- [ ] All branches reviewed
- [ ] Deletions completed and verified
- [ ] Team notified
- [ ] Documentation updated
- [ ] Next cleanup scheduled
- [ ] No outstanding concerns

---

## Additional Notes

[Add any additional context, observations, or information relevant to this cleanup session]

---

**Issue Template Version**: 1.0  
**Last Updated**: January 2026
