# Branch Deletion Execution Guide

## Overview
This guide provides multiple methods to execute the approved branch deletions from Phase 1 investigation (PR #56).

**⚠️ IMPORTANT**: All 4 branches have been verified as safe to delete based on Phase 1 analysis.

---

## Branches Approved for Deletion

| Branch | PR | Status | SHA (for recovery) |
|--------|----| -------|-------------------|
| `workflow-consolidation` | #3 | Merged 2025-12-21 | `f124cbb6a3d197faf4beba4ea1ad28758f7b231d` |
| `workflow-consolidation-2` | N/A | Duplicate | `f124cbb6a3d197faf4beba4ea1ad28758f7b231d` |
| `copilot/fix-secrets-usage-errors` | #53 | Merged 2026-01-15 | `f7354f98685769a4a6fad26f904fe840c729c020` |
| `copilot/setup-copilot-instructions` | #31 | Merged 2025-12-30 | `22541649387d9ce442370035677c61b30ec6186f` |

---

## Method 1: Automated Script (Recommended)

### Using Git CLI
```bash
# Navigate to repository
cd /path/to/InsightfulAffiliate_NextGenCopyAI

# Run the automated deletion script
./scripts/delete-approved-branches.sh
```

**Note**: This script uses bash and will work even if your default shell is zsh.

### Using GitHub CLI
```bash
# Navigate to repository
cd /path/to/InsightfulAffiliate_NextGenCopyAI

# Run the GitHub CLI deletion script
./scripts/delete-approved-branches-gh.sh
```

**Note**: This script uses bash and will work even if your default shell is zsh.

Both scripts will:
- Show you what will be deleted
- Ask for confirmation
- Delete each branch
- Provide a summary report
- Clean up local references

---

## Method 2: Manual Git Commands

### Delete branches one by one:

```bash
# Delete workflow-consolidation
git push origin --delete workflow-consolidation

# Delete workflow-consolidation-2
git push origin --delete workflow-consolidation-2

# Delete copilot/fix-secrets-usage-errors
git push origin --delete copilot/fix-secrets-usage-errors

# Delete copilot/setup-copilot-instructions
git push origin --delete copilot/setup-copilot-instructions

# Clean up local references
git fetch --prune
```

### Or delete all at once:
```bash
git push origin --delete \
  workflow-consolidation \
  workflow-consolidation-2 \
  copilot/fix-secrets-usage-errors \
  copilot/setup-copilot-instructions

git fetch --prune
```

---

## Method 3: GitHub Web Interface

For each branch:

1. Go to: https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI/branches
2. Find the branch in the list
3. Click the trash icon (🗑️) next to the branch name
4. Confirm deletion

**Branches to delete via UI**:
- workflow-consolidation
- workflow-consolidation-2
- copilot/fix-secrets-usage-errors
- copilot/setup-copilot-instructions

---

## Method 4: GitHub CLI (Individual Commands)

```bash
# Authenticate if needed
gh auth login

# Delete each branch
gh api -X DELETE repos/insightfulaf/InsightfulAffiliate_NextGenCopyAI/git/refs/heads/workflow-consolidation
gh api -X DELETE repos/insightfulaf/InsightfulAffiliate_NextGenCopyAI/git/refs/heads/workflow-consolidation-2
gh api -X DELETE repos/insightfulaf/InsightfulAffiliate_NextGenCopyAI/git/refs/heads/copilot/fix-secrets-usage-errors
gh api -X DELETE repos/insightfulaf/InsightfulAffiliate_NextGenCopyAI/git/refs/heads/copilot/setup-copilot-instructions

# Verify remaining branches
gh api repos/insightfulaf/InsightfulAffiliate_NextGenCopyAI/branches --jq '.[].name'
```

---

## Verification After Deletion

### Check remaining branches:
```bash
# Via git
git fetch --prune
git branch -r

# Via GitHub CLI
gh api repos/insightfulaf/InsightfulAffiliate_NextGenCopyAI/branches --jq '.[].name'
```

### Expected result:
You should see only:
- `main`
- `copilot/delete-merged-stale-branches` (this PR, will be deleted after merge)

---

## Recovery (If Needed)

If you need to recover any deleted branch:

```bash
# Format: git checkout -b <branch-name> <sha>

# Recover workflow-consolidation
git checkout -b workflow-consolidation f124cbb6a3d197faf4beba4ea1ad28758f7b231d
git push origin workflow-consolidation

# Recover workflow-consolidation-2
git checkout -b workflow-consolidation-2 f124cbb6a3d197faf4beba4ea1ad28758f7b231d
git push origin workflow-consolidation-2

# Recover copilot/fix-secrets-usage-errors
git checkout -b copilot/fix-secrets-usage-errors f7354f98685769a4a6fad26f904fe840c729c020
git push origin copilot/fix-secrets-usage-errors

# Recover copilot/setup-copilot-instructions
git checkout -b copilot/setup-copilot-instructions 22541649387d9ce442370035677c61b30ec6186f
git push origin copilot/setup-copilot-instructions
```

---

## Safety Checklist

Before executing deletion, verify:

- [ ] You have reviewed the Phase 1 investigation report (PR #56)
- [ ] You understand which branches will be deleted
- [ ] You have noted the SHA hashes for potential recovery
- [ ] You are authorized to delete branches in this repository
- [ ] You have a backup or can recover from the recorded SHAs

---

## Post-Deletion Checklist

After executing deletion:

- [ ] Verify branches are deleted from remote
- [ ] Confirm main branch is intact
- [ ] Run `git fetch --prune` to clean up local refs
- [ ] Update documentation if needed
- [ ] Close this PR (#57) after merge

---

## Documentation

- **Phase 1 Report**: PR #56
- **Cleanup Report**: `docs/branch-cleanup-2026-01-23.md`
- **This Guide**: `docs/branch-deletion-execution-guide.md`

---

## Questions or Issues?

If you encounter any problems:

1. Check the recovery section above
2. Review the Phase 1 investigation (PR #56)
3. Consult `docs/branch-cleanup-2026-01-23.md`
4. The SHAs are recorded for branch recovery if needed

---

**Created**: January 23, 2026  
**Author**: Copilot Agent  
**Related PRs**: #56 (Investigation), #57 (Execution)
