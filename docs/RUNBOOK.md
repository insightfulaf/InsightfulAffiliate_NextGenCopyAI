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

