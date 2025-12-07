#!/usr/bin/env bash
set -euo pipefail

# scripts/setup.sh
# Automate macOS git credential helper setup and run basic repo checks.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Repository root: $REPO_ROOT"

# Detect macOS
OS_NAME="$(uname -s)"
if [ "$OS_NAME" != "Darwin" ]; then
  echo "This script currently automates macOS-specific setup. Detected: $OS_NAME"
  echo "You can still run the checks below, but credential helper setup is skipped."
else
  echo "Detected macOS. Configuring git credential helper 'osxkeychain'..."
  git config --global credential.helper osxkeychain
  echo "Set git credential.helper to: $(git config --global --get credential.helper || echo '(none)')"
fi

# Show current remote(s)
echo
echo "Current remotes for repo (from $REPO_ROOT):"
git -C "$REPO_ROOT" remote -v || true

# Show remote URL currently set for origin
ORIGIN_URL="$(git -C "$REPO_ROOT" remote get-url origin 2>/dev/null || true)"
if [ -n "$ORIGIN_URL" ]; then
  echo
  echo "Origin URL: $ORIGIN_URL"
fi

# Offer interactive option to switch origin URL (only when run interactively)
if [ -n "$ORIGIN_URL" ] && [ -t 0 ]; then
  echo
  echo "Would you like to change the repository's 'origin' remote?"
  echo "  1) Keep current origin ($ORIGIN_URL)"
  echo "  2) Switch to HTTPS: https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git"
  echo "  3) Switch to SSH: git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git"
  printf "Choose 1/2/3 (default 1): "
  read -r choice || choice=1
  case "$choice" in
    2)
      new_url="https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git"
      echo "Switching origin to HTTPS: $new_url"
      git -C "$REPO_ROOT" remote set-url origin "$new_url"
      ORIGIN_URL="$new_url"
      ;;
    3)
      new_url="git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git"
      echo "Switching origin to SSH: $new_url"
      git -C "$REPO_ROOT" remote set-url origin "$new_url"
      ORIGIN_URL="$new_url"
      ;;
    *)
      echo "Keeping current origin."
      ;;
  esac
  echo "New origin: $(git -C "$REPO_ROOT" remote get-url origin)"
fi

# Test git ls-remote (HTTP/SSH) - may fail if no access
echo
echo "Testing access to origin with 'git ls-remote origin' (this may fail if access restricted)..."
if git -C "$REPO_ROOT" ls-remote origin >/dev/null 2>&1; then
  echo "Success: able to contact origin and read refs."
else
  echo "Warning: could not read from origin. If this is unexpected, check the remote URL and your credentials."
fi

# If origin is HTTPS, attempt a dry-run push to detect missing/invalid PATs (401/403)
if echo "$ORIGIN_URL" | grep -qi "^https://"; then
  echo
  echo "Origin appears to be HTTPS. Performing a dry-run push to check write permissions (will not change remote)..."
  push_output=""
  if push_output=$(git -C "$REPO_ROOT" push --dry-run origin HEAD 2>&1); then
    echo "Dry-run push succeeded (no authentication error detected)."
  else
    echo "Dry-run push failed. Inspecting output for authentication errors..."
    echo "---- push output ----"
    echo "$push_output"
    echo "---- end push output ----"
    # Look for common authentication failure patterns
    if echo "$push_output" | grep -Ei "authentication failed|fatal: Authentication failed|HTTP Basic: Access denied|The requested URL returned error: 401|The requested URL returned error: 403|permission to .* denied" >/dev/null; then
      echo
      echo "Authentication error detected when attempting to push over HTTPS. This usually means your Personal Access Token (PAT) is missing or lacks the required scopes."
      echo "Recommended steps:"
      echo "  1) Ensure you've created a PAT with the 'repo' scope (or appropriate fine-grained token)."
      echo "  2) Enable macOS keychain helper: git config --global credential.helper osxkeychain"
      echo "  3) Perform a push and enter your GitHub username and PAT when prompted; the keychain will store it."
      echo "  4) Alternatively switch to SSH if you prefer key-based auth. See CONTRIBUTING.md for details."
    else
      echo "No explicit authentication failure pattern detected in the dry-run output; investigate the above output for details."
    fi
  fi
fi

# Test SSH auth (non-fatal)
echo
echo "Testing SSH auth to git@github.com (non-fatal) - output below:" 
if ssh -T git@github.com 2>&1 | tee /tmp/_ssh_test_output.txt; then
  echo "SSH test returned success or greeting."
else
  echo "SSH test did not return expected greeting (this may be normal if you use HTTPS or if SSH keys aren't configured)."
  echo "See /tmp/_ssh_test_output.txt for details."
fi

# Quick checks summary
echo
echo "Quick checks completed. Summary:"
if [ "$OS_NAME" = "Darwin" ]; then
  echo "- macOS: credential.helper=$(git config --global --get credential.helper)"
else
  echo "- Non-macOS: skipped credential helper setup"
fi
if [ -n "$ORIGIN_URL" ]; then
  echo "- origin: $ORIGIN_URL"
else
  echo "- origin: not set"
fi

cat <<EOF

Next steps (if needed):
- To switch to HTTPS remote:
  git remote set-url origin https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
- To switch to SSH remote:
  git remote set-url origin git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
- To enable macOS keychain (manual):
  git config --global credential.helper osxkeychain

The script attempted to test connectivity; review its output above for any warnings.
EOF
