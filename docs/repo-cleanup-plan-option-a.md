# Repo Cleanup Plan — Option A (Single Canonical Monorepo in `CURRENT/`)

## Purpose & Goals
- Remove duplication and nested repos; operate from one canonical root: `/Users/ashley/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT`.
- Quarantine legacy/archived copies so they do not interfere with tooling (pytest, agents, path discovery).
/- Canonicalize CSS/manifest/head snippets to a single source of truth for both brands.
- Update references to current paths/usernames; eliminate stale links (e.g., old usernames/paths, stray golemmea URLs).

## Pre-Flight Checks
- Confirm current branch in the canonical repo: `git status -sb` (expect `main` or `workflow-consolidation`).
- Ensure Dropbox sync is healthy (no paused sync, no conflicts).
- Verify backups: Dropbox contains the repo; GitHub remote `insightfulaf/CURRENT` reachable.
- Snapshot state: `git status`, note uncommitted changes; avoid touching unrelated local modifications.
- Identify active Python/Node envs; deactivate any nested/legacy virtualenvs before file moves.

## High-Level Phases
- Phase 1: Identify and tag legacy/duplicate directories.
- Phase 2: Consolidate CSS and manifests to canonical locations.
- Phase 3: Flatten Git repos (one root, others archived).
- Phase 4: Update references (old username, old paths).
- Phase 5: Sanity checks + final Git commit.

## Detailed Step-by-Step Plan

### Phase 1: Identify and tag legacy/duplicate directories
1) Human action: In Finder/VS Code, note all top-level duplicates (e.g., archived `InsightfulAffiliate_NextGenCopyAI/`, nested `CURRENT/` mirrors, `Archive_ready_to_sync/`, `REVIEW_PENDING/`).
2) Agent-friendly action: Run safe listings to map duplicates:
   - `ls -a .`
   - `ls -a CURRENT`
   - `find . -maxdepth 2 -type d -name '.git'`
3) Mark legacy buckets (no edits yet): `InsightfulAffiliate_NextGenCopyAI` (archived), any `Archive_ready_to_sync/`, and nested mirrors inside `CURRENT/` that replicate root content.
4) Decide quarantine location: keep legacy under `archive/` or clearly named `ARCHIVE_*/` at repo root; ensure no `.git` inside active tree.
5) Human action: If uncertain about a folder’s status, tag it with a README note inside (e.g., “ARCHIVE — do not edit”) before moving; avoid deletes until reviewed.

### Phase 2: Consolidate CSS and manifests to canonical locations
1) Agent-friendly: Inventory CSS/manifest assets:
   - `rg --files -g '*.css' assets website_code_block_ORGANIZED landing_pages`
   - `rg --files -g '*manifest*' assets website_code_block_ORGANIZED landing_pages`
2) Human/Agent: Pick canonical CSS + manifest for both brands (likely under `website_code_block_ORGANIZED/assets/` and `website_code_block_ORGANIZED/site.webmanifest`).
3) Human action: Move or copy non-canonical variants into archive if duplicated (e.g., `archive/landing_pages_assest_2/insightfulaffiliate.css`, `archive/landing_pages_assest_2/site.webmanifest.json`) once confirmed obsolete.
4) Agent-friendly: Update docs to point to canonical files (e.g., `docs/css-and-manifest-strategy.md`, head-snippet docs) and ensure prompts/scripts reference canonical paths.
5) Human/Agent: Normalize head snippets to match canonical CSS/manifest references (e.g., `website_code_block_ORGANIZED/headers/head-snippet-v7-production.html`).

### Phase 3: Flatten Git repos (one root, others archived)
1) Human action: Ensure work is inside `/Users/ashley/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT` (canonical). Do not operate from nested clones.
2) Agent-friendly: Verify only one `.git` controls the workspace: `find . -maxdepth 3 -name '.git'`. If nested `.git` dirs exist, move those folders to `archive/` or remove the nested `.git` (after human confirmation).
3) Human action: For legacy repo folders (e.g., `InsightfulAffiliate_NextGenCopyAI/`), leave intact but clearly marked as archived; ensure they are outside the active working tree or ignored.
4) Agent-friendly: Align pytest/discovery roots to one `tests/` and one `pytest.ini` at the canonical root; move/remove duplicate `tests/` under nested mirrors to archive (after human approval).

### Phase 4: Update references (old username, old paths)
1) Agent-friendly: Search for old usernames/paths and stale URLs:
   - `rg "golemmea" .` (example stale username from analysis)
   - `rg "InsightfulAffiliate_NextGenCopyAI" docs scripts prompts` (check for old root references)
2) Human/Agent: Update references to canonical repo path (`~/Dropbox/InsightfulAffiliate_NextGenCopyAI/CURRENT`) and current GitHub remote (`insightfulaf/CURRENT`).
3) Agent-friendly: Refresh docs that describe structure (e.g., `docs/master-option-a-architecture-blueprint.md`, `docs/environment-and-tools.md`, `docs/css-and-manifest-strategy.md`) to reflect Option A once cleanup is done.
4) Human action: Validate external links (Systeme.io instructions, Dropbox notes) still point to valid locations; fix or annotate if retired.

### Phase 5: Sanity checks + final Git commit
1) Agent-friendly: Run validation commands from canonical root:
   - `git status -sb`
   - `rg --files -g '*.py' tests scripts | wc -l` (ensure single test tree)
   - `pytest` (if tests remain and env is set) to confirm no ImportPathMismatch.
2) Human action: Review `git diff` for moves/renames; ensure archives are clearly named and excluded from tooling.
3) Human/Agent: Update a short log in `COMPLETION_SUMMARY.md` (or a new cleanup log) describing what was consolidated and where archives live.
4) Human action: Commit with a clear message, e.g., `chore(repo): option-a cleanup canonical root` and push to `insightfulaf/CURRENT`.

## What the Codex Agent Is Allowed to Do
- May edit: `docs/`, `prompts/`, `scripts/`, canonical `assets/`, `website_code_block_ORGANIZED/`, head snippets, manifests, and other active paths within `CURRENT/`.
- May move duplicates into a designated `archive/` or `ARCHIVE_*` folder after human confirmation; should not delete unless explicitly approved.
- Must avoid editing archived/legacy trees except to relocate them out of the active path; do not touch nested `.git` without human approval.
- Must avoid global installs; prefer local virtualenvs for Python and local node_modules for Node. Use `pipx` for standalone CLIs.
- Should propose patches for risky changes (e.g., moving tests, changing manifests) and run only safe discovery commands without destructive flags.

## Completion Criteria
- Only one active `.git` controls the working copy (the canonical root in `CURRENT/`); nested repos are archived/quarantined.
- One canonical `tests/` and `pytest.ini`; running `pytest` from root does not raise ImportPathMismatch.
- Canonical CSS/manifest/head snippet paths established and documented; non-canonical variants quarantined.
- References updated to current paths/usernames/remotes (`insightfulaf/CURRENT`), with stale links removed or annotated.
- Archives clearly labeled and excluded from tooling; Dropbox sync clean; Git status clean after final commit and push.
