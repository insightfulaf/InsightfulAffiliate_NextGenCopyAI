#!/bin/bash

# Security Scan Verification Script
# This script verifies the security scan workflow logic and checks for keys
# Usage: ./scripts/verify-security-scan.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Track overall status
OVERALL_STATUS=0

# ===== Check 1: Working Directory =====
print_header "Check 1: Scanning Working Directory for SSH Keys"

echo "Checking for SSH key files..."
KEY_FILES=$(find . -type f \( -name "*.pem" -o -name "*.key" -o -name "id_rsa*" -o -name "id_dsa*" -o -name "id_ecdsa*" -o -name "id_ed25519*" \) \
  ! -path "./.git/*" \
  ! -path "./node_modules/*" \
  ! -path "./Archive_ready_to_sync/*" \
  ! -path "./archive/*" \
  ! -path "./REVIEW_PENDING/*" \
  2>/dev/null || true)

if [ -z "$KEY_FILES" ]; then
    print_success "No SSH key files found in working directory"
else
    print_error "SSH key files found:"
    echo "$KEY_FILES"
    OVERALL_STATUS=1
fi

echo
echo "Checking for private key content in files..."
KEY_CONTENT=$(git grep -E "BEGIN (RSA |DSA |EC |OPENSSH |ENCRYPTED )?PRIVATE KEY" -- \
  . \
  ":(exclude).github/" \
  ":(exclude)docs/**" \
  ":(exclude).pre-commit-config.yaml" \
  ":(exclude)Archive_ready_to_sync/" \
  ":(exclude)archive/" \
  ":(exclude)REVIEW_PENDING/" \
  ":(exclude)scripts/security-check.sh" \
  ":(exclude)scripts/verify-security-scan.sh" \
  ":(exclude).secrets.baseline" \
  ":(exclude)*_SUMMARY.md" \
  ":(exclude)*_GUIDE.md" \
  2>/dev/null || true)

if [ -z "$KEY_CONTENT" ]; then
    print_success "No private key content found in working directory"
else
    print_error "Private key content found in files:"
    echo "$KEY_CONTENT"
    OVERALL_STATUS=1
fi

# ===== Check 2: Git History Analysis =====
print_header "Check 2: Analyzing Git History for Private Keys"

# Set up temp file and cleanup trap early
TEMP_VIOLATIONS=$(mktemp)
trap 'rm -f "$TEMP_VIOLATIONS"' EXIT

echo "Finding commits that modified 'PRIVATE KEY-----'..."
COMMITS=$(git log --all --format="%H %s" -S "PRIVATE KEY-----" -- \
  . \
  ":(exclude)Archive_ready_to_sync/**" \
  ":(exclude)archive/**" \
  ":(exclude)REVIEW_PENDING/**" \
  ":(exclude).github/**" \
  ":(exclude)docs/**" \
  ":(exclude)scripts/security-check.sh" \
  ":(exclude)scripts/verify-security-scan.sh" \
  ":(exclude).secrets.baseline" \
  ":(exclude).pre-commit-config.yaml" \
  ":(exclude,glob)**/*_SUMMARY.md" \
  ":(exclude,glob)**/*_GUIDE.md" \
  2>/dev/null || true)

if [ -z "$COMMITS" ]; then
    print_success "No commits found that modify private key strings"
else
    COMMIT_COUNT=$(echo "$COMMITS" | wc -l)
    print_info "Found $COMMIT_COUNT commit(s) that modified 'PRIVATE KEY-----'"
    echo
    
    echo "Analyzing each commit to distinguish additions from removals..."
    echo
    
    VIOLATIONS=0
    
    while IFS= read -r line; do
        commit_sha=$(echo "$line" | awk '{print $1}')
        commit_msg=$(git log --format=%s -n 1 "$commit_sha")
        commit_short=$(echo "$commit_sha" | cut -c1-7)
        
        echo "  Analyzing: $commit_short - $commit_msg"
        
        # If message indicates removal/fix, treat as a hint only (still inspect diff)
        if echo "$commit_msg" | grep -qiE "((remove|delete|clean|strip|redact|fix|security).*(key|secret|credential|ssh)|(key|secret|credential|ssh).*(remove|delete|clean|strip|redact|fix|security))"; then
            print_info "    → Message suggests key removal/security fix; verifying diff for additions..."
        fi
        
        # Check if diff adds private keys
        if git show "$commit_sha" -- . \
            ":(exclude)Archive_ready_to_sync/**" \
            ":(exclude)archive/**" \
            ":(exclude)REVIEW_PENDING/**" \
            ":(exclude).github/**" \
            ":(exclude)docs/**" \
            ":(exclude)scripts/security-check.sh" \
            ":(exclude)scripts/verify-security-scan.sh" \
            ":(exclude).secrets.baseline" \
            ":(exclude).pre-commit-config.yaml" \
            ":(exclude,glob)**/*_SUMMARY.md" \
            ":(exclude,glob)**/*_GUIDE.md" \
            | grep -E "^\+.*BEGIN [A-Z0-9_-]+ PRIVATE KEY" >/dev/null 2>&1; then
            print_error "    → VIOLATION: This commit ADDED private key content"
            echo "$commit_short: $commit_msg" >> "$TEMP_VIOLATIONS"
            VIOLATIONS=$((VIOLATIONS + 1))
        else
            print_success "    → OK (only removed/modified keys, not added)"
        fi
    done < <(echo "$COMMITS")
    
    echo
    
    if [ -s "$TEMP_VIOLATIONS" ]; then
        print_error "Found $VIOLATIONS commit(s) that ADDED private keys:"
        while IFS= read -r violation; do
            echo "    $violation"
        done < "$TEMP_VIOLATIONS"
        echo
        print_warning "Action required:"
        echo "  1. Verify if keys are real or test data"
        echo "  2. If real, rotate/revoke immediately"
        echo "  3. Optionally clean git history (see docs/SECURITY_SCAN_FIX_GUIDE.md)"
        OVERALL_STATUS=1
    else
        print_success "All commits touching private keys were removals or documentation updates"
    fi
fi

# ===== Check 3: .gitignore Verification =====
print_header "Check 3: Verifying .gitignore Patterns"

echo "Checking for SSH key patterns in .gitignore..."
MISSING_PATTERNS=()

# Check for essential patterns
patterns=("id_rsa" "id_dsa" "id_ecdsa" "id_ed25519" "*.pem" "*.key")
for pattern in "${patterns[@]}"; do
    if grep -q "$pattern" .gitignore 2>/dev/null; then
        print_success "Pattern found: $pattern"
    else
        print_warning "Pattern missing: $pattern"
        MISSING_PATTERNS+=("$pattern")
    fi
done

if [ ${#MISSING_PATTERNS[@]} -eq 0 ]; then
    print_success "All essential SSH key patterns present in .gitignore"
else
    print_warning "Consider adding missing patterns to .gitignore"
fi

# ===== Check 4: Workflow Configuration =====
print_header "Check 4: Verifying Workflow Configuration"

WORKFLOW_FILE=".github/workflows/security-scan.yml"
if [ ! -f "$WORKFLOW_FILE" ]; then
    print_error "Workflow file not found: $WORKFLOW_FILE"
    OVERALL_STATUS=1
else
    print_success "Workflow file exists: $WORKFLOW_FILE"
    
    # Check for key features
    echo
    echo "Checking workflow features..."
    
    if grep -q "grep -qiE" "$WORKFLOW_FILE" && grep -q "remove.*delete.*fix.*security" "$WORKFLOW_FILE"; then
        print_success "Commit message filtering enabled"
    else
        print_warning "Commit message filtering not found"
    fi
    
    if grep -q 'grep -E' "$WORKFLOW_FILE" && grep -q 'BEGIN.*PRIVATE KEY' "$WORKFLOW_FILE"; then
        print_success "Diff analysis for key additions enabled"
    else
        print_warning "Diff analysis not found"
    fi
    
    if grep -q "exclude.*\.github" "$WORKFLOW_FILE"; then
        print_success "Documentation exclusions configured"
    else
        print_warning "Documentation exclusions not found"
    fi
fi

# ===== Summary =====
print_header "Verification Summary"

if [ $OVERALL_STATUS -eq 0 ]; then
    print_success "All security checks passed!"
    echo
    echo "Your repository is properly configured for secret detection."
    echo "The workflow will correctly identify security violations while"
    echo "avoiding false positives from security fixes and documentation."
else
    print_warning "Some issues were found (see above)"
    echo
    echo "Review the findings above and take appropriate action."
    echo "See docs/SECURITY_SCAN_FIX_GUIDE.md for detailed guidance."
fi

echo
print_info "For more information:"
echo "  - docs/SECURITY_SCAN_FIX_GUIDE.md"
echo "  - docs/SSH_KEY_SECURITY.md"
echo "  - SECURITY.md"
echo

exit $OVERALL_STATUS
