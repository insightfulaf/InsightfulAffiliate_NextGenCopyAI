# Instructions for PR #1 Review and Merge

## What You Need to Do

Following the instruction: "Ask a teammate with write access to review PR #1; once they approve, run gh pr merge 1 --merge --delete-branch (or click "Merge pull request" in the UI)."

## Step 1: Request Review

**Action Required:** Ask a teammate with write access to review PR #1

- **PR URL:** https://github.com/insightfulaf/CURRENT/pull/1
- **PR Title:** chore: connection check
- **Changes:** Adds connection test file and improves copilot instructions

**How to request review:**
1. Go to https://github.com/insightfulaf/CURRENT/pull/1
2. On the right sidebar, find "Reviewers"
3. Click the gear icon next to "Reviewers"
4. Select teammate(s) with write access from the list
5. They will receive a notification to review

## Step 2: Wait for Approval

The reviewer should examine:
- `.connection-check.txt` - new test file
- `.github/copilot-instructions.md` - spacing fixes and Python AI config example

See `PR1_REVIEW_GUIDE.md` for detailed review checklist.

## Step 3: Merge After Approval

Once approved, execute ONE of these options:

### Option A: Using GitHub CLI (Recommended)
```bash
gh pr merge 1 --merge --delete-branch
```

### Option B: Using GitHub UI
1. Visit https://github.com/insightfulaf/CURRENT/pull/1
2. Click "Merge pull request" button
3. Confirm the merge
4. Click "Delete branch"

## Summary

PR #1 contains:
- ✅ Connection test log file (diagnostic)
- ✅ Enhanced copilot instructions with AI configuration example
- ✅ Formatting improvements (spacing, newlines)

Total changes: +119 lines, -12 lines across 2 files

## Status Tracking

- [ ] Review requested from teammate with write access
- [ ] PR #1 reviewed by teammate
- [ ] PR #1 approved by reviewer
- [ ] PR #1 merged using command or UI
- [ ] Branch `connection-check` deleted

## Additional Resources

- Full review guide: See `PR1_REVIEW_GUIDE.md` in this repository
- PR #1 direct link: https://github.com/insightfulaf/CURRENT/pull/1
