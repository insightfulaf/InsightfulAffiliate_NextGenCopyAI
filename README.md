# README — Root of repo

## File: README.md (location: /)

## Introduction

This repo powers **InsightfulAffiliate** and **NextGenCopyAI** content workflows: write locally in **Dropbox** (VS Code), commit to **GitHub**, generate/paste **Systeme.io** sections, and automate bulk edits with a **Codex-style agent**.

- Working folder (on disk): `~/Dropbox/InsightfulAffiliate_NextGenCopyAI`.
- Backups: Dropbox cloud + GitHub remote history. See “Where files live”.
- Key tools: VS Code, Git, GitHub, Git LFS, Codex IDE/CLI, GitHub Copilot.

## Setup

> **🔐 Security First**: Before you begin, review the security documentation:
> - [Quick Start: SETUP_SECRETS.md](SETUP_SECRETS.md) - 5-minute setup guide for secrets management
> - [SSH Key Security Guide](docs/SSH_KEY_SECURITY.md) - SSH credentials and key management
> - [Secrets Management Guide](docs/SECRETS_MANAGEMENT.md) - GitHub Secrets and environment variables
> - [Security Checklist](docs/checklists/SECURITY_CHECKLIST.md) - Complete security verification

1. **Git remote ([insightfulaf/InsightfulAffiliate_NextGenCopyAI][remoteRepoDefinition])**
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

## GitHub Copilot Setup

This repository is configured with custom GitHub Copilot agents and skills to enhance your development workflow. These tools help with content generation, landing page creation, affiliate link management, and documentation.

### Available Custom Agents

Located in `.github/agents/`:

1. **Content Generator** - AI copywriting assistant for InsightfulAffiliate and NextGenCopyAI brands
2. **Landing Page Builder** - Systeme.io specialist for conversion-optimized web components
3. **Affiliate Link Manager** - Compliance and tracking expert for ethical affiliate marketing
4. **Documentation Expert** - Technical writer for clear, comprehensive documentation
5. **Plan Mode** - Strategic planning and architecture assistant

### Available Skills

Located in `.github/skills/`:

1. **Content Generation Workflow** - Automated workflow using `agent_codex.py` for bulk content generation
2. **Affiliate Compliance Check** - FTC compliance verification and ethical marketing practices

### Using Copilot Agents

**In GitHub Issues**: When assigning an issue to Copilot, select a custom agent from the list to get specialized assistance.

**In VS Code**: Activate custom agents in the Copilot chat alongside built-in agents.

**In Copilot CLI**: Coming soon - custom agent support in terminal workflows.

### Repository Instructions

The file `.github/copilot-instructions.md` contains comprehensive guidelines for:

- Repository structure and coding standards
- Brand voice guidelines (InsightfulAffiliate vs NextGenCopyAI)
- AI integration patterns and best practices
- Content generation workflows
- Affiliate marketing compliance

These instructions are automatically available to GitHub Copilot when working in this repository.

### Learn More

- [Workflow Operations Guide](docs/WORKFLOW_OPERATIONS_GUIDE.md) - **New!** Comprehensive reference for Python environment, agents, skills, and common workflows
- [GitHub Copilot Best Practices](https://gh.io/copilot-coding-agent-tips)
- [Contributing Guidelines](CONTRIBUTING.md)
- [Copilot Instructions](.github/copilot-instructions.md)

[remoteRepoDefinition]: https://github.com/insightfulaf/InsightfulAffiliate_NextGenCopyAI.git
