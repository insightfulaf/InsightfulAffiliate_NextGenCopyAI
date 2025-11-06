# Repository Workflow Guide

This guide explains the daily workflow integrating Dropbox → VS Code → GitHub → Systeme.io for the `CURRENT` repository.

For a concise daily checklist and exact commands, see `docs/RUNBOOK.md`.

## 1) Locations and branching
- Canonical repo: `CURRENT` (GitHub: `git@github.com:insightfulaf/CURRENT.git`)
- Working branch for merges: `workflow-consolidation`
- Keep the sibling repo `InsightfulAffiliate_NextGenCopyAI` for reference; do not edit.

## 2) Local workspace (Dropbox + VS Code)
- Open the `CURRENT/` folder in VS Code.
- Ensure VS Code GitHub account: `insightfulaf`.
- Confirm remote: `git remote -v` should show SSH `git@github.com:insightfulaf/CURRENT.git`.

## 3) Generating content with the agent
Use the agent to transform content blocks for Systeme.io.

Standard mode (Markdown-wrapped outputs):
```
python3 scripts/agent_codex.py \
  --prompt prompts/rewrite_to_house_style.txt \
  --input website_code_block_ORGANIZED/headers \
  --output docs/ai_outputs/_snippets \
  --include-ext ".html,.css,.json" \
  --provider echo \
  --dry-run --verbose
```

Systeme mode (paste-ready raw files):
```
python3 scripts/agent_codex.py \
  --prompt prompts/rewrite_to_house_style.txt \
  --input website_code_block_ORGANIZED/headers \
  --output docs/ai_outputs/_snippets \
  --include-ext ".html,.css,.js" \
  --provider openai --model gpt-4o-mini \
  --systeme-mode
```
- Outputs: `*.out.html` / `*.out.css` / `*.out.js` (paste directly into Systeme.io)
- Use `--stage-all` to include additional changes; otherwise only the outputs are committed.

## 4) Head snippet and manifest
- Head snippet: `website_code_block_ORGANIZED/headers/head-snippet-v7-production.html`
- Canonical manifest: `website_code_block_ORGANIZED/site.webmanifest` (JSON twin available as `.json`)
- In Systeme.io, upload `ngcai.css`, icons, and the manifest via Media, then replace placeholders in the head snippet and manifest with the public URLs. If the manifest is on a different domain or protected, add `crossorigin="use-credentials"`.

## 5) Commit and push
```
git checkout workflow-consolidation
git add -A
git commit -m "chore(content): update blocks for Systeme"
git push
```
Create PRs from `workflow-consolidation` to `main` when ready.

## 6) Review folder
- Ambiguous or legacy files live in `REVIEW_PENDING/`. Review and either merge, update, or remove in a follow-up PR.

## 7) Troubleshooting
- Nested Git: avoid operating in the parent folder’s Git repo. Work inside `CURRENT/`.
- Missing outputs: ensure `--include-ext` matches your files and `--systeme-mode` is set for paste-ready assets.
- Validation errors: in standard mode, HTML must contain `<html>` and `<head>`. In systeme-mode, fragments are allowed.

## 8) Maintenance & Patches

Use VS Code tasks (Cmd+Shift+P → “Tasks: Run Task”) to keep things tidy:

- Maintenance: Analyze & Checklist (openai) — scans scoped dirs and writes checklists to `docs/ai_outputs/checklists/`.
- Maintenance: Dry-run (echo) — safe preview, no files written.
- Maintenance: Propose patches (openai) — writes unified `.patch` files to `docs/ai_outputs/patches/` (no edits applied).
- Maintenance: Review patches (open targets) — opens latest patch files and their target sources.
- Maintenance: Apply patches (commit) — applies `.patch` files on `workflow-consolidation`, commits, and pushes.
- Maintenance: Link & Manifest check — writes a broken-link + manifest audit report to `docs/ai_outputs/checklists/`.
- Maintenance: Patch summary — writes a quick summary of all `.patch` files.
- Chains available:
  - Maintenance: Propose → Review notes (notes + matching sources)
  - Maintenance: Propose → Review diffs (patch diffs + targets)

## 9) Brand Heads & Systeme Automation

- Head: Generate (IA)/(NGCAI) — renders brand-specific head snippets from the template `landing_pages/headers/head-snippet-ngcai.html` using YAML configs under `configs/brands/`.
- Systeme: Update IA/NGCAI header (Playwright) — optional automation to paste the generated head into Systeme; requires env vars `SYSTEME_EMAIL`, `SYSTEME_PASSWORD`, and `PAGE_URL`.

Scope‑specific helpers are also available:
- Analyze headers/components/thank‑you (openai)
- Propose patches: headers/components/thank‑you (openai)

Notes:
- Patches are safe by design: propose→review→apply→push.
- If a patch fails to apply, check `.rej` files and ask for help to merge.
