# Environment & Toolchain – InsightfulAffiliate / NextGenCopyAI

_Last verified on: {{update this date when you change anything}}_

This document describes the core development environment for the
**InsightfulAffiliate / NextGenCopyAI** monorepo (Option A architecture).

It is meant for:
- Me (Ash) as the primary maintainer
- Any future human collaborators
- Any AI agents (e.g., GPT-5.1-Codex-Max) operating on this repo

---

## 1. Operating System & Constraints

- **OS**: macOS 13 (Ventura)
- **Homebrew status**:
  - Homebrew reports this as a **Tier 3 / unsupported** configuration.
  - Consequence: some formulas may fail to build (notably Haskell / Pandoc stack).
  - Policy: if a brew install fails and is _non-critical_ to the core workflow, we ignore it or
    install alternatives (e.g., use `pipx` instead of `brew` for some tools).

- **Command Line Tools**:
  - Several logs warn: “A newer Command Line Tools release is available.”
  - This is _non-blocking_ for current workflows but should be upgraded when practical.

---

## 2. Core Languages & Runtimes

### 2.1 Node.js

- **Node version** (managed via `nvm`):

  ```bash
  node -v
  # v22.20.0
    ```

# Environment and Tools

## Purpose
- Document what is installed on this Mac and why, specifically for the InsightfulAffiliate / NextGenCopyAI monorepo.
- Give future Ash and GPT-5.1-Codex-Max a quick map of runtimes, CLIs, editor, and external services tied to repo workflows (scripts, prompts, docs).
- Clarify preferred usage so agents avoid touching the wrong areas (e.g., archives, global installs).

## High-Level Tool Stack Overview
- Core: Git + GitHub (`insightfulaf/CURRENT` active, legacy/archived repos present), VS Code, Dropbox sync.
- Runtimes: Node.js + npm for any front-end snippets; Python 3.9 + Homebrew Python 3.14 for scripts/automation; pipx for isolated CLI installs.
- CLIs: jq, yq, ripgrep (rg), fd, entr for text/JSON/YAML search and watch tasks.
- External: Systeme.io (publishing target in browser), Dropbox (storage/sync backbone).

## Language Runtimes & Package Managers

### Node + npm
- Role: Build or lint small front-end snippets and assets (e.g., `website_code_block_ORGANIZED`, landing page components). No large JS app here, but Node/npm are on the box for one-off bundling, formatting, or npm-based tooling.
- Usage here: Mostly ad-hoc commands; keep dependencies local to the repo if needed. Do not install global packages for repo tasks; prefer project-local `node_modules` (none committed currently).

### Python
- Versions present: System Python 3.9 and Homebrew Python 3.14 (per repo analysis/typical setup). Multiple virtualenvs exist in the workspace history; standardize per project when running scripts.
- Role: Run automation like `scripts/agent_codex.py.bak`, simple pytest (`tests/test_hello.py`), and other maintenance scripts.
- Guidance: Create/activate a virtualenv at repo root when running Python tooling; avoid using nested legacy `.venv` paths. Keep dependencies minimal and captured per-project (requirements file when you formalize).

### pipx
- Role: Install and run Python CLIs in isolation (e.g., yq). Keeps the global Python site-packages clean and avoids cross-env contamination.
- Usage here: Prefer `pipx run` or `pipx install` for standalone CLIs instead of polluting the active virtualenv.

## CLI Utilities (jq, yq, rg, fd, entr)
- jq: Parse/transform JSON (handy for manifest checks, prompt JSONL, and affiliate link mappings). Agents can pipe repo JSON into jq for quick inspection.
- yq (via pipx): YAML querying (useful if/when brand metadata lives in YAML under `configs/brands/` or similar). Prefer `yq eval` for read-only operations.
- ripgrep (rg): Fast text/code search across the monorepo. Default tool for locating prompts, HTML snippets, or config references (faster than grep).
- fd: Fast file finder; useful to list HTML/CSS snippets, prompt files, or tests without scanning heavy directories manually.
- entr: File watcher to rerun lightweight commands on change (e.g., regenerate outputs or rerun tests). Use with care; scope to canonical paths, not archived copies.

## Editor & Git Integration
- VS Code: Primary editor. `.vscode/` tasks/settings may exist to streamline runs; open the repo root (`CURRENT`) as the workspace.
- Git: Standard CLI for version control. Working remote: `insightfulaf/CURRENT` (active). Legacy/archived repos remain present locally—do not push from those.
- Branches: `main` plus `workflow-consolidation` (per repo analysis). Ensure you’re operating in the canonical repo root, not nested duplicates.

## External Services
- Systeme.io: Publishing target for generated HTML/CSS. Workflow: generate snippets locally (scripts/prompts), then paste/upload via the browser; ensure canonical head snippet/CSS/manifest are used.
- Dropbox: Primary storage and sync location (`~/Dropbox/InsightfulAffiliate_NextGenCopyAI`). Maintains backups and also contains legacy copies—be deliberate about which folder is canonical (`CURRENT`).

## How an AI Agent Should Think About This Environment
- Prefer existing tools: use `rg`/`fd` for search, `jq`/`yq` for JSON/YAML inspection, `entr` only on canonical paths.
- Stay within the canonical repo root: `/Users/ashley/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT`. Avoid editing archived or duplicated trees.
- Runtimes: For Python, create/use a virtualenv at the repo root; do not rely on global packages or nested legacy envs. For Node, keep installs local; avoid global npm installs.
- Git hygiene: Operate against `insightfulaf/CURRENT`; do not touch archived remotes. Avoid staging files from duplicated/archived directories.
- External usage: Publishing is manual to Systeme.io via browser; do not attempt automated networked deploys. Dropbox sync is automatic—avoid moves that could desync canonical vs archive trees without intent.
