# Master Option-A Architecture Blueprint (IA + NGCAI)

## 1) Purpose
- Define the target architecture for a single canonical monorepo rooted at `/Users/ashley/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT`.
- Support two brands—InsightfulAffiliate (IA) and NextGenCopyAI (NGCAI)—with shared infrastructure and brand-specific overlays.
- Give humans and Codex-Max a clear, self-contained reference for where to put code, assets, prompts, and docs, and what to treat as archive-only.

## 2) Core Principles
- One canonical repo root (`CURRENT/`), no nested active repos.
- Separation of concerns: shared vs brand-specific, production vs archive.
- Predictable paths for assets, brand data, web artifacts, scripts, prompts, and docs.
- Agent-friendly: clear scopes, avoid ambiguity in discovery (tests/configs only once).
- Git hygiene: main branch as source of truth; feature branches for changes.

## 3) High-Level Layers
- Foundation: tool configs, CI, `.vscode/`, linters/tests.
- Assets & Brand Definitions: shared static assets + brand metadata.
- Web Surface: brand-specific HTML/CSS/manifests/snippets.
- Automation & Intelligence: scripts, prompts, docs for workflows and agents.
- Archive: quarantined legacy content kept for reference only.

## 4) Logical Architecture Overview
```
Repo Root (CURRENT/)
├─ assets/        # Shared + brand-specific static assets (icons, images, CSS base)
├─ brands/        # Brand metadata (YAML/JSON) for IA and NGCAI
├─ web/           # Brand-specific site/funnel code (HTML snippets, manifests, pages)
├─ scripts/       # Automation, maintenance, build/publish helpers, agents
├─ prompts/       # Prompt packs, roles, system/user instruction files
├─ docs/          # Architecture, runbooks, cleanup plans, environment notes
├─ tests/         # Single test tree (no duplicates)
├─ .vscode/       # Editor tasks/settings
├─ archive/       # Legacy/retired assets; excluded from tooling
└─ repo configs   # .gitignore, pytest.ini, etc.
```

## 5) Directory Tree (target after cleanup)
```text
CURRENT/
├─ assets/
│  ├─ css/                 # Shared base CSS, canonical brand-neutral styles
│  ├─ icons/               # Favicons/app icons (per brand subfolders ok)
│  ├─ images/              # Shared imagery; brand subfolders allowed
│  └─ downloads/           # PDF/guide downloads
├─ brands/
│  ├─ insightfulaffiliate.yaml   # Brand metadata (colors, logos, links)
│  └─ nextgencopyai.yaml         # Brand metadata
├─ web/
│  ├─ insightfulaffiliate/
│  │  ├─ css/             # Brand-specific CSS overlays
│  │  ├─ manifests/       # PWA/site manifests for IA
│  │  ├─ snippets/        # Head snippets, sections, templates
│  │  └─ pages/           # Full funnel pages if needed
│  └─ nextgencopyai/
│     ├─ css/
│     ├─ manifests/
│     ├─ snippets/
│     └─ pages/
├─ scripts/
│  ├─ agent_codex.py      # Codex-style agent runner (canonical)
│  ├─ build_*             # Build/packaging scripts
│  └─ maintenance_*       # Cleanup/check scripts
├─ prompts/
│  ├─ roles/              # System/role prompts (e.g., rewrite_to_house_style.txt)
│  ├─ tasks/              # Task-specific prompt bundles
│  └─ playbooks/          # Workflow-oriented prompt packs
├─ docs/
│  ├─ repo-architecture-option-a.md
│  ├─ repo-cleanup-plan-option-a.md
│  ├─ css-and-manifest-strategy.md
│  ├─ environment-and-tools.md
│  └─ workflows/          # Checklists/runbooks
├─ tests/
│  └─ ...                 # Single source of truth for tests
├─ .vscode/
│  └─ tasks.json          # Editor tasks (lint, test, agent runs)
├─ archive/
│  ├─ legacy_repos/       # Archived repo copies; no active .git
│  └─ retired_assets/     # Old CSS/manifests/snippets kept for reference
├─ .gitignore
├─ pytest.ini
└─ README.md
```

## 6) Key Directories (what goes where)
- `assets/`: Shared static assets; minimal duplication; brand subfolders allowed.
- `brands/`: Metadata driving automation (colors, logos, links) consumed by scripts/agents.
- `web/`: Brand-facing HTML/CSS/manifests/snippets; split per brand.
- `scripts/`: Automation runners (e.g., agent_codex), build helpers, validators.
- `prompts/`: Role/task/playbook prompts for Codex-Max and related agents.
- `docs/`: Architecture, cleanup plans, environment/tooling, workflow checklists.
- `tests/`: One consolidated test suite; avoid duplicates.
- `.vscode/`: Editor/task config to standardize commands.
- `archive/`: Quarantined legacy content; excluded from tests/agents unless explicitly referenced.

## 7) Brand Split: IA vs NGCAI
- Shared backbone: `assets/`, `scripts/`, `prompts/`, `docs/`, base CSS.
- Brand-specific overlays live under `web/<brand>/` and may reference shared assets.
- Example paths:
  - IA CSS overlay: `web/insightfulaffiliate/css/site.css`
  - IA manifest: `web/insightfulaffiliate/manifests/site.webmanifest`
  - IA head snippet: `web/insightfulaffiliate/snippets/head-snippet.html`
  - NGCAI CSS overlay: `web/nextgencopyai/css/site.css`
  - NGCAI manifest: `web/nextgencopyai/manifests/site.webmanifest`
  - NGCAI snippet: `web/nextgencopyai/snippets/head-snippet.html`
- Shared icons/images: `assets/icons/`, `assets/images/`; if brand-specific, place in subfolders and reference from brand manifests/snippets.

## 8) CSS & Manifest Strategy (summary)
- One shared base CSS in `assets/css/` (brand-neutral).
- Brand overlays in `web/<brand>/css/` that import/override the base.
- Canonical manifests per brand in `web/<brand>/manifests/`; references in head snippets must point here.
- Head snippets live in `web/<brand>/snippets/` and should reference the canonical CSS/manifest locations.
- Detailed rules (naming, caching, links) live in `docs/css-and-manifest-strategy.md`.

## 9) Agent Operating Model
- Canonical root: `/Users/ashley/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT`.
- Allowed scopes: edit within `assets/`, `brands/`, `web/`, `scripts/`, `prompts/`, `docs/`, `tests/`, `.vscode/`.
- Archive-only: `archive/` and any legacy repo copies—read-only unless explicitly moving items into quarantine.
- Preferred tools: `rg`/`fd` for search, `jq`/`yq` for JSON/YAML, Python virtualenv at root for scripts, local Node installs if needed (no global pollution).
- Avoid nested `.git` and duplicate test/config trees; keep `pytest.ini` and `tests/` single-sourced.

## 10) Git & Branching Expectations
- Primary remote: `insightfulaf/CURRENT`.
- Branching: `main` as source of truth; short-lived feature branches (e.g., `feature/<task>`); avoid working from archived or nested repos.
- Commit hygiene: clean working tree, no archive content staged; commits describe scope (e.g., `chore(repo): option-a cleanup`).
- No nested repos: ensure only one `.git` at root; archive legacy `.git` dirs by removing or relocating them outside the active tree.

## 11) How to Extend This Blueprint
- New brand: add metadata in `brands/<new>.yaml`, create `web/<new>/` (css/manifests/snippets/pages), and link to shared assets as needed.
- New funnel/page: add under the appropriate `web/<brand>/pages/` or `snippets/`; reuse canonical head snippet and manifests.
- New automation: place scripts in `scripts/`, prompts in `prompts/`; update docs/workflows if agents or humans must run them; add tests in `tests/`.
- Always keep archive content segregated and documented; update docs to reflect new structures.
