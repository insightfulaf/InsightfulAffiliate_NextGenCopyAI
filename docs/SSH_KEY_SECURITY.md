# SSH Key Security Guide

## Overview

This document provides comprehensive guidance for securely managing SSH keys when working with this repository. Following these practices will help prevent accidental key exposure and maintain the security of your development environment.

## Table of Contents

1. [Quick Start](#quick-start)
2. [SSH Key Generation](#ssh-key-generation)
3. [Secure Storage](#secure-storage)
4. [SSH Agent Configuration](#ssh-agent-configuration)
5. [GitHub Integration](#github-integration)
6. [What NOT to Do](#what-not-to-do)
7. [Emergency Response](#emergency-response)
8. [Verification & Testing](#verification--testing)
9. [Troubleshooting](#troubleshooting)

## Quick Start

**Recommended workflow for new contributors:**

```bash
# 1. Generate an SSH key (if you don't have one)
ssh-keygen -t ed25519 -C "your_email@example.com"

# 2. Start SSH agent and add your key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 3. Copy your PUBLIC key to clipboard
cat ~/.ssh/id_ed25519.pub | pbcopy  # macOS
# or: cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard  # Linux

# 4. Add the public key to GitHub
# Go to: GitHub → Settings → SSH and GPG keys → New SSH key

# 5. Test your connection
ssh -T git@github.com
```

## SSH Key Generation

### Recommended: Ed25519 Keys

Ed25519 is the modern, secure, and performant choice:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

**When prompted:**
- **File location**: Press Enter to accept default (`~/.ssh/id_ed25519`)
- **Passphrase**: Use a strong passphrase (highly recommended)

### Alternative: RSA Keys

For compatibility with older systems:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

### Key Generation Best Practices

- ✅ **DO** use a strong passphrase to encrypt your private key
- ✅ **DO** use descriptive comments (-C flag) to identify keys
- ✅ **DO** store keys in the default ~/.ssh/ directory
- ❌ **DON'T** generate keys without a passphrase
- ❌ **DON'T** store keys in the repository directory
- ❌ **DON'T** use weak algorithms (DSA, RSA < 2048 bits)

## Secure Storage

### Proper Directory Structure

```
~/.ssh/
├── id_ed25519          # Your private key (permissions: 600)
├── id_ed25519.pub      # Your public key (permissions: 644)
├── known_hosts         # Server fingerprints (permissions: 644)
├── config              # SSH client config (permissions: 600)
└── authorized_keys     # Authorized public keys (permissions: 644)
```

### Setting Correct Permissions

**Critical**: SSH will refuse to use keys with incorrect permissions.

```bash
# Secure your .ssh directory
chmod 700 ~/.ssh

# Private key: readable/writable only by you
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_rsa

# Public key: readable by all (but only writable by you)
chmod 644 ~/.ssh/id_ed25519.pub
chmod 644 ~/.ssh/id_rsa.pub

# SSH config
chmod 600 ~/.ssh/config

# Known hosts and authorized keys
chmod 644 ~/.ssh/known_hosts
chmod 644 ~/.ssh/authorized_keys
```

### What Permissions Mean

- **600**: Owner can read/write, no one else can access
- **644**: Owner can read/write, others can only read
- **700**: Owner has full access, no one else can access

## SSH Agent Configuration

SSH agent securely stores your decrypted private keys in memory, so you don't have to enter your passphrase repeatedly.

### macOS Configuration

**Add to your ~/.ssh/config:**

```ssh-config
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519

Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  AddKeysToAgent yes
  UseKeychain yes
```

**Start SSH agent and add key:**

```bash
# Start the agent
eval "$(ssh-agent -s)"

# Add key to agent (macOS-specific with Keychain integration)
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# List loaded keys
ssh-add -l
```

### Linux Configuration

**Add to your ~/.ssh/config:**

```ssh-config
Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519

Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  AddKeysToAgent yes
```

**Start SSH agent and add key:**

```bash
# Start the agent
eval "$(ssh-agent -s)"

# Add key to agent
ssh-add ~/.ssh/id_ed25519

# List loaded keys
ssh-add -l
```

### Auto-starting SSH Agent

**For Bash (~/.bashrc or ~/.bash_profile):**

```bash
# Auto-start SSH agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null
fi
```

**For Zsh (~/.zshrc):**

```zsh
# Auto-start SSH agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null
fi
```

## GitHub Integration

### Adding Your Public Key to GitHub

1. Copy your **public** key to clipboard:
   ```bash
   # macOS
   cat ~/.ssh/id_ed25519.pub | pbcopy
   
   # Linux with xclip
   cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
   
   # Or simply display it to copy manually
   cat ~/.ssh/id_ed25519.pub
   ```

2. Go to GitHub: [Settings → SSH and GPG keys](https://github.com/settings/keys)

3. Click "New SSH key"

4. Add a descriptive title (e.g., "MacBook Pro 2024")

5. Paste your public key

6. Click "Add SSH key"

### Testing Your GitHub Connection

```bash
# Test SSH connection to GitHub
ssh -T git@github.com

# Expected output:
# Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

### Verbose Testing (for troubleshooting)

```bash
# Run with verbose output to see what's happening
ssh -vT git@github.com
```

### Using SSH with Git

**Clone a repository with SSH:**

```bash
git clone git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```

**Switch existing repository to SSH:**

```bash
git remote set-url origin git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```

**Verify remote URL:**

```bash
git remote -v
# Should show: git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```

## What NOT to Do

### ❌ NEVER Do These Things

1. **NEVER commit private keys to git**
   ```bash
   # BAD - Don't do this!
   git add ~/.ssh/id_ed25519
   ```

2. **NEVER store keys in the repository directory**
   ```bash
   # BAD - Don't do this!
   cp ~/.ssh/id_ed25519 ./my-project/keys/
   ```

3. **NEVER share private keys via email, Slack, or messaging**
   - Private keys should NEVER leave your machine
   - If someone needs access, they generate their own key pair

4. **NEVER use keys without passphrases for important accounts**
   - Always protect private keys with strong passphrases

5. **NEVER ignore file permission warnings**
   ```
   # If you see this warning, fix permissions immediately:
   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   @         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   ```

6. **NEVER create keys with command output as filename**
   ```bash
   # BAD - This creates a file with the command as the name!
   eval "$(ssh-agent -s)" > my_key
   # Creates files named: eval "$(ssh-agent -s)"
   ```

### Common Mistakes to Avoid

- Don't paste private key content in support tickets
- Don't screenshot private keys
- Don't upload keys to cloud storage services
- Don't use the same key for everything (use different keys for different purposes)
- Don't forget to rotate keys periodically (every 1-2 years)

## Emergency Response

### If You Accidentally Exposed a Private Key

**Act immediately! Follow these steps:**

#### 1. Immediate Actions (Do Now)

```bash
# A. Stop using the compromised key immediately
ssh-add -d ~/.ssh/id_ed25519  # Remove from agent

# B. Delete the compromised key pair
mv ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.COMPROMISED
mv ~/.ssh/id_ed25519.pub ~/.ssh/id_ed25519.pub.COMPROMISED
```

#### 2. Revoke the Key on GitHub

1. Go to GitHub: [Settings → SSH and GPG keys](https://github.com/settings/keys)
2. Find the compromised key
3. Click "Delete" to revoke it

#### 3. Remove from Repository

```bash
# If the key is in your working directory
git rm "path/to/exposed/key"
git commit -m "security: Remove accidentally committed SSH key"
git push
```

#### 4. Generate New Keys

```bash
# Generate a new key pair
ssh-keygen -t ed25519 -C "your_email@example.com"

# Set proper permissions
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# Add to SSH agent
ssh-add ~/.ssh/id_ed25519
```

#### 5. Add New Key to GitHub

Follow the [GitHub Integration](#github-integration) steps above to add your new public key.

#### 6. History Cleanup (Optional but Recommended)

If the key was committed to git history:

```bash
# WARNING: This rewrites history. Coordinate with your team!

# Option 1: Use git-filter-repo (recommended)
# Install: pip install git-filter-repo
git filter-repo --path path/to/key --invert-paths

# Option 2: Use BFG Repo-Cleaner
# Download from: https://rtyley.github.io/bfg-repo-cleaner/
java -jar bfg.jar --delete-files id_ed25519 .

# After either option, force push
git push --force --all
```

⚠️ **Warning**: History rewriting affects all collaborators. Communicate with your team before doing this.

#### 7. Document the Incident

Create a security incident report documenting:
- What was exposed
- When it was exposed
- How long it was exposed
- Actions taken to remediate
- Preventive measures implemented

### Preventive Measures

After an incident, implement these protections:

1. **Update .gitignore** (already done in this repository)
2. **Set up pre-commit hooks** to scan for secrets
3. **Enable GitHub secret scanning** in repository settings
4. **Use git-secrets or similar tools** for local scanning
5. **Regular security audits** of the repository

## Verification & Testing

### Verify SSH Key Setup

```bash
# 1. Check if SSH agent is running
echo $SSH_AUTH_SOCK
# Should output a path to a socket file

# 2. List keys loaded in agent
ssh-add -l
# Should list your key(s)

# 3. Verify key permissions
ls -la ~/.ssh/id_ed25519*
# id_ed25519 should be: -rw-------  (600)
# id_ed25519.pub should be: -rw-r--r--  (644)

# 4. Test GitHub connection
ssh -T git@github.com
# Should output: Hi username! You've successfully authenticated...

# 5. Verify git remote uses SSH
git remote -v
# Should show: git@github.com:username/repo.git
```

### Verify Repository Security

```bash
# Check for accidentally committed keys (use partial string to avoid matching this doc)
git log --all --source --full-history -S "PRIV""ATE KEY-----" --oneline

# Check .gitignore
cat .gitignore | grep -E "id_|\.key|\.pem"

# Scan for secrets in current working tree
git secrets --scan || echo "git-secrets not installed"
```

## Troubleshooting

### Problem: "Permission denied (publickey)"

**Symptoms:**
```
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
```

**Solutions:**

1. **Verify SSH agent has your key:**
   ```bash
   ssh-add -l
   ```
   If empty, add your key: `ssh-add ~/.ssh/id_ed25519`

2. **Verify key is on GitHub:**
   - Check [GitHub SSH keys settings](https://github.com/settings/keys)
   - Ensure your public key is listed

3. **Test with verbose output:**
   ```bash
   ssh -vT git@github.com
   ```
   Look for "Offering public key" and "Authentication succeeded"

4. **Check SSH config:**
   Ensure ~/.ssh/config has correct settings (see [SSH Agent Configuration](#ssh-agent-configuration))

### Problem: "WARNING: UNPROTECTED PRIVATE KEY FILE!"

**Symptoms:**
```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0644 for '/home/user/.ssh/id_ed25519' are too open.
```

**Solution:**
```bash
chmod 600 ~/.ssh/id_ed25519
```

### Problem: "Could not open a connection to your authentication agent"

**Symptoms:**
```
Could not open a connection to your authentication agent.
```

**Solution:**
```bash
# Start SSH agent
eval "$(ssh-agent -s)"

# Then add your key
ssh-add ~/.ssh/id_ed25519
```

### Problem: SSH agent not persisting between sessions

**Solution - Add to your shell config (~/.bashrc, ~/.zshrc):**

```bash
# SSH Agent persistence
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
```

### Problem: Multiple keys, wrong one being used

**Solution - Specify key in ~/.ssh/config:**

```ssh-config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github
  IdentitiesOnly yes
```

## Additional Resources

### Official Documentation

- [GitHub SSH Documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [OpenSSH Manual](https://www.openssh.com/manual.html)
- [SSH Key Best Practices](https://security.stackexchange.com/questions/143442/what-are-ssh-key-best-practices)

### Security Tools

- **git-secrets**: Prevents committing secrets to git
  - Install: `brew install git-secrets` (macOS)
  - Setup: `git secrets --install`

- **TruffleHog**: Finds secrets in git history
  - Install: `pip install truffleHog`
  - Usage: `trufflehog --regex --entropy=False .`

- **detect-secrets**: Detects secrets in code
  - Install: `pip install detect-secrets`
  - Usage: `detect-secrets scan`

### Key Rotation Schedule

**Recommended rotation frequency:**

- **Personal development keys**: Every 1-2 years
- **Organizational keys**: Every 6-12 months
- **Compromised keys**: Immediately
- **Unused keys**: Delete immediately

## Summary

**Key Takeaways:**

1. ✅ Generate keys with `ssh-keygen -t ed25519`
2. ✅ Store keys ONLY in `~/.ssh/` directory
3. ✅ Use passphrases to protect private keys
4. ✅ Set correct permissions (600 for private, 644 for public)
5. ✅ Add ONLY public keys to GitHub
6. ✅ Use SSH agent to manage keys
7. ❌ NEVER commit private keys to git
8. ❌ NEVER share private keys
9. ❌ NEVER store keys in repository directories
10. 🚨 If compromised, revoke immediately and generate new keys

**Need Help?**

If you're unsure about any security practices or encounter issues not covered here, please:
1. Open an issue in the repository
2. Contact the repository maintainers
3. Consult GitHub's official SSH documentation

**Remember**: Security is everyone's responsibility. When in doubt, ask!
