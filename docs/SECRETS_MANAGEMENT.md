# GitHub Secrets Management Guide

## Overview

This guide explains how to securely manage secrets in GitHub Actions workflows and the repository. Following these practices ensures credentials never leak into source code or logs.

## Table of Contents

1. [GitHub Secrets Overview](#github-secrets-overview)
2. [Setting Up GitHub Secrets](#setting-up-github-secrets)
3. [Using Secrets in Workflows](#using-secrets-in-workflows)
4. [Best Practices](#best-practices)
5. [Local Development](#local-development)
6. [Migration from Hardcoded Secrets](#migration-from-hardcoded-secrets)
7. [Common Secrets Needed](#common-secrets-needed)
8. [Emergency Response](#emergency-response)
9. [Troubleshooting](#troubleshooting)

## GitHub Secrets Overview

GitHub Secrets provide a secure way to store sensitive information that workflows need to access. Secrets are:

- **Encrypted**: Automatically encrypted in GitHub's database
- **Masked in logs**: Never appear in workflow logs
- **Scoped**: Can be repository, organization, or environment-specific
- **Access-controlled**: Only accessible by authorized workflows

### Types of Secrets

1. **Repository Secrets**: Available to all workflows in a repository
2. **Environment Secrets**: Available only when deploying to specific environments
3. **Organization Secrets**: Shared across multiple repositories

## Setting Up GitHub Secrets

### Adding Repository Secrets

1. Navigate to your repository on GitHub
2. Go to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Enter the secret name (uppercase with underscores, e.g., `OPENAI_API_KEY`)
5. Paste the secret value
6. Click **Add secret**

### Adding Organization Secrets (for teams)

1. Go to your organization's settings
2. Navigate to **Secrets and variables** → **Actions**
3. Click **New organization secret**
4. Set repository access (all repositories or selected ones)
5. Enter name and value
6. Click **Add secret**

### Adding Environment Secrets

1. Go to **Settings** → **Environments**
2. Create or select an environment (e.g., `production`, `staging`)
3. Add environment secrets specific to that deployment
4. Configure environment protection rules if needed

## Using Secrets in Workflows

### Basic Secret Usage

```yaml
name: Example Workflow

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Use secret in environment variable
        env:
          API_KEY: ${{ secrets.OPENAI_API_KEY }}
        run: |
          # The secret is now available as an environment variable
          echo "Using API key for deployment..."
          # Never echo the secret itself!
```

### SSH Key Usage

For SSH operations, store private keys as secrets and use them securely:

```yaml
name: SSH Deployment

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Configure SSH
        env:
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
        run: |
          # Create .ssh directory
          mkdir -p ~/.ssh
          chmod 700 ~/.ssh
          
          # Write the private key
          echo "$SSH_PRIVATE_KEY" > ~/.ssh/deploy_key
          chmod 600 ~/.ssh/deploy_key
          
          # Configure SSH to use the key
          cat >> ~/.ssh/config << EOF
          Host deploy-server
            HostName example.com
            User deploy
            IdentityFile ~/.ssh/deploy_key
            StrictHostKeyChecking no
          EOF
          chmod 600 ~/.ssh/config
      
      - name: Deploy via SSH
        run: |
          ssh deploy-server 'cd /var/www && git pull'
```

### Multiple Secrets

```yaml
name: Multi-Service Deployment

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Deploy with multiple credentials
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
          API_TOKEN: ${{ secrets.API_TOKEN }}
        run: |
          # All secrets available as environment variables
          ./deploy.sh
```

### Environment-Specific Secrets

```yaml
name: Environment Deployment

on: [push]

jobs:
  deploy-staging:
    runs-on: ubuntu-latest
    environment: staging
    
    steps:
      - name: Deploy to staging
        env:
          API_KEY: ${{ secrets.API_KEY }}  # Uses staging environment secret
        run: ./deploy.sh staging
  
  deploy-production:
    runs-on: ubuntu-latest
    environment: production
    needs: deploy-staging
    
    steps:
      - name: Deploy to production
        env:
          API_KEY: ${{ secrets.API_KEY }}  # Uses production environment secret
        run: ./deploy.sh production
```

### Using with Third-Party Actions

```yaml
name: Deploy with Third-Party Action

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      # Many actions accept secrets as inputs
      - name: Deploy to Heroku
        uses: akhileshns/heroku-deploy@v3.12.14
        with:
          heroku_api_key: ${{ secrets.HEROKU_API_KEY }}
          heroku_app_name: "my-app"
          heroku_email: "user@example.com"
```

## Best Practices

### Secret Naming Conventions

✅ **DO:**
- Use UPPERCASE with underscores: `API_KEY`, `DATABASE_URL`
- Be descriptive: `OPENAI_API_KEY` not just `KEY`
- Include service name: `STRIPE_SECRET_KEY`, `AWS_ACCESS_KEY_ID`

❌ **DON'T:**
- Use lowercase or mixed case
- Use vague names
- Include the word "secret" (it's implied)

### Security Guidelines

1. **Never log secrets**
   ```yaml
   # ❌ BAD - Don't do this!
   - name: Debug (WRONG)
     run: echo "API Key is ${{ secrets.API_KEY }}"
   
   # ✅ GOOD - Safe debugging
   - name: Debug (CORRECT)
     run: echo "API Key is configured"
   ```

2. **Use environment variables, not direct substitution**
   ```yaml
   # ❌ BAD - Secret in command
   - run: curl -H "Authorization: Bearer ${{ secrets.API_KEY }}" api.example.com
   
   # ✅ GOOD - Secret in environment
   - env:
       API_KEY: ${{ secrets.API_KEY }}
     run: curl -H "Authorization: Bearer $API_KEY" api.example.com
   ```

3. **Limit secret access**
   - Use environment secrets for production credentials
   - Require approvals for production deployments
   - Use organization secrets sparingly

4. **Rotate secrets regularly**
   - Set up a rotation schedule (every 90 days)
   - Document when secrets were last rotated
   - Update all places when rotating

5. **Minimal permissions**
   - Grant secrets only the minimum required permissions
   - Use service-specific tokens when possible
   - Avoid using root/admin credentials

### Secret Hygiene

- **Audit regularly**: Review which secrets are configured and still needed
- **Remove unused secrets**: Delete old or unused secrets immediately
- **Document secrets**: Maintain a list of what each secret is for
- **Monitor usage**: Check workflow runs for unauthorized secret access

## Local Development

### Using .env Files

For local development, use `.env` files (already in `.gitignore`):

```bash
# Create .env file (never commit this!)
cat > .env << 'EOF'
OPENAI_API_KEY=sk-xxxxxxxxxxxxx
DATABASE_URL=postgresql://localhost/mydb
API_TOKEN=abc123def456
EOF

# Set proper permissions
chmod 600 .env
```

### Loading Environment Variables

**Python:**
```python
import os
from dotenv import load_dotenv

# Load .env file
load_dotenv()

# Access secrets
api_key = os.getenv('OPENAI_API_KEY')
database_url = os.getenv('DATABASE_URL')
```

**Node.js:**
```javascript
require('dotenv').config();

const apiKey = process.env.OPENAI_API_KEY;
const databaseUrl = process.env.DATABASE_URL;
```

**Bash:**
```bash
# Load from .env
export $(grep -v '^#' .env | xargs)

# Or use source
source .env

# Or with set -a
set -a
source .env
set +a
```

### Example .env.example File

Create a `.env.example` file to document required secrets (this IS committed):

```bash
# .env.example - Copy to .env and fill in actual values

# OpenAI API Configuration
OPENAI_API_KEY=your_openai_api_key_here

# Database Configuration
DATABASE_URL=postgresql://user:password@localhost/dbname

# API Authentication
API_TOKEN=your_api_token_here

# AWS Credentials (optional)
AWS_ACCESS_KEY_ID=your_aws_key_id_here
AWS_SECRET_ACCESS_KEY=your_aws_secret_key_here
```

## Migration from Hardcoded Secrets

### Step 1: Identify Hardcoded Secrets

Search your codebase for hardcoded secrets:

```bash
# Search for common patterns
grep -r "api_key\s*=\s*['\"]" .
grep -r "password\s*=\s*['\"]" .
grep -r "token\s*=\s*['\"]" .

# Use secret detection tools
detect-secrets scan
```

### Step 2: Extract to Environment Variables

**Before (❌ BAD):**
```python
# Don't do this!
OPENAI_API_KEY = "sk-xxxxxxxxxxxxx"
DATABASE_URL = "postgresql://user:pass@host/db"
```

**After (✅ GOOD):**
```python
import os

OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')
DATABASE_URL = os.getenv('DATABASE_URL')

# Add validation
if not OPENAI_API_KEY:
    raise ValueError("OPENAI_API_KEY environment variable is required")
```

### Step 3: Add to GitHub Secrets

Add each secret to GitHub:
1. Repository Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add the secret name and value

### Step 4: Update Workflows

Update your workflows to use the secrets:

```yaml
- name: Run script with secrets
  env:
    OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
    DATABASE_URL: ${{ secrets.DATABASE_URL }}
  run: python script.py
```

### Step 5: Create .env.example

Document required environment variables:

```bash
# Copy all secret names to .env.example with placeholder values
# Commit .env.example (but never .env!)
```

### Step 6: Test Locally

```bash
# Create your local .env
cp .env.example .env

# Fill in actual values
nano .env

# Test the application
python script.py
```

## Common Secrets Needed

### This Repository

Based on the repository's needs, you may need these secrets:

1. **OPENAI_API_KEY**
   - Purpose: AI content generation via OpenAI API
   - Format: `sk-...` (starts with sk-)
   - Where to get: [OpenAI Platform](https://platform.openai.com/api-keys)

2. **SSH_PRIVATE_KEY**
   - Purpose: Deployment via SSH
   - Format: Full private key content
   - How to create: See [SSH_KEY_SECURITY.md](SSH_KEY_SECURITY.md)

3. **GITHUB_TOKEN**
   - Purpose: GitHub API access (automatically provided)
   - Format: `ghp_...`
   - Note: Available as `${{ secrets.GITHUB_TOKEN }}` in workflows

### Optional Secrets

4. **AWS_ACCESS_KEY_ID** and **AWS_SECRET_ACCESS_KEY**
   - Purpose: AWS service access
   - Where to get: AWS IAM Console

5. **DATABASE_URL**
   - Purpose: Database connection
   - Format: `postgresql://user:pass@host:port/dbname`

6. **SYSTEME_IO_API_KEY**
   - Purpose: Systeme.io integration
   - Where to get: Systeme.io account settings

## Emergency Response

### If a Secret is Exposed

**Act immediately!**

1. **Revoke the secret**
   - Go to the service provider (OpenAI, AWS, etc.)
   - Immediately revoke/delete the exposed credential

2. **Remove from repository**
   ```bash
   # If in working directory
   git rm path/to/file
   git commit -m "security: Remove exposed secret"
   
   # If in git history, see git-filter-repo instructions below
   ```

3. **Rotate the secret**
   - Generate a new credential
   - Update GitHub Secret
   - Update local `.env` files

4. **Update GitHub Secrets**
   - Delete the old secret from GitHub
   - Add the new secret

5. **Clean git history** (if needed)
   ```bash
   # Use git-filter-repo to remove from history
   pip install git-filter-repo
   git filter-repo --path path/to/secret --invert-paths
   
   # Force push (coordinate with team!)
   git push --force --all
   ```

6. **Audit and monitor**
   - Check for unauthorized usage
   - Review access logs on the service
   - Enable additional monitoring if available

7. **Document the incident**
   - What was exposed
   - How long it was exposed
   - Actions taken
   - Preventive measures added

### If You Accidentally Commit a Secret

**Before pushing:**

```bash
# Undo the commit
git reset HEAD~1

# Remove the secret from files
# Add to GitHub Secrets instead

# Commit without the secret
git add .
git commit -m "Your commit message"
```

**After pushing:**

Follow the emergency response steps above. The secret is now considered compromised.

## Troubleshooting

### Secret Not Available in Workflow

**Problem**: Workflow can't access a secret.

**Solutions**:

1. **Check secret name matches exactly**
   ```yaml
   # Names are case-sensitive!
   env:
     API_KEY: ${{ secrets.API_KEY }}  # Not api_key or Api_Key
   ```

2. **Verify secret is configured**
   - Go to Settings → Secrets and variables → Actions
   - Confirm the secret exists

3. **Check workflow permissions**
   - Ensure workflow has permission to access secrets
   - For organization secrets, check repository access

4. **Environment secrets require environment**
   ```yaml
   jobs:
     deploy:
       environment: production  # Required for environment secrets
   ```

### Secret Value Not Working

**Problem**: Secret is set but application fails.

**Solutions**:

1. **Check for extra whitespace**
   - GitHub preserves exact secret values
   - Remove leading/trailing spaces when setting

2. **Verify secret format**
   - Some secrets need specific formats
   - Check service documentation

3. **Test with a dummy value locally**
   - Use `.env` to test the format
   - Once working, update GitHub Secret

### Can't See Secret Value

**Problem**: Need to verify secret but can't see it.

**This is by design!** Secrets are intentionally hidden.

**Workarounds**:

1. **Test with a known-good value**
   - Set to a test value you know works
   - If workflow succeeds, format is correct

2. **Check service logs**
   - Some services log authentication attempts
   - Check if credential is being received correctly

3. **Use workflow debugging**
   ```yaml
   - name: Test secret is set
     run: |
       if [ -z "$API_KEY" ]; then
         echo "Secret is not set!"
         exit 1
       else
         echo "Secret is configured"
       fi
     env:
       API_KEY: ${{ secrets.API_KEY }}
   ```

### Pre-commit Hooks Blocking Commit

**Problem**: Pre-commit hooks detect a secret.

**This is good!** The hooks are protecting you.

**Actions**:

1. **Remove the secret from files**
   - Store in `.env` for local development
   - Add to GitHub Secrets for workflows

2. **If it's a false positive**
   - Add to `.secrets.baseline`:
     ```bash
     detect-secrets scan > .secrets.baseline
     ```

3. **Never bypass the hooks**
   - Don't use `--no-verify`
   - Fix the actual issue

## Additional Resources

### Related Documentation

- [SSH Key Security Guide](SSH_KEY_SECURITY.md) - SSH key management
- [Security Checklist](checklists/SECURITY_CHECKLIST.md) - Security verification
- [SECURITY.md](../SECURITY.md) - Repository security policy
- [Example Secrets Usage Workflow](../.github/workflows/example-secrets-usage.yml) - Working examples

### External Resources

- [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [GitHub Actions Security Best Practices](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [OWASP Secrets Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)

### Tools

- **detect-secrets**: `pip install detect-secrets` - Local secret scanning
- **git-secrets**: Prevents committing secrets
- **git-filter-repo**: Clean secrets from history
- **dotenv**: Load `.env` files (Python: `python-dotenv`, Node: `dotenv`)

## Summary

**Key Takeaways:**

1. ✅ Use GitHub Secrets for all credentials in workflows
2. ✅ Use `.env` files for local development (never commit!)
3. ✅ Always use environment variables, never hardcode
4. ✅ Rotate secrets regularly
5. ✅ Audit and remove unused secrets
6. ❌ Never log or echo secret values
7. ❌ Never commit secrets to git
8. ❌ Never share secrets via email/chat
9. 🚨 If exposed, revoke immediately and rotate

**Need Help?**

- Review this guide and related documentation
- Check the [example workflow](../.github/workflows/example-secrets-usage.yml)
- Open an issue in the repository
- Contact repository maintainers

**Remember**: Proper secrets management is essential for security. When in doubt, ask before committing!

---

**Last Updated**: 2025-01-11
**Review Frequency**: Quarterly or after security incidents
