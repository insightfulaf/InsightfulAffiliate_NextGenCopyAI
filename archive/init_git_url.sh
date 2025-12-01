#!/usr/bin/env bash
set -euo pipefail

# init_git_url.sh — initialize repo and push to a provided GitHub URL in one command.
#
# Usage:
#   ./init_git_url.sh <https://github.com/USER/REPO.git> [--lfs]
#
# Example:
#   ./init_git_url.sh https://github.com/yourname/AffiliateBusiness.git --lfs
#
# Notes:
# - Create the PRIVATE repo on GitHub first (web UI).
# - Run this from your project ROOT (same folder as your top-level files).

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <https://github.com/USER/REPO.git> [--lfs]"
  exit 1
fi

REMOTE_URL="$1"
USE_LFS="no"
if [[ "${2:-}" == "--lfs" ]]; then
  USE_LFS="yes"
fi

echo ">> Project directory: $PWD"
echo ">> Remote: $REMOTE_URL"

# 1) Create .gitignore if missing
if [[ ! -f ".gitignore" ]]; then
  cat > .gitignore <<'EOF'
# ===== macOS =====
.DS_Store
.AppleDouble
.LSOverride
.Icon?
.Spotlight-V100
.Trashes
._*

# ===== Editors & IDEs =====
.vscode/
.idea/
*.swp

# ===== Logs =====
logs/
*.log
npm-debug.log*
yarn-debug.log*
pnpm-debug.log*
.pnpm-debug.log*

# ===== Environment / Secrets =====
.env
.env.*
.env.local

# ===== Dependencies & Caches =====
node_modules/
.cache/
.tmp/
dist/
build/
.next/
.out/

# ===== Python =====
.venv/
__pycache__/

# ===== OS / Cloud miscellany =====
Thumbs.db
Desktop.ini
.dropbox.attr

# ===== Archives / temp backups =====
*.zip
*.tar
*.gz
*.tgz
*.rar
*.7z
*~
EOF
  echo "Created .gitignore ✅"
else
  echo ".gitignore exists — leaving as-is."
fi

# 2) Initialize git (idempotent)
if [[ ! -d ".git" ]]; then
  git init
  echo "Initialized git repo ✅"
else
  echo "Git repo already initialized."
fi

# Ensure main branch
git symbolic-ref -q HEAD || git symbolic-ref HEAD refs/heads/main
git checkout -B main

# 3) Optional: Git LFS
if [[ "$USE_LFS" == "yes" ]]; then
  if command -v git-lfs >/dev/null 2>&1; then
    git lfs install
    git lfs track "*.pdf" "*.png" "*.jpg" "*.jpeg" "*.zip"
    echo "Configured Git LFS for PDFs/Images/Zips ✅"
  else
    echo "git-lfs not found — install from https://git-lfs.com/ and rerun with --lfs if needed."
  fi
fi

# 4) First commit (safe if nothing new)
git add .
git commit -m "chore: initialize repository" || echo "Nothing to commit."

# 5) Set remote & push
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
  echo "Updated existing 'origin' remote."
else
  git remote add origin "$REMOTE_URL"
  echo "Added 'origin' remote."
fi

# Push (creates main branch on remote)
git push -u origin main

echo "All set. Repo initialized and pushed to: $REMOTE_URL ✅"
