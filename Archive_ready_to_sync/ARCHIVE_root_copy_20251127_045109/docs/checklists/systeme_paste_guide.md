# Systeme Paste Guide (NGCAI)

> Use the **.out.md** files in `docs/ai_outputs/_snippets/`. Paste ONLY the HTML/CSS inside the Markdown code blocks.

## Global setup (once per workspace)
1. Upload canonical assets to Systeme → Media
   - `website_code_block_ORGANIZED/assets/ngcai.css`
   - `website_code_block_ORGANIZED/site.webmanifest`
   - Copy their public URLs and paste into the head snippet.

2. Head snippet (global or per-page)
   - File: `website_code_block_ORGANIZED/headers/head-snippet-v7-production.html`
   - Replace `../assets/ngcai.css` and `../site.webmanifest` with your public URLs.
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

