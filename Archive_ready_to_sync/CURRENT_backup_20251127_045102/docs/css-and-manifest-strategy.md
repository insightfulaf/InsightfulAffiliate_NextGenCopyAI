# CSS & Manifest Strategy (Option A: IA + NGCAI)

## Purpose
- Define the canonical locations and rules for CSS and web manifests in the Option-A monorepo rooted at `CURRENT/`.
- Ensure both brands (InsightfulAffiliate, NextGenCopyAI) share a stable base while keeping brand-specific overlays clean, predictable, and agent-friendly.
- Align head snippets, scripts, and Systeme.io publishing with a single source of truth.

## Canonical File Locations
- Base CSS: `assets/css/base.css` (brand-neutral foundation).
- Brand CSS overrides:
  - IA: `assets/css/ia.css` (imports/overrides base).
  - NGCAI: `assets/css/ngcai.css` (imports/overrides base).
- Manifests:
  - IA: `assets/manifests/ia.webmanifest`
  - NGCAI: `assets/manifests/ngcai.webmanifest`
- Icons:
  - IA: `assets/icons/ia/` (favicons, maskables, PWA icons).
  - NGCAI: `assets/icons/ngcai/`
- Head snippets (for reference): `web/insightfulaffiliate/snippets/` and `web/nextgencopyai/snippets/` should link to the canonical CSS/manifest paths above.

## Rules for Editing CSS
- Base vs overrides:
  - Keep shared tokens/layout/utilities in `base.css`.
  - Brand-specific colors/typography in `ia.css` or `ngcai.css`; prefer `@import` of base, then overrides.
- Naming conventions:
  - Use brand prefixes sparingly; rely on CSS variables for theming where possible (e.g., `--brand-primary`).
  - Keep file names stable (`base.css`, `ia.css`, `ngcai.css`); avoid scattering variants.
- Comments for agents:
  - Brief, purposeful comments only where needed to explain non-obvious choices (e.g., critical CLS prevention).
  - Avoid verbose marketing comments.
- Safety:
  - Do not duplicate base rules into brand files; override with minimal selectors.
  - Avoid inlining large CSS into HTML snippets unless explicitly requested.
  - Keep specificity low; prefer variables and utility classes over deep selectors.

## Rules for Editing Manifests
- Keep one manifest per brand in `assets/manifests/`.
- Required fields per brand: `name`, `short_name`, `theme_color`, `background_color`, `start_url`, `scope`, `icons[]`.
- Icons must reference the canonical brand icon folder (IA → `assets/icons/ia/`, NGCAI → `assets/icons/ngcai/`).
- URLs:
  - Use relative paths within the repo; when publishing to Systeme/CDN, update head snippets to the deployed URLs, but keep manifest source paths canonical here.
  - Ensure `start_url` and `scope` reflect the deployed funnel root; align Dropbox/Git working copy with what is pasted/uploaded to Systeme.
- Consistency:
  - Keep brand names accurate (no cross-brand leakage).
  - Align theme/background colors with brand CSS variables.

## How Scripts and Agents Interact with CSS/Manifests
- Scripts (e.g., `generate_head_snippets.py` or similar helpers) should read from the canonical paths and emit head snippets pointing to `assets/css/<brand>.css` and `assets/manifests/<brand>.webmanifest`.
- Link-check or asset-check scripts should validate that referenced manifests and icons exist in canonical locations.
- Codex agents generating snippets should always reference the canonical CSS/manifest paths; no ad-hoc copies in `landing_pages/` or other folders.

## Systeme.io Integration
- Publish flow (human/agent-assisted):
  1) Upload canonical CSS and manifests (and required icons) to the hosting location used by Systeme.io.
  2) Copy the hosted URLs for `base.css`, brand CSS, manifest, and icons.
  3) Update the brand head snippet in `web/<brand>/snippets/` to point to the hosted URLs.
  4) Paste the snippet into Systeme.io page head; ensure `start_url`/`scope` in the manifest align with the live page path.
  5) Smoke test: open page in incognito, verify manifest loads and icons resolve.
- Keep the repo sources canonical even if CDN URLs differ; do not fork new manifest/CSS files in random folders.

## Do / Don’t for Agents
- Do:
  - Edit `assets/css/base.css`, `assets/css/ia.css`, `assets/css/ngcai.css` for global/brand styles.
  - Edit `assets/manifests/ia.webmanifest`, `assets/manifests/ngcai.webmanifest` for manifest changes.
  - Reference icons only from `assets/icons/ia/` and `assets/icons/ngcai/`.
  - Update head snippets under `web/insightfulaffiliate/snippets/` and `web/nextgencopyai/snippets/` to point to canonical assets.
  - Use `rg`/`fd` to locate references; keep changes within the canonical repo root.
- Don’t:
  - Create new manifests or CSS in arbitrary folders (e.g., `landing_pages/assest_2/`).
  - Inline large CSS blobs into HTML unless explicitly instructed.
  - Point manifests to non-canonical icon paths or mix IA/NGCAI assets.
  - Duplicate manifests per page; one per brand is sufficient.
  - Edit or rely on assets in `archive/` or other legacy buckets for active pages.
