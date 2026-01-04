# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in this repository, please report it responsibly:

1. **DO NOT** create a public GitHub issue for security vulnerabilities
2. **Email** the repository maintainers directly with details
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

We will acknowledge your report within 48 hours and provide regular updates on our progress.

## Security Best Practices

This repository contains AI-powered content generation tools and marketing materials. To maintain security:

### For Contributors

1. **Never commit private keys or credentials**
   - SSH keys should ONLY be stored in `~/.ssh/`
   - Use environment variables for API keys
   - Review [SSH Key Security Guide](docs/SSH_KEY_SECURITY.md)

2. **Use secure authentication**
   - SSH keys (recommended) over HTTPS passwords
   - Enable 2FA on your GitHub account
   - Use strong passphrases for SSH keys

3. **Follow the security checklist**
   - Review [Security Checklist](docs/checklists/SECURITY_CHECKLIST.md)
   - Run `./scripts/security-check.sh` before committing
   - Install pre-commit hooks: `pre-commit install`

4. **Keep dependencies updated**
   - Regularly update Python packages
   - Review security advisories
   - Use `pip install -r requirements.txt --upgrade`

### For Users

1. **API Key Management**
   - Store OpenAI API keys in environment variables
   - Never hardcode API keys in scripts
   - Use `.env` files (excluded from git)

2. **Repository Access**
   - Use SSH for git operations
   - Keep your SSH keys secure
   - Rotate keys regularly (every 1-2 years)

## Security Features

This repository implements multiple security layers:

### Automated Security Scanning

- **GitHub Actions**: Automated secret scanning on pull requests
- **Pre-commit Hooks**: Local scanning before commits
- **detect-secrets**: Baseline secret detection
- **Git History Checks**: Scanning for accidentally committed secrets (with smart exclusions for documentation and archived examples)
- **TruffleHog**: Entropy-based secret detection with optimized performance (excludes archives and non-essential directories)

### Prevention Measures

- **Comprehensive .gitignore**: Excludes SSH keys, credentials, and sensitive files
- **SSH Key Manager Agent**: Specialized security agent for key management
- **Documentation**: Detailed guides for secure practices
- **Security Scripts**: Automated security audit tools

### Files and Tools

- `.github/workflows/security-scan.yml` - CI/CD security scanning
- `.pre-commit-config.yaml` - Pre-commit hook configuration
- `.secrets.baseline` - Baseline for detect-secrets
- `scripts/security-check.sh` - Security audit script
- `.github/agents/ssh-key-manager.yml` - SSH key management agent

## Emergency Response

### If You Accidentally Commit a Secret

**Act immediately!**

1. **Stop** - Do not make additional commits
2. **Remove** - Delete the secret from your working directory
3. **Revoke** - Revoke the compromised credential immediately
   - SSH keys: Remove from GitHub (Settings → SSH and GPG keys)
   - API keys: Regenerate in the service provider
4. **Rotate** - Generate new credentials
5. **Clean History** - If committed, see [SSH Key Security Guide](docs/SSH_KEY_SECURITY.md)
6. **Document** - Report the incident to maintainers

### History Cleanup

If a secret was committed to git history:

```bash
# WARNING: This rewrites history. Coordinate with team first!

# Option 1: git-filter-repo (recommended)
pip install git-filter-repo
git filter-repo --path path/to/secret --invert-paths

# Option 2: BFG Repo-Cleaner
java -jar bfg.jar --delete-files filename

# Force push after cleanup (affects all collaborators)
git push --force --all
```

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| Latest  | :white_check_mark: |
| < Latest| :x:                |

We recommend always using the latest version of this repository.

## Security Tools

### Required Tools

- **detect-secrets**: `pip install detect-secrets`
- **pre-commit**: `pip install pre-commit`

### Optional Tools

- **git-secrets**: Prevents committing secrets
- **TruffleHog**: Finds secrets in git history (optimized with exclusions)
- **git-filter-repo**: Clean secrets from history

### Performance Optimizations

The security scanning workflow has been optimized for faster execution:

- **Smart Directory Exclusions**: Archives, review files, and documentation examples are excluded from scans
- **TruffleHog Optimization**: Configured to skip large archived directories and binary files (~3-5x faster)
- **Git History Filtering**: Only scans relevant history, excluding documented examples and workflow files
- **Commit Range Scanning**: For PRs, scans only new commits being introduced (not entire repository history)

### Excluded from Security Scans

The following directories and files contain examples, documentation, or archived content and are excluded from security scans. **Note:** Different security tools use different exclusion patterns as detailed below.

#### Pre-commit Hook Exclusions

The `prevent-ssh-key-content` pre-commit hook excludes these specific files and directories:
- `docs/SSH_KEY_SECURITY.md` - SSH key security documentation with example patterns
- `docs/SSH_SECURITY_SUMMARY.md` - SSH security implementation summary
- `.github/secret-scanning.yml` - Secret scanning pattern definitions
- `Archive_ready_to_sync/**` - Historical backup files
- `archive/**` - Archived content
- `REVIEW_PENDING/**` - Files pending review

#### Security Script and Workflow Exclusions

The `security-check.sh` script and GitHub Actions workflows use broader exclusion patterns:
- `.github/**` - All GitHub configuration and workflow files (to avoid false positives from pattern matching)
- `docs/**` - Documentation and generated AI outputs (excluded by GitHub workflow to avoid false positives from example content)
- `Archive_ready_to_sync/**` - Historical backup files
- `archive/**` - Archived content
- `REVIEW_PENDING/**` - Files pending review
- `.secrets.baseline` - Detect-secrets baseline configuration
- `.pre-commit-config.yaml` - Pre-commit hook configuration
- `scripts/security-check.sh` - The security script itself

**Note:** The GitHub workflow uses mixed patterns (`.github/` without `**` in some places, `.github/**` in others) depending on the git command used. Both patterns effectively exclude the `.github` directory.

### Installation

```bash
# Install all security tools
pip install -r requirements.txt

# Set up pre-commit hooks
pre-commit install

# Run security audit
./scripts/security-check.sh
```

## Security Verification

Before committing, verify your setup:

```bash
# Run security check script
./scripts/security-check.sh

# Run pre-commit hooks
pre-commit run --all-files

# Scan for secrets
detect-secrets scan

# Check git status
git status

# Review changes
git diff
```

## Resources

### Documentation

- [SSH Key Security Guide](docs/SSH_KEY_SECURITY.md) - Comprehensive SSH security
- [Security Checklist](docs/checklists/SECURITY_CHECKLIST.md) - Security verification
- [Contributing Guide](CONTRIBUTING.md) - Repository contribution guidelines

### External Resources

- [GitHub SSH Documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [detect-secrets Documentation](https://github.com/Yelp/detect-secrets)
- [pre-commit Framework](https://pre-commit.com/)

## Security Updates

We regularly update security measures:

- **Monthly**: Dependency updates and security patches
- **Quarterly**: Security documentation review
- **As Needed**: Response to security incidents

## Contact

For security concerns:

1. Review documentation first
2. Run security audit: `./scripts/security-check.sh`
3. Contact repository maintainers
4. For vulnerabilities, use responsible disclosure

## Acknowledgments

We thank all security researchers and contributors who help keep this repository secure.

---

**Remember**: Security is everyone's responsibility. When in doubt, ask!

**Last Updated**: 2025-12-30
