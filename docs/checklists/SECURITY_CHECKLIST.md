# Security Checklist

Use this checklist to ensure your development environment follows security best practices for this repository.

## Initial Setup

- [ ] Read the [SSH Key Security Guide](../SSH_KEY_SECURITY.md)
- [ ] Install pre-commit hooks: `pip install pre-commit && pre-commit install`
- [ ] Verify .gitignore excludes SSH keys and credentials
- [ ] Configure git credential helper (macOS: `git config --global credential.helper osxkeychain`)

## SSH Key Management

- [ ] SSH keys stored ONLY in `~/.ssh/` directory (never in repository)
- [ ] Private keys have correct permissions (600): `chmod 600 ~/.ssh/id_ed25519`
- [ ] Public keys have correct permissions (644): `chmod 644 ~/.ssh/id_ed25519.pub`
- [ ] Private keys protected with strong passphrases
- [ ] Public key added to GitHub account
- [ ] SSH connection tested: `ssh -T git@github.com`
- [ ] SSH agent configured for automatic key loading

## Repository Security

- [ ] No private keys committed to repository
- [ ] No API keys or tokens in code (use environment variables)
- [ ] `.env` files listed in .gitignore
- [ ] Sensitive configuration files excluded from version control
- [ ] Git remote uses SSH URL: `git@github.com:user/repo.git`

## Code Security

- [ ] API keys loaded from environment variables (never hardcoded)
- [ ] Sensitive data stored in `.env` files (not committed)
- [ ] Third-party dependencies reviewed for vulnerabilities
- [ ] Pre-commit hooks running successfully
- [ ] No credentials in code comments

## Regular Maintenance

- [ ] Review git history for accidentally committed secrets: `git log --all -S "BEGIN PRIVATE KEY"`
- [ ] Rotate SSH keys every 1-2 years
- [ ] Update dependencies regularly: `pip install -r requirements.txt --upgrade`
- [ ] Run security scans: `detect-secrets scan`
- [ ] Review and revoke unused SSH keys on GitHub

## Before Each Commit

- [ ] Run pre-commit hooks: `pre-commit run --all-files`
- [ ] Review staged files: `git diff --cached`
- [ ] Ensure no sensitive data in commit: `git diff --cached | grep -i "password\|secret\|key"`
- [ ] Verify .gitignore is working for sensitive files

## Emergency Response (If Key Exposed)

If you accidentally expose an SSH key or credential:

1. [ ] **STOP** - Do not make additional commits
2. [ ] Remove the exposed file from working directory
3. [ ] Revoke the key on GitHub immediately (Settings → SSH and GPG keys)
4. [ ] Delete local private key
5. [ ] Generate new SSH key pair
6. [ ] Add new public key to GitHub
7. [ ] Remove from git history (if needed): See [SSH_KEY_SECURITY.md](../SSH_KEY_SECURITY.md)
8. [ ] Document the incident
9. [ ] Review and strengthen security practices
10. [ ] Set up additional preventive measures

## Team Collaboration

- [ ] All team members have read the security documentation
- [ ] Team uses SSH keys (not HTTPS passwords) for authentication
- [ ] Each team member has unique SSH keys (no shared keys)
- [ ] Security practices discussed in onboarding
- [ ] Process for reporting security issues established

## Verification Commands

Run these commands to verify your security setup:

```bash
# Check SSH key permissions
ls -la ~/.ssh/id_ed25519*

# Verify SSH agent has your key
ssh-add -l

# Test GitHub SSH connection
ssh -T git@github.com

# Verify git remote uses SSH
git remote -v

# Check for secrets in repository
git log --all --source --full-history -S "BEGIN PRIVATE KEY" --oneline

# Run pre-commit checks
pre-commit run --all-files

# Scan for secrets
detect-secrets scan
```

## Resources

- [SSH Key Security Guide](../SSH_KEY_SECURITY.md) - Comprehensive SSH security documentation
- [CONTRIBUTING.md](../../CONTRIBUTING.md) - Repository contribution guidelines
- [GitHub SSH Documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/) - Web security risks

## Questions?

If you have questions about any security practices or need help:

1. Review the [SSH Key Security Guide](../SSH_KEY_SECURITY.md)
2. Check [CONTRIBUTING.md](../../CONTRIBUTING.md)
3. Open an issue in the repository
4. Contact repository maintainers

## Remember

**Security is everyone's responsibility!**

- When in doubt, ask before committing
- Better to over-communicate security concerns than under-communicate
- Never share private keys or credentials
- Report security incidents immediately

---

**Last Updated**: 2024-12-30
**Review Frequency**: Quarterly or after security incidents
