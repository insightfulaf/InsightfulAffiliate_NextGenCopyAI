# Master Option-A Architecture Blueprint  
_InsightfulAffiliate + NextGenCopyAI Monorepo_

Last updated: {{YYYY-MM-DD}}

---

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

---

## 2. Core Principles

1. **One canonical repo**
   - The canonical project root is the **CURRENT** repo inside Dropbox:  
     `/Users/ashley/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT`
   - GitHub remote: `insightfulaf/CURRENT` (active monorepo).
   - All other locations (legacy repos, stray folders) are either:
     - Mirrors checked against this repo, or
     - Archived under `archive/`.

2. **Two brands, shared backbone**
   - Shared infrastructure: tooling, base CSS, prompt patterns, scripts.
   - Brand-specific overlays: CSS overrides, manifests, head snippets, content.
   - Never duplicate logic when a shared abstraction is possible.

3. **Separation of concerns**
   - `assets/` holds shared and brand-specific static assets.
   - `web/` holds brand-specific pages/snippets.
   - `scripts/` holds automation logic and Codex integration.
   - `prompts/` holds agent instructions and prompt packs.
   - `docs/` is the documentation hub.
   - `archive/` holds legacy and historical artifacts only.

4. **Agent-friendly structure**
   - Clear root, no nested active Git repos.
   - Predictable directories for CSS, manifests, prompts, and scripts.
   - Explicit rules for what is canonical vs. archived.
   - Clear separation between “safe to edit” and “read-only history.”

5. **Human-and-machine readable**
   - All critical workflows documented in `docs/`.
   - Agents receive explicit pointers to this blueprint and related docs.
   - Documents are written so humans and LLMs can both follow them.

---

## 3. High-Level Layers

Think of the repo as four layers:

1. **Foundation (Tooling & Config)**  
   - `.vscode/`
   - `pyproject.toml` / `requirements.txt` (or equivalent)
   - `.gitignore`, `.editorconfig`, CI config (future)
   - System tools assumed by scripts/agents:
     - Node, Python, Git, jq, yq, ripgrep (`rg`), fd, entr, pipx, etc.

2. **Assets & Brand Definitions**  
   - `assets/` for static assets (CSS, manifests, icons, images).
   - `brands/` for metadata (YAML brand configs, URLs, colors, etc.).

3. **Web Surface**  
   - `web/insightfulaffiliate/**`
   - `web/nextgencopyai/**`  
   These hold HTML snippets, page sections, and any paste-ready blocks for Systeme.io.

4. **Automation & Intelligence**  
   - `scripts/` for automation, checks, and Codex runners.
   - `prompts/` for agent instructions and prompt packs.
   - `docs/` for all architecture, workflows, and runbooks.
   - GPT-5.1-Codex-Max + VS Code tasks orchestrate these pieces.

---

## 4. Logical Architecture Overview

### 4.1 Directory-Level View

(See `docs/unified-directory-specification.md` for the full spec. This is the conceptual overview.)

```text
/
├─ assets/              # Shared + brand-specific static assets
│  ├─ css/              # base.css, ia.css, ngcai.css
│  ├─ manifests/        # ia.webmanifest, ngcai.webmanifest
│  ├─ icons/            # brand-specific icon sets
│  └─ images/           # shared images/graphics (if needed)
│
├─ brands/              # Brand metadata powering scripts/agents
│  ├─ insightfulaffiliate/brand.yml
│  └─ nextgencopyai/brand.yml
│
├─ web/                 # Brand-specific website content/snippets
│  ├─ insightfulaffiliate/
│  │  ├─ landing/       # squeeze/thank-you pages
│  │  ├─ partials/      # reusable sections (hero, FAQ, etc.)
│  │  └─ head/          # IA head snippets
│  └─ nextgencopyai/
│     ├─ landing/
│     ├─ partials/
│     └─ head/
│
├─ scripts/             # Automation, checks, Codex runners, deployment helpers
│  ├─ agent_codex.py
│  ├─ check_links_and_manifest.py
│  ├─ generate_head_snippets.py
│  ├─ systeme_update_header.py
│  └─ ... (other workflow/maintenance tools)
│
├─ prompts/             # Agent instructions, prompt packs, role definitions
│  ├─ maintenance/
│  ├─ copywriting/
│  ├─ funnels/
│  └─ system/
│
├─ docs/                # Documentation hub
│  ├─ master-option-a-architecture-blueprint.md   # this file
│  ├─ repo-cleanup-plan-option-a.md
│  ├─ unified-directory-specification.md
│  ├─ css-and-manifest-consolidation-standard.md
│  ├─ agent-integration-architecture.md
│  └─ ... (runbooks, checklists, SOPs)
│
├─ .vscode/             # Editor + task configuration
│  ├─ settings.json
│  └─ tasks.json
│
├─ archive/             # Legacy / historical assets (not active)
│  ├─ legacy_docs/
│  ├─ legacy_assets/
│  └─ ...
│
├─ .gitignore
├─ README.md
└─ pyproject.toml / requirements.txt / other root config
