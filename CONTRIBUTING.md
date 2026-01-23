# Contributing

Thanks for contributing! This file explains how to set up your local environment and the recommended workflows for cloning, authentication, and pushing changes.

> **📖 Quick Reference**: For comprehensive workflow documentation including Python environment setup, environment variables, available agents, and common workflows, see the [Workflow Operations Guide](docs/WORKFLOW_OPERATIONS_GUIDE.md).

## Run setup script (recommended first step)

We provide a small helper script to automates macOS credential helper setup and run quick connectivity checks. Run it after cloning and before making your first push:

```bash
./scripts/setup.sh
```

The script will try to configure the macOS keychain helper and run basic `git ls-remote` and SSH checks. If it reports credential problems for HTTPS, follow the PAT guidance below.

## Clone the repository

- HTTPS (recommended for many users):

Clone via HTTPS:

```bash
git clone https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```

- SSH (recommended if you use SSH keys regularly):

```bash
git clone git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```

## Authentication options

> **⚠️ Security Note**: For comprehensive SSH key security practices, please read [SSH Key Security Guide](docs/SSH_KEY_SECURITY.md). This guide covers secure key generation, storage, and emergency response procedures.

A. HTTPS with macOS keychain (recommended for macOS users)

1. Enable the macOS keychain helper (stores credentials securely):

```bash
git config --global credential.helper osxkeychain
```

1. When you first `git push` or `git fetch` that requires credentials, Git will prompt for your GitHub username and a Personal Access Token (PAT) in place of a password. Enter them and they will be saved to your keychain.

1. How to create a PAT (minimal scopes):
   - Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic) or fine-grained tokens.
   - For basic repo access, the `repo` scope is sufficient for private repos (or select repo permissions in fine-grained tokens).
   - Copy the token and paste it when Git prompts for a password.

B. SSH (no PAT required, more secure for regular use)

**🔐 IMPORTANT: Read the [SSH Key Security Guide](docs/SSH_KEY_SECURITY.md) for detailed security practices.**

**Quick Setup (secure method):**

1. Create an SSH key if you don't have one:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
# or, if ed25519 unsupported:
# ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

When prompted:

- Accept default location (`~/.ssh/id_ed25519`)
- **Use a strong passphrase** (highly recommended for security)

1. Set proper file permissions:

```bash
chmod 600 ~/.ssh/id_ed25519      # private key
chmod 644 ~/.ssh/id_ed25519.pub  # public key
```

1. Start the ssh-agent and add your key:

```bash
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519  # macOS-specific
# or: ssh-add ~/.ssh/id_ed25519  # Linux
```

1. Copy your **public** key and add it to GitHub (Settings → SSH and GPG keys):

```bash
cat ~/.ssh/id_ed25519.pub | pbcopy  # macOS
# or: cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard  # Linux
# then paste into GitHub at https://github.com/settings/keys
```

1. Test the connection:

```bash
ssh -T git@github.com
```

You should see a success message like `Hi <username>! You've successfully authenticated...`.

**⚠️ Security Reminders:**

- NEVER commit private keys (files without .pub extension) to git
- Store SSH keys ONLY in `~/.ssh/` directory
- Use passphrases to protect your private keys
- If you accidentally expose a key, revoke it immediately and generate a new one
- See [SSH Key Security Guide](docs/SSH_KEY_SECURITY.md) for emergency response procedures

## Recommended workflow

- Always branch from `main` for new features or fixes:

```bash
git checkout -b feature/short-description
```

- Commit changes with clear messages:

```bash
git add <files>
git commit -m "type(scope): short description"
```

- Push your branch and open a PR via GitHub:

```bash
git push -u origin feature/short-description
```

- Use PRs for reviews. Keep PRs small and focused.

## Branch Management

> **📖 Detailed Guide**: For comprehensive branch cleanup procedures, see the [Branch Cleanup Process](docs/BRANCH_CLEANUP_PROCESS.md) documentation.

### Branch Naming Conventions

Use clear, descriptive branch names that indicate the purpose of the work:

**Recommended patterns:**
- `feature/short-description` - New features
- `fix/bug-description` or `bugfix/issue-description` - Bug fixes
- `docs/topic` - Documentation updates
- `refactor/component-name` - Code refactoring
- `test/feature-name` - Test additions or improvements

**Examples:**
```bash
git checkout -b feature/add-affiliate-tracking
git checkout -b fix/login-validation-error
git checkout -b docs/update-setup-guide
```

### When to Create Branches

- Always create a new branch for any changes (never commit directly to `main`)
- Branch from `main` for new work
- Keep branches focused on a single feature or fix
- Create separate branches for unrelated changes

### Keeping Branches Up to Date

**Sync with main regularly:**

```bash
# While on your feature branch
git checkout main
git pull origin main
git checkout your-feature-branch
git merge main

# Or use rebase (if you're comfortable with it)
git rebase main
```

**Best practices:**
- Sync with main before starting work each day
- Sync before opening a pull request
- Resolve conflicts locally before pushing

### When to Delete Branches

**Delete branches after:**
- Pull request is merged
- Changes are integrated into main
- Work is abandoned and no longer needed

**How to delete:**

```bash
# Delete local branch (after PR is merged)
git branch -d branch-name

# Delete remote branch (if not auto-deleted by GitHub)
git push origin --delete branch-name
```

**Automatic deletion:**
- GitHub can automatically delete branches after PR merge
- Repository owners can enable this in Settings → General → Pull Requests

### Branch Cleanup

We maintain repository hygiene through regular branch cleanup:

- **Stale branches** (>90 days old with no activity) are reviewed quarterly
- **Merged branches** should be deleted promptly after PR merge
- Use the [Branch Cleanup Checklist](docs/checklists/BRANCH_CLEANUP_CHECKLIST.md) for systematic cleanup
- Create cleanup tracking issues using the [Branch Cleanup Template](.github/ISSUE_TEMPLATE/branch-cleanup.md)

**Before deleting a branch, always verify:**
- [ ] Associated PR is closed or merged
- [ ] No unique unmerged commits exist
- [ ] No one is actively working on it

**Resources:**
- [Branch Cleanup Process](docs/BRANCH_CLEANUP_PROCESS.md) - Full documentation
- [Branch Cleanup Checklist](docs/checklists/BRANCH_CLEANUP_CHECKLIST.md) - Practical checklist
- [Branch Cleanup Issue Template](.github/ISSUE_TEMPLATE/branch-cleanup.md) - Tracking template

## When to use HTTPS vs SSH

- Use HTTPS if:

  - You prefer username + PAT and want credential storage in macOS keychain.
  - You cannot use SSH due to company network policies.

- Use SSH if:
  - You have SSH keys set up and prefer key-based auth.
  - You want to avoid managing PATs.

## Troubleshooting

- "Repository not found" when doing `git ls-remote` or `git fetch`:
  - Verify the remote URL matches the repository name. Check it with:

```bash
git remote -v
```

- If the URL is wrong, set it using the following command (HTTPS example):

  ```bash
  git remote set-url origin https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
  ```

- If using HTTPS and you get 401/403, ensure your PAT has the correct scopes and is saved in the keychain.
- If using SSH and you get permission errors, ensure your public key is added to GitHub and `ssh -T git@github.com` returns a successful auth message.

## Code style & PR checklist (brief)

- Write clear commit messages.
- Add tests for new functionality where feasible.
- Keep PRs focused and provide a description of changes.

## Contact

If you have issues contributing or need access, contact the repository owner (`insightfulaf`) or open an issue on GitHub.
