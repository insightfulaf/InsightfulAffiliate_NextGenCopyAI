# README — Root of repo
# File: README.md  (location: /)

## Introduction
This repo powers **InsightfulAffiliate** and **NextGenCopyAI** content workflows: write locally in **Dropbox** (VS Code), commit to **GitHub**, generate/paste **Systeme.io** sections, and automate bulk edits with a **Codex-style agent**.

- Working folder (on disk): `~/Dropbox/InsightfulAffiliate_NextGenCopyAI`.  
- Backups: Dropbox cloud + GitHub remote history.  See “Where files live”.  
- Key tools: VS Code, Git, GitHub, Git LFS, Codex IDE/CLI, GitHub Copilot.

## Setup
1) **Git remote (current repo name/user)**
   - Update once, then verify:

> Recommended first step: see `CONTRIBUTING.md` and run `./scripts/setup.sh` after cloning.

Note: this repository's `origin` is currently configured to use SSH (`git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git`).
If you prefer HTTPS, you can switch a local clone with:

```bash
git remote set-url origin https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
```


## Clone URL & Credentials

Correct HTTPS clone URL (recommended):

`https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git`

Equivalent SSH clone URL (if you prefer SSH):

`git@github.com:insightfulaf/InsightfulAffiliate_NextGenCopyAI.git`

Enable macOS credential helper (caches HTTPS credentials in the keychain):

```bash
git config --global credential.helper osxkeychain
```

After running the above, the next time you `git push` Git will prompt for your GitHub username and a personal access token (PAT). Enter them and macOS will store them in your keychain.

If you prefer to keep using SSH, ensure your SSH key is added to GitHub (Settings → SSH and GPG keys).
