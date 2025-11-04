# Systeme Paste Guide (NGCAI)

> Paste-ready outputs come in two forms:
> - Standard mode: **.out.md** with code blocks — copy only the HTML/CSS/JS inside the block.
> - Systeme mode: run agent with `--systeme-mode` to write raw files like `*.out.html` / `*.out.css` / `*.out.js` — paste them directly into Systeme (no Markdown wrapper).

## Global setup (once per workspace)
1. Upload canonical assets to Systeme → Media
   - `website_code_block_ORGANIZED/assets/ngcai.css`
   - `website_code_block_ORGANIZED/site.webmanifest` (canonical) and `site.webmanifest.json` (twin if host requires .json)
   - Copy their public URLs and paste into the head snippet.

2. Head snippet (global or per-page)
   - File: `website_code_block_ORGANIZED/headers/head-snippet-v7-production.html`
   - Replace `../assets/ngcai.css` and `../site.webmanifest` (or `../site.webmanifest.json`) with your uploaded public URLs.
   - If your manifest is hosted on a different domain or requires credentials, add `crossorigin="use-credentials"` to the `<link rel="manifest" ...>` tag.

## Using the agent in Systeme mode (recommended)

Example (dry-run):
```
python3 scripts/agent_codex.py \
  --prompt prompts/rewrite_to_house_style.txt \
  --input website_code_block_ORGANIZED/headers \
  --output docs/ai_outputs/_snippets \
  --include-ext ".html,.css,.js" \
  --provider echo \
  --systeme-mode \
  --dry-run --verbose
```
Outputs will be written as `*.out.html` / `*.out.css` / `*.out.js` and are paste-ready.
   - Paste in Systeme:
     - Per page: Page → Settings → SEO/Head → Header
     - Or workspace-level: Settings → Head/Tracking Code

## Page-by-page mapping
### Landing page
- Head: use the snippet above
- Hero: `docs/ai_outputs/_snippets/hero-sections-ai-affiliate-launchpad.html.out.md` → Custom HTML (top)
- Optional sections: any other `…hero…`, `…cta…`, `…section…` `.out.md` → Custom HTML blocks

### Thank-you page
- Head: same head snippet
- Main block: `docs/ai_outputs/_snippets/thank-you-ai-affiliate-launchpad-thank-you.html.out.md` → Custom HTML (top)

## SEO & metadata quick template
(keep this near the top of head snippet)
```html
<title>[[PAGE TITLE — 55–60 chars]]</title>
<meta name="description" content="[[150–160 chars]]" />
<link rel="canonical" href="[[https://your-domain.com/page]]" />
<meta property="og:title" content="[[Title]]" />
<meta property="og:description" content="[[Description]]" />
<meta property="og:url" content="[[https://your-domain.com/page]]" />
<meta property="og:image" content="[[https://…/share-1200x630.png]]" />
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="[[Title]]" />
<meta name="twitter:description" content="[[Description]]" />
<meta name="twitter:image" content="[[https://…/share-1200x630.png]]" />
