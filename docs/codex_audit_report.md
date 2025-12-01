# Repository Audit & Workflow Analysis

## 1) Repository State and Comparison
- Presence matrix (✅ present, ❌ missing):  
  - `README.md` → Dropbox `…/CURRENT` ✅ | GitHub `insightfulaf/CURRENT` ✅ | Legacy `insightfulaf/InsightfulAffiliate_NextGenCopyAI` ❌ (legacy missing root README)  
  - `PR1_INSTRUCTIONS.md`, `PR1_REVIEW_GUIDE.md` → ✅ | ✅ | ❌ (legacy missing PR1 docs)  
  - `CURRENT_STATE_REPORT*.{md,json}`, repo-analysis PDF → ✅ Dropbox-only | ❌ | ❌  
  - `docs/{css-and-manifest-strategy,environment-and-tools,repo-architecture-option-a,repo-cleanup-plan-option-a,master-option-a-architecture-blueprint}.md` → ✅ Dropbox-only | ❌ | ❌  
  - `pytest.ini`, `tests/test_hello.py` → ✅ | ✅ | ❌ (legacy lacks tests)  
  - `website_code_block_ORGANIZED/site.webmanifest.json` → ✅ | ✅ | ❌  
  - `copywriting/product_pages/20-post-content-plan-ai-copywriting-content.csv` → ✅ (Dropbox) | ❌ | ❌ | Git/legacy carry the previous encoded name instead  
  - `landing_pages/headers/*.gdoc` → all locations; metadata email now set to `insightfulaf@gmail.com` (was `golemmea@gmail.com`).
- Notable drifts/duplicates: Dropbox root holds `Archive_ready_to_sync/*` git snapshots and many `.rootbak` backups. `website_code_block_ORGANIZED` has two manifests (`site.webmanifest`, `assets/site.webmanifest`) plus `assets/ngcai.css`; legacy CSS/manifest from `landing_pages/assest_2/` has been quarantined under `archive/landing_pages_assest_2/`.
- Old-username remnants cleaned: `landing_pages/headers/{head-snippet-v7-production.gdoc,Updated_head_snippet-IA.gdoc}` now use `insightfulaf@gmail.com`.
- Actions needed: sync Dropbox-only docs into active `insightfulaf/CURRENT`; pick one canonical manifest/CSS location and retire `landing_pages/assest_2/*` (now archived); fix mis-encoded CSV filename; strip/quarantine `.rootbak`/archive git blobs; update gdoc metadata to `insightfulaf` or recreate snippets.

## 2) Agent and Script Analysis
- `scripts/agent_codex.py`: **Inputs** prompt (`--prompt`), input dir (`--input`) filtered by `--include-ext`/`--exclude-dirs`, optional site root (`--site`). **Outputs** `.out.md` per input + `.errors.txt` on validation fail. **Purpose** batch prompt-runner with basic validation and optional HTML link check. **Dependencies** Python 3, optional `openai` lib + `OPENAI_API_KEY`, git CLI. **Side effects** writes outputs, can `git add` (outputs or `--stage-all`), commit, push; optional site check on HTML.
- `scripts/agent_codex.py.bak`: same flow, older `read_text`; keep as reference.
- `scripts/build_funnel_map.py`: **Inputs** `docs/ai_outputs/_snippets/*.out.md`. **Outputs** `docs/checklists/funnel_map.md` grouped by funnel/bucket. **Purpose** index generated snippets. **Dependencies** stdlib only. **Side effects** overwrites funnel_map.md, prints path.
- `init_git_url.sh`: **Inputs** remote URL (+ optional `--lfs`). **Outputs** initializes `.git`, optional LFS tracking, first commit, sets/pushes `origin`. **Purpose** bootstrap repo. **Dependencies** git (git-lfs if flag). **Side effects** creates/commits `.gitignore`, pushes immediately.

## 3) Workflow and Integration Map
1. Edit in Dropbox (`/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT`); ensure Git clone `~/CURRENT` is in sync before commits.
2. AI generation: run `python3 scripts/agent_codex.py --prompt <prompt> --input <dir> --output <dir> [--site <landing_pages>] --provider openai --model <gpt>`; preview with `--provider echo`/`--dry-run`.
3. Review outputs (`docs/ai_outputs/_snippets/*.out.md`, funnel map) and HTML/CSS; optional `build_funnel_map.py`.
4. Commit/push from Git repo (`git add …` or agent staging; `git commit`; `git push`). Sync any Dropbox-only files needed in Git.
5. Deploy to Systeme.io manually: upload canonical CSS/manifest/icons; update URLs in `website_code_block_ORGANIZED/headers/head-snippet-v7-production.html`; paste snippets into head/Custom HTML per `docs/checklists/systeme_paste_guide.md`; run `docs/checklists/pre_publish.md`.
- Attention points: duplicated manifests/CSS can break links; Dropbox/Git drift risk; gdoc snippets were updated to `insightfulaf@gmail.com`; manual URL swaps after asset upload.

## 4) Environment and Configuration Summary
- **Software:** macOS 13; Node v22.20 (nvm); Python 3.9 + Homebrew 3.14; pipx; jq/yq/rg/fd/entr; Git/Git LFS; VS Code; Dropbox; Systeme.io (browser).
- **Config Files:** `pytest.ini` (testpaths/markers); `.github/copilot-instructions.md` (AI standards + AI_* envs); `codex_scope.txt` (asset inventory); `init_git_url.sh` (bootstrap); `docs/checklists/*` (VS Code, git, Systeme, pre-publish); `CURRENT_STATE_REPORT*.md/json` (state snapshots).
- **Env Vars:** `OPENAI_API_KEY` (agent openai provider); optional `AI_PROVIDER`, `AI_DEFAULT_MODEL`, `AI_ENABLE_PREVIEW`, `AI_FALLBACK_MODEL` per copilot example.
- **Agent Setup:** create venv at repo root; `pip install openai` for real runs; default provider `echo` for safe preview; `--stage-all` to let agent commit all pending changes (else only its outputs).

## 5) Prompt Library and Agent Instructions
- Roles/scopes: maintenance prompt defines a “repo maintenance agent” with ordered goals and tight scope (*scan only docs/, copywriting/product_pages/, website_code_block_ORGANIZED/*; skip binaries*). Rewrite prompt sets “rewriting agent” voice with Markdown-only output and brief Notes block.
- Task structure: checklist and canonicalization rules (single CSS/manifest source, path normalization) and drop zones (*write paste-ready snippets to docs/ai_outputs/_snippets/, filenames mirror source*).
- Output formats: enforced Markdown headings; fenced HTML blocks for Systeme pasting; validation in code (heading required for `.md`, `<html>/<head>` for `.html`); add short Notes and avoid fluff.
- Safety/guardrails: explicit skip lists, no network, minimal edits, TODOs over guesses; git behavior scripted (commit message/push guidance).
- GPT-5.1 best practices here: keep prompts modular (role + scope + format), use `--provider echo` dry-runs to verify context, chunk per-file via `--include-ext`, use JSON/Markdown schemas for new automations, surface self-checks (e.g., broken link reports), and refresh context from Dropbox superset to avoid stale metadata (e.g., previous `golemmea` leftovers).
