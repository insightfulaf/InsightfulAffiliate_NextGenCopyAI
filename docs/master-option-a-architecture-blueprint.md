# Master Option-A Architecture Blueprint  
_InsightfulAffiliate + NextGenCopyAI Monorepo_

Last updated: {{YYYY-MM-DD}}

—

## 1. Purpose

Option A defines a **single monorepo** that powers two brands:

- **InsightfulAffiliate (IA)**
- **NextGenCopyAI (NGCAI)**

This blueprint is the top-level map of:

- How code, assets, and content are organized
- How the brands share infrastructure but keep branding separate
- How agents (GPT-5.1-Codex-Max) operate safely within that structure

This document is for:
- Ash (primary maintainer)
- Future collaborators
- Any AI agent given access to this repo

—

## 2. Core Principles

1. **One canonical repo**
   - The canonical project root is the **CURRENT** repo inside Dropbox:
     - `/Users/ashley/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT`
   - GitHub remote: `insightfulaf/CURRENT` (active monorepo).

2. **Two brands, shared backbone**
   - Shared infrastructure (tooling, base CSS, prompts, scripts).
   - Brand-specific overlays (CSS overrides, manifests, head snippets, content).

3. **Separation of concerns**
   - `assets/` holds shared and brand-specific static assets.
   - `web/` holds brand-specific pages/snippets.
   - `scripts/` holds automation logic.
   - `prompts/` holds agent instructions and prompt packs.
   - `docs/` is the documentation hub.
   - `archive/` is where legacy/uncertain assets go.

4. **Agent-friendly structure**
   - Clear root, no nested active repos.
   - Predictable directories for CSS, manifests, and prompts.
   - Explicit rules for what is canonical vs. archived.

5. **Human-and-machine readable**
   - All critical workflows documented in `docs/`.
   - Agents receive explicit instructions pointing at this architecture.

—

## 3. High-Level Layers

Think of the repo as four layers:

1. **Foundation (Tooling & Config)**
   - `.vscode/`, `pyproject.toml` / `requirements.txt`, `.gitignore`, CI config (future).
   - Global tools (jq, yq, rg, fd, entr, pipx, Node, Python) live on the system but are assumed by scripts/agents.

2. **Assets & Brand Definitions**
   - `assets/`
   - `brands/`

3. **Web Surface**
   - `web/insightfulaffiliate/…`
   - `web/nextgencopyai/…`

4. **Automation & Intelligence**
   - `scripts/`
   - `prompts/`
   - `docs/` describing workflows
   - GPT-5.1-Codex-Max + VS Code tasks orchestrating these pieces

—

## 4. Logical Architecture Overview

### 4.1 Directory-Level View

(See `docs/unified-directory-specification.md` for the full spec; this is the conceptual overview.)

```text
/
├─ assets/        # Shared + brand-specific static assets (CSS, manifests, icons)
├─ brands/        # Brand metadata (YAML), used by scripts and agents
├─ web/           # Brand-specific website source (HTML/snippets/pages)
├─ scripts/       # Automation, checks, codex runners, deployment helpers
├─ prompts/       # Agent instructions, prompt packs, role definitions
├─ docs/          # Documentation hub (this file, cleanup plan, workflows, etc.)
├─ .vscode/       # Editor + task configuration
├─ archive/       # Legacy / historical assets (not active)
└─ repo root      # Git, project config, README, etc.

