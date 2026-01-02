#!/usr/bin/env bash
# scripts/security-check.sh
# 
# Security audit script to verify SSH key setup and check for exposed secrets
# Run this script periodically to ensure your development environment is secure

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Git pathspec exclusions for secret scanning
# Excludes archived directories, review files, and security workflow files
GIT_EXCLUDE_PATHSPECS=(
    ":(exclude)Archive_ready_to_sync/**"
    ":(exclude)archive/**"
    ":(exclude)REVIEW_PENDING/**"
    ":(exclude).github/workflows/**"
    ":(exclude).github/secret-scanning.yml"
    ":(exclude)scripts/security-check.sh"
)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0
WARNINGS=0

echo -e "${BLUE}=================================${NC}"
echo -e "${BLUE}SSH Key Security Audit${NC}"
echo -e "${BLUE}=================================${NC}"
echo ""

# Function to print status
print_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSED++))
}

print_fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAILED++))
}

print_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Cross-platform stat command helper
get_permissions() {
    local path="$1"
    case "$(uname -s)" in
        Darwin)
            stat -f "%A" "$path" 2>/dev/null
            ;;
        *)
            stat -c "%a" "$path" 2>/dev/null
            ;;
    esac
}

# Check 1: SSH directory exists and has correct permissions
echo "1. Checking SSH directory..."
if [ -d "$HOME/.ssh" ]; then
    SSH_DIR_PERMS=$(get_permissions "$HOME/.ssh")
    if [ "$SSH_DIR_PERMS" = "700" ]; then
        print_pass "SSH directory exists with correct permissions (700)"
    else
        print_fail "SSH directory has incorrect permissions ($SSH_DIR_PERMS). Run: chmod 700 ~/.ssh"
    fi
else
    print_warn "SSH directory does not exist. Create it with: mkdir -p ~/.ssh && chmod 700 ~/.ssh"
fi
echo ""

# Check 2: SSH keys exist
echo "2. Checking for SSH keys..."
KEYS_FOUND=0
for keytype in ed25519 rsa ecdsa; do
    if [ -f "$HOME/.ssh/id_$keytype" ]; then
        print_info "Found $keytype key: ~/.ssh/id_$keytype"
        KEYS_FOUND=1
        
        # Check private key permissions
        KEY_PERMS=$(get_permissions "$HOME/.ssh/id_$keytype")
        if [ "$KEY_PERMS" = "600" ]; then
            print_pass "Private key has correct permissions (600)"
        else
            print_fail "Private key has incorrect permissions ($KEY_PERMS). Run: chmod 600 ~/.ssh/id_$keytype"
        fi
        
        # Check if public key exists
        if [ -f "$HOME/.ssh/id_$keytype.pub" ]; then
            PUB_PERMS=$(get_permissions "$HOME/.ssh/id_$keytype.pub")
            if [ "$PUB_PERMS" = "644" ]; then
                print_pass "Public key has correct permissions (644)"
            else
                print_warn "Public key has permissions $PUB_PERMS (recommended: 644)"
            fi
        else
            print_warn "Public key not found for id_$keytype"
        fi
    fi
done

if [ $KEYS_FOUND -eq 0 ]; then
    print_warn "No SSH keys found. Generate one with: ssh-keygen -t ed25519 -C 'your_email@example.com'"
fi
echo ""

# Check 3: SSH agent running
echo "3. Checking SSH agent..."
if [ -n "${SSH_AUTH_SOCK:-}" ]; then
    print_pass "SSH agent is running"
    
    # Check if keys are loaded
    LOADED_KEYS=$(ssh-add -l 2>/dev/null | wc -l)
    if [ "$LOADED_KEYS" -gt 0 ]; then
        print_pass "$LOADED_KEYS key(s) loaded in SSH agent"
        ssh-add -l | while read line; do
            print_info "  $line"
        done
    else
        print_warn "No keys loaded in SSH agent. Add your key with: ssh-add ~/.ssh/id_ed25519"
    fi
else
    print_fail "SSH agent not running. Start it with: eval \"\$(ssh-agent -s)\""
fi
echo ""

# Check 4: Test GitHub SSH connection
echo "4. Testing GitHub SSH connection..."
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    print_pass "Successfully authenticated with GitHub via SSH"
else
    print_fail "Cannot authenticate with GitHub. Ensure your public key is added to GitHub."
    print_info "  Add your key at: https://github.com/settings/keys"
    if [[ "$(uname -s)" == "Darwin" ]]; then
        print_info "  Copy your public key (macOS): cat ~/.ssh/id_ed25519.pub | pbcopy"
    else
        print_info "  Copy your public key (Linux): cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard"
        print_info "  Or display it: cat ~/.ssh/id_ed25519.pub"
    fi
fi
echo ""

# Check 5: Git remote configuration
echo "5. Checking git remote configuration..."
cd "$REPO_ROOT"
REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [ -n "$REMOTE_URL" ]; then
    if echo "$REMOTE_URL" | grep -q "^git@github.com:"; then
        print_pass "Git remote uses SSH"
        print_info "  Remote: $REMOTE_URL"
    elif echo "$REMOTE_URL" | grep -q "^https://"; then
        print_warn "Git remote uses HTTPS (SSH recommended for security)"
        if echo "$REMOTE_URL" | grep -q "^https://github.com/"; then
            REPO_PATH="${REMOTE_URL#https://github.com/}"
            REPO_PATH="${REPO_PATH%.git}"
            print_info "  Switch to SSH: git remote set-url origin git@github.com:${REPO_PATH}.git"
        else
            print_info "  Consider switching to SSH for improved security"
        fi
    else
        print_warn "Unrecognized remote URL format: $REMOTE_URL"
    fi
else
    print_warn "No git remote configured"
fi
echo ""

# Check 6: Repository scan for SSH keys
echo "6. Scanning repository for accidentally committed SSH keys..."
SECRETS_FOUND=0

# Check working directory
if find "$REPO_ROOT" -type f \( -name "*.pem" -o -name "*.key" -o -name "id_rsa*" -o -name "id_dsa*" -o -name "id_ecdsa*" -o -name "id_ed25519*" \) ! -path "*/.git/*" 2>/dev/null | grep -q .; then
    print_fail "Found potential SSH key files in working directory:"
    find "$REPO_ROOT" -type f \( -name "*.pem" -o -name "*.key" -o -name "id_rsa*" -o -name "id_dsa*" -o -name "id_ecdsa*" -o -name "id_ed25519*" \) ! -path "*/.git/*" 2>/dev/null | while read file; do
        print_info "  $file"
    done
    SECRETS_FOUND=1
else
    print_pass "No SSH key files found in working directory"
fi

# Check git history
# Validate that GIT_EXCLUDE_PATHSPECS array is properly defined
# Use mktemp for secure temporary file handling
TEMP_GIT_CHECK=$(mktemp)
trap 'rm -f "$TEMP_GIT_CHECK"' EXIT

if [ ${#GIT_EXCLUDE_PATHSPECS[@]} -eq 0 ]; then
    print_warn "GIT_EXCLUDE_PATHSPECS array is empty, scanning all git history"
    git -C "$REPO_ROOT" log --all --source --full-history -S "PRIVATE KEY-----" --oneline > "$TEMP_GIT_CHECK" 2>/dev/null || true
else
    # Array is populated, use pathspec exclusions with proper quoting
    git -C "$REPO_ROOT" log --all --source --full-history -S "PRIVATE KEY-----" --oneline -- . "${GIT_EXCLUDE_PATHSPECS[@]}" > "$TEMP_GIT_CHECK" 2>/dev/null || true
fi

if [ -s "$TEMP_GIT_CHECK" ]; then
    print_fail "Found private key references in git history:"
    head -5 "$TEMP_GIT_CHECK" | while read line; do
        print_info "  $line"
    done
    print_info "Real credentials may have been committed. Review immediately!"
    print_info "  See docs/SSH_KEY_SECURITY.md for history cleanup instructions"
    SECRETS_FOUND=1
else
    print_pass "No private keys found in git history (excluding documented examples)"
fi

if [ $SECRETS_FOUND -eq 0 ]; then
    print_pass "Repository scan complete - no secrets found"
fi
echo ""

# Check 7: .gitignore verification
echo "7. Checking .gitignore for SSH key patterns..."
if grep -q "id_rsa\|id_dsa\|id_ecdsa\|id_ed25519\|\.pem\|\.key" "$REPO_ROOT/.gitignore"; then
    print_pass ".gitignore includes SSH key patterns"
else
    print_fail ".gitignore missing SSH key patterns"
    print_info "  Update .gitignore to include key exclusion patterns"
fi
echo ""

# Check 8: Pre-commit hooks
echo "8. Checking pre-commit hooks..."
if [ -f "$REPO_ROOT/.pre-commit-config.yaml" ]; then
    print_pass "Pre-commit configuration file exists"
    
    if [ -f "$REPO_ROOT/.git/hooks/pre-commit" ]; then
        print_pass "Pre-commit hooks are installed"
    else
        print_warn "Pre-commit hooks not installed. Run: pip install pre-commit && pre-commit install"
    fi
else
    print_warn "Pre-commit configuration not found"
fi
echo ""

# Check 9: Environment variables
echo "9. Checking for sensitive environment variables..."
if [ -f "$REPO_ROOT/.env" ]; then
    print_warn ".env file found (ensure it's in .gitignore)"
    if grep -q "^\.env$" "$REPO_ROOT/.gitignore"; then
        print_pass ".env is properly excluded in .gitignore"
    else
        print_fail ".env file exists but not in .gitignore!"
    fi
else
    print_info "No .env file found (this is normal if you don't use environment files)"
fi

# Check if OPENAI_API_KEY is set
if [ -n "${OPENAI_API_KEY:-}" ]; then
    print_pass "OPENAI_API_KEY environment variable is set"
else
    print_info "OPENAI_API_KEY not set (required for AI features)"
fi
echo ""

# Summary
echo ""
echo -e "${BLUE}=================================${NC}"
echo -e "${BLUE}Security Audit Summary${NC}"
echo -e "${BLUE}=================================${NC}"
echo -e "${GREEN}Passed:${NC}   $PASSED"
echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
echo -e "${RED}Failed:${NC}   $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo -e "${GREEN}✓ Excellent! Your setup follows all security best practices.${NC}"
    else
        echo -e "${YELLOW}⚠ Good setup with some minor warnings. Review warnings above.${NC}"
    fi
else
    echo -e "${RED}✗ Security issues detected. Please address failed checks above.${NC}"
    echo -e "${BLUE}ℹ For detailed guidance, see: docs/SSH_KEY_SECURITY.md${NC}"
fi

echo ""
echo "For more information:"
echo "  - SSH Key Security Guide: docs/SSH_KEY_SECURITY.md"
echo "  - Security Checklist: docs/checklists/SECURITY_CHECKLIST.md"
echo "  - Contributing Guide: CONTRIBUTING.md"
echo ""

# Exit with error if there are failures
if [ $FAILED -gt 0 ]; then
    exit 1
fi

exit 0
