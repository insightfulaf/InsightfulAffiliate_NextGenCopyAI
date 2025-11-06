# Git Reference (Beginner‑friendly)

## Daily basics
- `git status -sb` — show current branch and changes (short format)
- `git fetch --all --prune` — fetch remote updates; delete local refs to removed branches
- `git checkout workflow-consolidation` — switch to working branch
- `git pull --rebase` — update your branch without extra merge commits

## Staging and committing
- `git add -A` — stage all changes (new/modified/deleted files)
- `git add <path>` — stage a specific file or folder
- `git commit -m "type(scope): message"` — make a commit with a short message
  - Examples: `chore(docs): update readme`, `feat(agent): add propose-patches`

## Pushing and PRs
- `git push` — push your current branch to origin
- `git push -u origin workflow-consolidation` — set upstream for a new branch
- Open GitHub → create a Pull Request from `workflow-consolidation` → `main`

## Undo/cleanup (safe patterns)
- `git restore --staged <path>` — unstage a file (keep changes in working tree)
- `git restore <path>` — discard local changes to a file (careful)
- `git checkout -- <path>` — legacy form of discard (careful)

## See history and diffs
- `git log --oneline --decorate --graph --all` — visual log
- `git diff` — view unstaged changes
- `git diff --staged` — view staged changes (= what will be committed)

## Locks & conflicts
- If you see `.git/index.lock` errors (common with Dropbox):
  1) Ensure no other Git process is running
  2) Close apps that might be accessing the repo
  3) Then: `rm -f .git/index.lock`
  4) Re‑run your original command

## Message conventions (recommended)
- `feat(...)` — new features
- `fix(...)` — bug fixes
- `docs(...)` — documentation only
- `chore(...)` — maintenance, refactors, config, tasks

Keep messages short; focus on the “why/what”.
