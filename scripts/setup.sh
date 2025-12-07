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

# Test git ls-remote (HTTP/SSH) - may fail if no access
echo
echo "Testing access to origin with 'git ls-remote origin' (this may fail if access restricted)..."
if git -C "$REPO_ROOT" ls-remote origin >/dev/null 2>&1; then
  echo "Success: able to contact origin and read refs."
else
  echo "Warning: could not read from origin. If this is unexpected, check the remote URL and your credentials."
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
