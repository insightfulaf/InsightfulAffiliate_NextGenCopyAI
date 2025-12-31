# SSH Key Security - Quick Reference

## 🚨 Emergency: If You Exposed a Key

```bash
# 1. Revoke immediately on GitHub
# Go to: https://github.com/settings/keys
# Click "Delete" on the exposed key

# 2. Remove from local system
ssh-add -d ~/.ssh/id_ed25519  # Remove from agent
mv ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.COMPROMISED

# 3. Generate new key
ssh-keygen -t ed25519 -C "your_email@example.com"
chmod 600 ~/.ssh/id_ed25519

# 4. Add new key to GitHub
cat ~/.ssh/id_ed25519.pub | pbcopy
# Paste at: https://github.com/settings/keys

# 5. Test connection
ssh -T git@github.com
```

## ✅ Quick Setup (First Time)

```bash
# 1. Generate SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"

# 2. Set permissions
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# 3. Start SSH agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 4. Copy public key
cat ~/.ssh/id_ed25519.pub | pbcopy  # macOS
# or: cat ~/.ssh/id_ed25519.pub      # Display to copy

# 5. Add to GitHub: https://github.com/settings/keys

# 6. Test
ssh -T git@github.com
```

## 🔍 Quick Security Check

```bash
# Run automated security audit
./scripts/security-check.sh

# Check for secrets
detect-secrets scan

# Verify SSH setup
ssh-add -l                    # List loaded keys
ssh -T git@github.com        # Test GitHub connection
git remote -v                 # Verify remote uses SSH
```

## 📝 Before Every Commit

```bash
# Review what you're committing
git status
git diff

# Run pre-commit checks
pre-commit run --all-files

# Check for secrets
git diff --cached | grep -i "password\|secret\|key"
```

## 🛠️ Security Tools Setup

```bash
# Install security tools
pip install -r requirements.txt

# Set up pre-commit hooks
pre-commit install

# Create SSH config (optional but recommended)
cat >> ~/.ssh/config << 'EOF'
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
chmod 600 ~/.ssh/config
```

## ❌ NEVER Do This

```bash
# DON'T commit private keys
git add ~/.ssh/id_ed25519          # ❌ NEVER!

# DON'T store keys in repo directory
cp ~/.ssh/id_ed25519 ./project/    # ❌ NEVER!

# DON'T share private keys
email id_ed25519 to someone        # ❌ NEVER!
```

## ✅ DO This Instead

```bash
# DO use SSH agent
ssh-add ~/.ssh/id_ed25519          # ✅ Good

# DO store keys in ~/.ssh/ only
ls ~/.ssh/id_ed25519               # ✅ Good

# DO share public keys only
cat ~/.ssh/id_ed25519.pub          # ✅ Good
```

## 📚 Full Documentation

- **Complete Guide**: [docs/SSH_KEY_SECURITY.md](../SSH_KEY_SECURITY.md)
- **Security Checklist**: [docs/checklists/SECURITY_CHECKLIST.md](../checklists/SECURITY_CHECKLIST.md)
- **Contributing Guide**: [CONTRIBUTING.md](../../CONTRIBUTING.md)
- **Security Policy**: [SECURITY.md](../../SECURITY.md)

## 🤖 Using the SSH Key Manager Agent

This repository includes a specialized Copilot agent for SSH security:

```
# In GitHub Copilot, you can ask:
"@ssh-key-manager help me set up SSH keys securely"
"@ssh-key-manager I accidentally committed a key, what do I do?"
"@ssh-key-manager check my SSH security setup"
```

The agent has deep knowledge of SSH security and can provide personalized guidance.

## 🔗 Quick Links

- [GitHub SSH Settings](https://github.com/settings/keys)
- [GitHub SSH Documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [Repository Security Policy](../../SECURITY.md)

## 💡 Pro Tips

1. **Use Ed25519 keys** - They're more secure and faster than RSA
2. **Use passphrases** - Always protect private keys with strong passphrases
3. **Rotate regularly** - Generate new keys every 1-2 years
4. **One key per device** - Don't share keys between computers
5. **Test before pushing** - Run security checks before every commit

## ⚡ Common Commands

```bash
# List loaded SSH keys
ssh-add -l

# Remove all keys from agent
ssh-add -D

# Add key to agent
ssh-add ~/.ssh/id_ed25519

# Test GitHub connection
ssh -T git@github.com

# Check key permissions
ls -la ~/.ssh/

# View public key
cat ~/.ssh/id_ed25519.pub

# Run security audit
./scripts/security-check.sh
```

## 🆘 Getting Help

1. **Read the docs**: Start with [SSH_KEY_SECURITY.md](../SSH_KEY_SECURITY.md)
2. **Run security check**: `./scripts/security-check.sh`
3. **Ask the agent**: Use `@ssh-key-manager` in Copilot
4. **Open an issue**: For repository-specific questions
5. **Contact maintainers**: For security incidents

---

**Remember**: Security is not optional. Take the time to do it right!

**Last Updated**: 2025-12-30
