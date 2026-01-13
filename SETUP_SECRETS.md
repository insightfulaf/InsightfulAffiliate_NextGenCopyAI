# Secrets Setup Guide

Quick start guide for setting up secure secrets management in this repository.

## Quick Start (5 Minutes)

### 1. Install Pre-commit Hooks

```bash
# Install pre-commit
pip install pre-commit

# Install the hooks
cd /path/to/InsightfulAffiliate_NextGenCopyAI
pre-commit install

# Test the installation
pre-commit run --all-files
```

**Expected output:**
```
✓ All hooks passed
```

### 2. Set Up Local Environment

```bash
# Copy the example environment file
cp .env.example .env

# Edit with your actual secrets (NEVER commit this file!)
nano .env

# Set proper permissions
chmod 600 .env

# Verify .env is in .gitignore
cat .gitignore | grep ".env"
```

### 3. Configure GitHub Secrets (if needed)

For workflows that need secrets:

1. Go to repository **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret**
3. Add required secrets (see [Common Secrets](#common-secrets) below)

### 4. Verify Setup

```bash
# Run security check
./scripts/security-check.sh

# Check git status (should not show .env)
git status

# Test pre-commit hooks
pre-commit run --all-files
```

✅ **You're all set!** Your development environment is now secure.

## Detailed Setup

### Pre-commit Hooks Installation

Pre-commit hooks automatically scan for secrets before you commit. They're your first line of defense.

#### Install Pre-commit

**Option 1: Using pip (recommended)**
```bash
pip install pre-commit
```

**Option 2: Using Homebrew (macOS)**
```bash
brew install pre-commit
```

**Option 3: Using system package manager**
```bash
# Ubuntu/Debian
sudo apt-get install pre-commit

# Fedora
sudo dnf install pre-commit
```

#### Install Hooks in Repository

```bash
# Navigate to repository
cd /path/to/InsightfulAffiliate_NextGenCopyAI

# Install the hooks (reads from .pre-commit-config.yaml)
pre-commit install

# Also install commit-msg hook for commit message linting
pre-commit install --hook-type commit-msg
```

**Expected output:**
```
pre-commit installed at .git/hooks/pre-commit
pre-commit installed at .git/hooks/commit-msg
```

#### Test the Hooks

```bash
# Run all hooks manually
pre-commit run --all-files

# Expected output:
# Trim Trailing Whitespace...................Passed
# Fix End of Files...........................Passed
# Check Yaml.................................Passed
# Check for added large files................Passed
# Detect Private Keys........................Passed
# detect-secrets.............................Passed
# black......................................Passed
# flake8.....................................Passed
```

### Local Environment Setup

#### Create .env File

The `.env` file stores secrets for local development. It's automatically excluded from git.

```bash
# Create from example template
cp .env.example .env

# Or create manually
cat > .env << 'EOF'
# OpenAI API Configuration
OPENAI_API_KEY=your_actual_api_key_here

# Database Configuration (optional)
DATABASE_URL=postgresql://localhost/mydb

# API Tokens (as needed)
API_TOKEN=your_token_here
EOF

# Secure the file (readable only by you)
chmod 600 .env

# Verify permissions
ls -la .env
# Should show: -rw------- (600)
```

#### Loading Environment Variables

**Python:**
```python
# Install python-dotenv
pip install python-dotenv

# In your script
from dotenv import load_dotenv
import os

load_dotenv()
api_key = os.getenv('OPENAI_API_KEY')
```

**Node.js:**
```javascript
// Install dotenv
npm install dotenv

// In your script
require('dotenv').config();
const apiKey = process.env.OPENAI_API_KEY;
```

**Bash:**
```bash
# Load environment variables
export $(grep -v '^#' .env | xargs)

# Or use source
source .env
```

### GitHub Secrets Configuration

For secrets needed by GitHub Actions workflows.

#### Adding Repository Secrets

1. **Navigate to Repository Settings**
   - Go to your repository on GitHub
   - Click **Settings** (top right)

2. **Access Secrets Section**
   - In left sidebar: **Secrets and variables** → **Actions**

3. **Add New Secret**
   - Click **New repository secret**
   - Enter **Name** (e.g., `OPENAI_API_KEY`)
   - Enter **Value** (paste your secret)
   - Click **Add secret**

4. **Verify Secret**
   - Secret should appear in the list (value is hidden)
   - Test by running a workflow

#### Naming Conventions

Use UPPERCASE with underscores:
- ✅ `OPENAI_API_KEY`
- ✅ `DATABASE_URL`
- ✅ `AWS_ACCESS_KEY_ID`
- ❌ `openai_api_key` (wrong)
- ❌ `OpenAI-API-Key` (wrong)

### Common Secrets

#### Required for This Repository

**OPENAI_API_KEY**
- **Purpose**: AI content generation
- **Format**: `sk-...` (starts with sk-)
- **Get it**: [OpenAI Platform](https://platform.openai.com/api-keys)
- **Scope**: Repository or local `.env`

#### Optional Secrets

**SSH_PRIVATE_KEY**
- **Purpose**: Deployment via SSH
- **Format**: Full private key content (including BEGIN/END lines)
- **Get it**: Generate with `ssh-keygen -t ed25519`
- **Scope**: Repository secret (for CI/CD)
- **Note**: See [SSH_KEY_SECURITY.md](docs/SSH_KEY_SECURITY.md)

**AWS_ACCESS_KEY_ID** and **AWS_SECRET_ACCESS_KEY**
- **Purpose**: AWS service access
- **Get it**: AWS IAM Console
- **Scope**: Repository secret

**DATABASE_URL**
- **Purpose**: Database connection
- **Format**: `postgresql://user:pass@host:port/dbname`
- **Scope**: Environment secret (different for staging/production)

**GITHUB_TOKEN**
- **Purpose**: GitHub API access
- **Note**: Automatically provided in workflows as `${{ secrets.GITHUB_TOKEN }}`
- **No setup needed!**

## Testing Your Setup

### Test Pre-commit Hooks

```bash
# Create a test file with a fake secret
echo "api_key=sk-test123456789" > test_secret.txt

# Try to commit it
git add test_secret.txt
git commit -m "Test commit"

# Expected: Hooks should BLOCK the commit
# Message: "Detect Private Keys....Failed"

# Clean up
git reset HEAD test_secret.txt
rm test_secret.txt
```

### Test Local Environment

```bash
# Create a test script
cat > test_env.py << 'EOF'
import os
from dotenv import load_dotenv

load_dotenv()

api_key = os.getenv('OPENAI_API_KEY')
if api_key:
    print("✓ OPENAI_API_KEY is configured")
    print(f"✓ Key starts with: {api_key[:5]}...")
else:
    print("❌ OPENAI_API_KEY is not set")
    print("   Please add it to .env file")
EOF

# Run the test
python test_env.py

# Expected: "✓ OPENAI_API_KEY is configured"

# Clean up
rm test_env.py
```

### Test GitHub Secrets

Run the example workflow:

1. Go to **Actions** tab
2. Select **Example - Secrets Usage** workflow
3. Click **Run workflow**
4. Check the results

If secrets are not configured, the workflow will show which ones are missing.

## Troubleshooting

### Pre-commit Hooks Not Running

**Problem**: Commits go through without running hooks.

**Solution**:
```bash
# Reinstall hooks
pre-commit uninstall
pre-commit install

# Verify .git/hooks/pre-commit exists
ls -la .git/hooks/pre-commit
```

### Pre-commit Failing on All Files

**Problem**: `pre-commit run --all-files` fails.

**Common causes**:

1. **Python tools not installed**
   ```bash
   pip install -r requirements.txt
   ```

2. **Code style issues**
   ```bash
   # Let black auto-fix
   black .
   
   # Check flake8 issues
   flake8 .
   ```

3. **Existing secrets detected**
   ```bash
   # Review detected secrets
   detect-secrets scan
   
   # Create baseline if false positives
   detect-secrets scan > .secrets.baseline
   ```

### Environment Variables Not Loading

**Problem**: Script can't find environment variables.

**Solutions**:

1. **Verify .env exists and has correct permissions**
   ```bash
   ls -la .env
   # Should show: -rw-------
   ```

2. **Check .env syntax**
   ```bash
   # No spaces around =
   # Correct: API_KEY=value
   # Wrong: API_KEY = value
   ```

3. **Load in script**
   ```python
   # Python: Use python-dotenv
   from dotenv import load_dotenv
   load_dotenv()  # Add this line!
   ```

4. **Load in shell**
   ```bash
   # Bash: Source the file
   source .env
   ```

### GitHub Secrets Not Working

**Problem**: Workflow can't access secrets.

**Solutions**:

1. **Check secret name matches exactly**
   ```yaml
   # Case-sensitive!
   env:
     API_KEY: ${{ secrets.API_KEY }}  # Not Api_Key or api_key
   ```

2. **Verify secret exists**
   - Settings → Secrets and variables → Actions
   - Confirm secret is listed

3. **Check workflow permissions**
   - Workflow must have permission to read secrets
   - Check repository settings

4. **Use environment for environment secrets**
   ```yaml
   jobs:
     deploy:
       environment: production  # Required for environment secrets!
   ```

### "Permission Denied" on .env

**Problem**: Can't read/write .env file.

**Solution**:
```bash
# Fix permissions
chmod 600 .env

# Verify
ls -la .env
```

### False Positive Secret Detection

**Problem**: Pre-commit blocks legitimate code.

**Solutions**:

1. **Add to baseline**
   ```bash
   # Scan and create baseline
   detect-secrets scan > .secrets.baseline
   
   # Commit the baseline
   git add .secrets.baseline
   git commit -m "Update secrets baseline"
   ```

2. **Adjust detection**
   ```bash
   # Edit .pre-commit-config.yaml
   # Add to detect-secrets exclude pattern
   ```

3. **Last resort: Use inline pragma**
   ```python
   # Only if truly a false positive!
   api_key = "not-a-real-key"  # pragma: allowlist secret
   ```

### Can't Install Pre-commit

**Problem**: pip install fails.

**Solutions**:

1. **Update pip**
   ```bash
   python -m pip install --upgrade pip
   ```

2. **Use virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate
   pip install pre-commit
   ```

3. **Install system-wide (with sudo)**
   ```bash
   sudo pip install pre-commit
   ```

4. **Use alternative installation**
   ```bash
   # macOS
   brew install pre-commit
   
   # Ubuntu
   sudo apt-get install pre-commit
   ```

## Best Practices

### Daily Workflow

1. **Before starting work:**
   ```bash
   git pull
   source .env  # Load your secrets
   ```

2. **While working:**
   - Use environment variables, never hardcode secrets
   - Test locally with `.env` file
   - Run pre-commit hooks: `pre-commit run --all-files`

3. **Before committing:**
   ```bash
   git diff  # Review your changes
   git add .
   git commit -m "feat: your message"
   # Hooks run automatically
   ```

4. **If hooks fail:**
   - Read the error message
   - Fix the issue (remove secret, fix formatting)
   - Try committing again
   - Never use `git commit --no-verify`

### Secret Rotation

Rotate secrets regularly:

```bash
# Every 90 days:
# 1. Generate new secret in service
# 2. Update GitHub Secret
# 3. Update local .env
# 4. Test everything works
# 5. Revoke old secret
```

### Regular Maintenance

```bash
# Weekly: Check for secrets in history
git log --all --source --full-history -S "PRIVATE KEY" --oneline

# Monthly: Update dependencies
pip install -r requirements.txt --upgrade
pre-commit autoupdate

# Quarterly: Review configured secrets
# GitHub: Settings → Secrets and variables → Actions
# Remove any unused secrets
```

## Additional Resources

### Documentation

- **[SECRETS_MANAGEMENT.md](docs/SECRETS_MANAGEMENT.md)** - Comprehensive secrets guide
- **[SSH_KEY_SECURITY.md](docs/SSH_KEY_SECURITY.md)** - SSH key management
- **[SECURITY_CHECKLIST.md](docs/checklists/SECURITY_CHECKLIST.md)** - Security verification
- **[SECURITY.md](SECURITY.md)** - Security policy

### Example Files

- **[.env.example](.env.example)** - Template for local environment
- **[example-secrets-usage.yml](.github/workflows/example-secrets-usage.yml)** - Workflow examples

### External Resources

- [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Pre-commit Framework](https://pre-commit.com/)
- [detect-secrets](https://github.com/Yelp/detect-secrets)

### Commands Reference

```bash
# Pre-commit hooks
pre-commit install                    # Install hooks
pre-commit run --all-files           # Run all hooks
pre-commit autoupdate                # Update hook versions
pre-commit uninstall                 # Remove hooks

# Environment management
source .env                          # Load environment variables (bash)
chmod 600 .env                       # Secure .env file
cat .env.example                     # View example template

# Security scanning
detect-secrets scan                  # Scan for secrets
./scripts/security-check.sh          # Run security audit
git log -S "PRIVATE KEY" --oneline   # Search git history

# Git operations
git status                           # Check repository status
git diff --cached                    # Review staged changes
git reset HEAD file.txt              # Unstage a file
```

## Getting Help

### In Order of Preference

1. **Review documentation**
   - Check SECRETS_MANAGEMENT.md
   - Review SECURITY_CHECKLIST.md
   - See example workflow

2. **Run diagnostics**
   ```bash
   ./scripts/security-check.sh
   pre-commit run --all-files
   ```

3. **Check workflow runs**
   - GitHub Actions tab
   - Look for error messages

4. **Search issues**
   - Repository issues on GitHub
   - Look for similar problems

5. **Ask for help**
   - Open a new issue
   - Contact repository maintainers
   - Include error messages and what you've tried

## Summary Checklist

Use this checklist to verify your setup:

- [ ] Pre-commit hooks installed: `pre-commit install`
- [ ] Hooks tested successfully: `pre-commit run --all-files`
- [ ] Local .env file created from .env.example
- [ ] .env has correct permissions (600)
- [ ] .env is not tracked by git
- [ ] GitHub Secrets configured (if needed)
- [ ] Environment variables loading correctly
- [ ] Security check passes: `./scripts/security-check.sh`
- [ ] Example workflow reviewed
- [ ] Documentation read and understood

## Quick Reference

### Most Common Commands

```bash
# Setup
pip install pre-commit && pre-commit install

# Create local environment
cp .env.example .env && chmod 600 .env

# Test before committing
pre-commit run --all-files

# Check for secrets
detect-secrets scan

# Security audit
./scripts/security-check.sh
```

### Emergency: Exposed Secret

```bash
# 1. Revoke immediately in service provider
# 2. Remove from repository
git rm path/to/file

# 3. Generate new secret
# 4. Update .env and GitHub Secrets
# 5. Test everything works
# 6. Document incident
```

---

**Remember**: Security is easier when automated. Let the tools protect you!

**Need help?** Check [SECRETS_MANAGEMENT.md](docs/SECRETS_MANAGEMENT.md) for detailed guidance.

**Last Updated**: 2025-01-11
