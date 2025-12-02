# InsightfulAffiliate_NextGenCopyAI — Maintenance Agent (Codex)

You are a careful repo maintenance agent working **inside a local Git workspace**.  
Primary goals (in this order):

1) **Repo hygiene**  
   - Detect moved/renamed files and fix **intra-repo relative paths** in HTML/MD/CSS (images, CSS links, manifest refs).  
   - Normalize duplicate CSS and web manifests to **one canonical file each** and update all pages to point to them.  
   - Do **not** break existing paths; prefer relative paths; keep URLs lowercase.

2) **Paste-ready snippets for Systeme.io**  
   - Produce copy-paste blocks (Markdown fenced) for each landing page/section that a non-developer can paste directly into Systeme.io.  
   - For HTML/CSS/JS snippets, keep them self-contained (no imports beyond the canonical CSS/manifest); include brief usage notes.

## Scope (keep runtime & cost tight)
Scan **only**:
- `docs/`
- `copywriting/product_pages/`
- `website_code_block_ORGANIZED/`

Consider **only** text files with these extensions:  
`.md, .txt, .html, .htm, .css, .json`

Skip **everything else** (images, videos, zips, node_modules, .git, build artifacts, PDFs, design binaries).

## Canonicalization rules
- **CSS:** pick one canonical CSS (prefer the most recently updated if duplicates conflict).  
  - Put canonical CSS at: `website_code_block_ORGANIZED/assets/ngcai.css` (create if missing).  
  - Update all pages to reference `./assets/ngcai.css` (relative to the HTML file) or the correct relative path from page to that file.  
  - Preserve any non-canonical CSS by merging unique rules into the canonical file where reasonable; otherwise, leave a comment pointing to the retained canonical file.

- **Web manifest:** pick one canonical manifest (most recent).  
  - Place it at: `website_code_block_ORGANIZED/site.webmanifest` (create if missing).  
  - Update all references (`<link rel="manifest" href="…">`) to the correct relative path to that file.  
  - Ensure required keys: `name`, `short_name`, `icons` (PNG/SVG), `start_url`, `display`, `theme_color`, `background_color`.

- **Images/assets:** if a file was moved/renamed, adjust **relative** paths in MD/HTML/CSS accordingly.  
  No remote fetches. No deletions.

## Outputs
- Write paste-ready snippets to:  
  `docs/ai_outputs/_snippets/`  
  Use filenames that mirror the source page path (e.g., `product_pages/home-hero.html.out.md`).

- If you produce any checklists or “diff summaries”, write to:  
  `docs/ai_outputs/checklists/`

- Keep Git safety:
  - Stage and commit changes with message:  
    `codex: repo hygiene + canonical CSS/manifest + path fixes`
  - **Do not** push unless explicitly instructed (we’ll push in a separate step).

## Editing safety & guardrails
- Never modify binary files or anything outside the repo.  
- No external network calls.  
- If uncertain, leave a short `<!-- TODO: ... -->` note rather than guessing.  
- Prefer minimal, surgical edits. Keep whitespace noise low.  
- Validate HTML head sections and `<link>` tags when you touch them.

## Systeme.io paste-blocks (format)
For each landing page / major section you touch, create a short Markdown file in `docs/ai_outputs/_snippets/` containing:

```md
### {Page or Section Name}
**Where to paste in Systeme.io:** {e.g., page head / hero block / footer}

```html
<!-- BEGIN paste-ready -->
{HTML snippet}
<!-- END paste-ready -->

## Run now
Proceed **now** with the defaults above. Do not ask questions.
- Perform repo hygiene and path normalization.
- Produce paste-ready snippets into `docs/ai_outputs/_snippets/`.
- Stage all changes, commit with message: `codex: repo hygiene + canonical CSS/manifest + path fixes`.
- Push to `origin main` when finished.
- Print a final summary with counts and the words: **RUN COMPLETE**.
