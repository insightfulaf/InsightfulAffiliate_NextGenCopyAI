# CURRENT Repository Runbook

A practical, repeatable routine for running the Python agent(s) and keeping the repo healthy. Designed for beginners; copy/paste the commands as-is.

## 1) One‑Page Checklist

Daily (5–10 min)
- Open folder: .../Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT
- Activate env: `source .venv/bin/activate` (prompt shows `(.venv)`)
- Update branch: `git fetch --all --prune && git checkout workflow-consolidation && git pull --rebase`
- Health check: `python -V` • `pip show openai` • API key check below
- Run agent (dry‑run, safe): see Commands
- Run agent (real, paste‑ready): see Commands
- Paste result into Systeme.io and verify manifest loads
- Commit + push any repo changes

Weekly (10–15 min)
- `python -m pip install --upgrade pip openai` (inside `.venv`)
- `pip check`
- Review `REVIEW_PENDING/` and resolve items
- Quick site check: visit both opt‑in pages; confirm `<link rel="manifest">` and icons load

Monthly (10 min)
- Rotate OpenAI key (create new, update `~/.zshrc`, re‑source)
- Clean old branches; ensure `CURRENT` remains canonical; archive resolved review items

## 2) Environment & Keys

- Activate project environment (recommended):
  - `cd ~/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT`
  - `source .venv/bin/activate`
  - Verify: `which python` → ends with `CURRENT/.venv/bin/python`
- Keep `.venv` from syncing to Dropbox (optional but helpful):
  - `xattr -w com.dropbox.ignored 1 .venv`
- OpenAI API key (persistent):
  - Edit `~/.zshrc` and add exactly one line:
    - `export OPENAI_API_KEY='sk-PASTE_YOUR_KEY_HERE'`
  - Reload: `source ~/.zshrc`
  - Quick check (no secret printed):
    - `python - << 'PY'\nimport os; k=os.getenv('OPENAI_API_KEY',''); print('API OK' if k and k.startswith(('sk-','sk-proj-')) else 'API MISSING')\nPY`

## 3) Commands (Copy/Paste)

Dry‑run (no writes; safe test)
- `python scripts/agent_codex.py --prompt prompts/rewrite_to_house_style.txt --input website_code_block_ORGANIZED/headers --output docs/ai_outputs/_snippets --include-ext ".html,.css,.js" --provider echo --systeme-mode --dry-run --verbose`

Real run (paste‑ready outputs)
- `python scripts/agent_codex.py --prompt prompts/rewrite_to_house_style.txt --input website_code_block_ORGANIZED/headers --output docs/ai_outputs/_snippets --include-ext ".html,.css,.js" --provider openai --model gpt-4o-mini --systeme-mode --verbose`

Commit + push (if you changed outputs/docs)
- `git add docs/ai_outputs/_snippets/*.out.*`
- `git commit -m "chore(content): update paste-ready head snippet"`
- `git push`

## 4) Paste Into Systeme.io

- Open result: `docs/ai_outputs/_snippets/head-snippet-v7-production.html.out.html`
- Replace local paths with your uploaded Media URLs:
  - `{{NGCAI_CSS_URL}}` → the uploaded `ngcai.css` URL
  - `{{MANIFEST_URL}}` → the uploaded `site.webmanifest` or `.json` URL
  - Favicon/Apple icon/OG/Twitter images → uploaded URLs
- In Systeme.io page editor: Settings → SEO/Head → paste full contents.
- If manifest is on another domain or requires auth, add `crossorigin="use-credentials"` to the manifest `<link>` tag.

## 5) Quick Verifications

- API key present: `python - << 'PY'\nimport os;print('API OK' if os.getenv('OPENAI_API_KEY') else 'API MISSING')\nPY`
- Branch + remote: `git branch --show-current` (workflow-consolidation) • `git remote -v` (SSH URL)
- Live manifest reachability (in browser console):
  - `fetch('PASTE_MANIFEST_URL').then(r => console.log('Manifest reachable:', r.ok))`

## 6) Troubleshooting

- Invalid API key (401): regenerate key, update `~/.zshrc`, `source ~/.zshrc`, re‑run check.
- Agent writes nothing: ensure `--include-ext` matches files; use `--verbose`.
- Wrong Python: re‑activate `.venv`, and in VS Code select the same interpreter.
- Old account artifacts: search `rg -n "golemmea"` — only allowed in `REVIEW_PENDING/`.
- Dropbox popups during pip: harmless. Optionally ignore `.venv` as above.

## 7) Key Paths (for reference)

- Agent: `scripts/agent_codex.py`
- Outputs (paste‑ready): `docs/ai_outputs/_snippets/*.out.html|.out.css|.out.js`
- Head snippet template: `website_code_block_ORGANIZED/headers/head-snippet-v7-production.html`
- Manifest (canonical): `website_code_block_ORGANIZED/site.webmanifest` (+ `.json` twin)
- Review staging: `REVIEW_PENDING/`

## 8) Tasks You’ll Use (what they do)

- Agent: Dry‑run (echo)
  - Runs agent_codex with echo provider and `--systeme-mode`; prints planned writes. No files changed.
- Agent: Paste‑ready (systeme‑mode)
  - Generates paste‑ready `.out.html/.out.css/.out.js` files in `docs/ai_outputs/_snippets/`.
- Agent: Generate + Commit (push)
  - Runs paste‑ready generation, stages outputs, opens commit editor (if changes), pushes to `workflow-consolidation`.
- Systeme: Upload Checklist
  - Runs paste‑ready then opens the output file and prints upload/verify steps for Systeme.io.
- Maintenance: Analyze & Checklist (openai)
  - Scans `docs/`, `copywriting/product_pages/`, `website_code_block_ORGANIZED/`; writes checklists under `docs/ai_outputs/checklists/`.
- Maintenance: Propose patches (openai)
  - Writes unified `.patch` files to `docs/ai_outputs/patches/` (no edits applied).
- Maintenance: Review patches (open targets)
  - Opens latest `.patch` files and their target sources side‑by‑side for inspection.
- Maintenance: Review patch notes (open notes)
  - Opens `.patch.notes.md` files (from echo/NO‑CHANGE) and tries to open the matching source file.
- Maintenance: Apply patches (commit)
  - Applies `.patch` files, commits on `workflow-consolidation`, and pushes. If a patch fails, a `.rej` file is created.
- Maintenance: Link & Manifest check
  - Runs `scripts/check_links_and_manifest.py`; writes a broken‑link + manifest audit report in `docs/ai_outputs/checklists/`.
- Maintenance: Patch summary
  - Runs `scripts/patch_summary.py`; lists patches with +/- counts and targets.
- Maintenance: Propose → Review notes
  - Chains proposal then opens `.patch.notes.md` outputs (best when using echo or when NO‑CHANGE notes are expected).
- Maintenance: Propose → Review diffs
  - Chains proposal then opens the actual `.patch` diffs and their target files for review.
 - Head: Generate (IA) / (NGCAI)
   - Renders brand head snippets from `landing_pages/headers/head-snippet-ngcai.html` using YAML configs under `configs/brands/`. If override_css_url is set, injects it after the canonical CSS.
 - Systeme: Update IA/NGCAI header (Playwright)
   - Automates pasting the header into Systeme. Requires env vars: `SYSTEME_EMAIL`, `SYSTEME_PASSWORD`, `PAGE_URL`. Installs: `python -m pip install playwright && python -m playwright install chromium` (one time).

## 9) Extra Commands (propose & check)

Propose patches (safe; no edits applied)
- `python scripts/agent_codex.py --prompt prompts/maintenance_codex.md --input website_code_block_ORGANIZED --output docs/ai_outputs/checklists --patch-dir docs/ai_outputs/patches --propose-patches --include-ext ".md,.txt,.html,.htm,.css,.json" --exclude-dirs ".git,node_modules,dist,build,docs/ai_outputs" --provider openai --model gpt-4o-mini --verbose`

Link & manifest check (report only)
- `python scripts/check_links_and_manifest.py`

Generate brand head from template (example – IA)
- `python scripts/generate_head_snippets.py --template landing_pages/headers/head-snippet-ngcai.html --config configs/brands/ia.yml --output docs/ai_outputs/_snippets/head-snippet-IA.html.out.html`
  - Local manifest templates are versioned under `website_code_block_ORGANIZED/manifests/` (for reference). Upload each site’s manifest to Systeme and paste the resulting URL into the brand config’s `manifest_url`.

Playwright header updater (example – IA)
- `SYSTEME_EMAIL=you@example.com SYSTEME_PASSWORD='secret' PAGE_URL='https://app.systeme.io/.../pages/...'
   HEAD_FILE='docs/ai_outputs/_snippets/head-snippet-IA.html.out.html' \
   python scripts/systeme_update_header.py`

## 10) Agent & Flag Glossary (what each does)

- `--systeme-mode` (agent_codex)
  - For HTML/CSS/JS inputs: output raw code; relax HTML checks; name outputs `*.out.html|.css|.js`.
- `--provider` + `--model`
  - Backend selection (use `echo` for tests; `openai` for real). `gpt-4o-mini` is a good default.
- `--include-ext` / `--exclude-dirs`
  - Controls file types scanned and folders skipped.
- `--dry-run`
  - Preview actions; no files written.
- `--stage-all` (optional)
  - Stage the whole repo before committing (avoid unless intended).
- `--propose-patches` (agent_codex)
  - Emit unified diffs instead of content. Files go to `docs/ai_outputs/patches/` (or `--patch-dir`). No edits applied.
- `--patch-dir` (agent_codex)
  - Destination for `.patch` (or `.patch.notes.md`) files in propose‑patch mode.
- `scripts/check_links_and_manifest.py`
  - Scans HTML for broken relative links; validates manifest keys & icon paths; writes a Markdown report.
- `scripts/patch_summary.py`
  - Creates a compact summary of proposed patches with +/- counts and targets.

## 11) Maintenance Flow (safe & fast)

1) Propose patches (openai)
   - VS Code task: “Maintenance: Propose patches (openai)” (or scope‑specific)
2) Review
   - “Maintenance: Review patches (open targets)” for diffs + sources
   - “Maintenance: Review patch notes (open notes)” for echo/NO‑CHANGE notes
3) Apply
   - “Maintenance: Apply patches (commit)” → applies, commits, pushes on `workflow-consolidation`
4) Verify
   - “Maintenance: Link & Manifest check” and “Maintenance: Patch summary”
