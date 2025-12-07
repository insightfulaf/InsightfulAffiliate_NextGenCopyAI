# Contributing

Thanks for contributing! This file explains how to set up your local environment and the recommended workflows for cloning, authentication, and pushing changes.

## Run setup script (recommended first step)

We provide a small helper script to automates macOS credential helper setup and run quick connectivity checks. Run it after cloning and before making your first push:

```bash
./scripts/setup.sh
```

The script will try to configure the macOS keychain helper and run basic `git ls-remote` and SSH checks. If it reports credential problems for HTTPS, follow the PAT guidance below.

**Clone the repository**

- HTTPS (recommended for many users):

```
https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```

Clone via HTTPS:

```bash
git clone https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```

- SSH (recommended if you use SSH keys regularly):

```bash
git clone git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```


## Authentication options

A. HTTPS with macOS keychain (recommended for macOS users)

1. Enable the macOS keychain helper (stores credentials securely):

```bash
git config --global credential.helper osxkeychain
```

2. When you first `git push` or `git fetch` that requires credentials, Git will prompt for your GitHub username and a Personal Access Token (PAT) in place of a password. Enter them and they will be saved to your keychain.

3. How to create a PAT (minimal scopes):
   - Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic) or fine-grained tokens.
   - For basic repo access, the `repo` scope is sufficient for private repos (or select repo permissions in fine-grained tokens).
   - Copy the token and paste it when Git prompts for a password.

B. SSH (no PAT required)

1. Create an SSH key if you don't have one:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
# or, if ed25519 unsupported:
# ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

2. Start the ssh-agent and add your key:

```bash
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519  # macOS-specific
# or: ssh-add ~/.ssh/id_rsa
```

3. Copy your public key and add it to GitHub (Settings → SSH and GPG keys):

```bash
cat ~/.ssh/id_ed25519.pub | pbcopy
# then paste into GitHub
```

4. Test the connection:

```bash
ssh -T git@github.com
```

You should see a success message like `Hi <username>! You've successfully authenticated...`.


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

  - If the URL is wrong, set it (HTTPS example):

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
