#!/usr/bin/env bash

# Branch Cleanup Execution Script (GitHub CLI version)
# Generated: January 23, 2026
# Based on Phase 1 Investigation (PR #56)
# Compatible with bash (will run even if your default shell is zsh)

set -e  # Exit on error

echo "=========================================="
echo "Branch Cleanup Execution Script (gh CLI)"
echo "Phase 2: Delete Merged and Stale Branches"
echo "=========================================="
echo ""

# Repository
REPO="insightfulaf/InsightfulAffiliate_NextGenCopyAI"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Branches to delete (approved in Phase 1)
declare -a BRANCHES=(
    "workflow-consolidation"
    "workflow-consolidation-2"
    "copilot/fix-secrets-usage-errors"
    "copilot/setup-copilot-instructions"
)

# Check if gh is available and authenticated
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI (gh) is not installed.${NC}"
    echo "Install it from: https://cli.github.com/"
    exit 1
fi

if ! gh auth status &> /dev/null; then
    echo -e "${YELLOW}You are not authenticated with GitHub CLI.${NC}"
    echo "Please run: gh auth login"
    exit 1
fi

echo -e "${YELLOW}This script will delete the following branches from remote:${NC}"
echo ""
for branch in "${BRANCHES[@]}"; do
    echo -e "  - ${RED}$branch${NC}"
    case "$branch" in
        "workflow-consolidation")
            echo -e "    PR #3 | SHA: f124cbb6a3d197faf4beba4ea1ad28758f7b231d | Merged: 2025-12-21"
            ;;
        "workflow-consolidation-2")
            echo -e "    Duplicate | SHA: f124cbb6a3d197faf4beba4ea1ad28758f7b231d | N/A"
            ;;
        "copilot/fix-secrets-usage-errors")
            echo -e "    PR #53 | SHA: f7354f98685769a4a6fad26f904fe840c729c020 | Merged: 2026-01-15"
            ;;
        "copilot/setup-copilot-instructions")
            echo -e "    PR #31 | SHA: 22541649387d9ce442370035677c61b30ec6186f | Merged: 2025-12-30"
            ;;
    esac
    echo ""
done

echo "=========================================="
echo ""

# Ask for confirmation
read -p "Do you want to proceed with deletion? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo -e "${YELLOW}Deletion cancelled by user.${NC}"
    exit 0
fi

echo ""
echo "Starting deletion process..."
echo ""

# Track results
deleted_count=0
failed_count=0
declare -a failed_branches

# Delete each branch using gh CLI
for branch in "${BRANCHES[@]}"; do
    echo -e "Deleting branch: ${RED}$branch${NC}"
    
    if gh api -X DELETE "repos/$REPO/git/refs/heads/$branch" 2>/dev/null; then
        echo -e "  ${GREEN}✓ Successfully deleted${NC}"
        ((++deleted_count))
    else
        echo -e "  ${RED}✗ Failed to delete (may already be deleted)${NC}"
        ((++failed_count))
        failed_branches+=("$branch")
    fi
    echo ""
done

# Prune local references if in repo
if [ -d ".git" ]; then
    echo "Cleaning up local remote tracking references..."
    git fetch --prune 2>/dev/null || true
    echo -e "${GREEN}✓ Pruned stale remote references${NC}"
    echo ""
fi

# Summary
echo "=========================================="
echo "Deletion Summary"
echo "=========================================="
echo -e "Successfully deleted: ${GREEN}$deleted_count${NC} branches"
echo -e "Failed to delete: ${RED}$failed_count${NC} branches"

if [ $failed_count -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}Failed branches (may already be deleted):${NC}"
    for branch in "${failed_branches[@]}"; do
        echo "  - $branch"
    done
fi

echo ""
echo "=========================================="
echo ""

# Verify remaining branches
echo "Current remote branches:"
gh api "repos/$REPO/branches" --jq '.[].name' | sed 's/^/  /'
echo ""

echo -e "${GREEN}Branch cleanup complete!${NC}"
echo ""
echo "For recovery instructions, see: docs/branch-cleanup-2026-01-23.md"
