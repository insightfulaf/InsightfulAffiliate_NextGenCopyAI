## Notes
This document outlines the setup process for the AI Affiliate Launchpad using Systeme.io. The instructions are clear and focus on the necessary steps.

# AI Affiliate Launchpad — Systeme.io Starter Stack (2025)
**Version:** 2025-09-03  |  **Creator:** InsightfulAffiliate / NextGenCopyAI

## What You Get
- **Squeeze** and **thank-you** sections (Custom HTML blocks)
- **7-email** welcome/activation sequence (markdown files)
- **Brand head include** for favicons, manifest, and Open Graph
- **FTC disclosure snippets** (for site and email)
- **FAQ JSON-LD** and a **blog post shell**
- **First 7 Days** checklist
- **Two hero variants:** 
  - `html/squeeze-hero.html` → **No Form** (button links to the next step)
  - `html/squeeze-hero--with-form.html` → **With Form** (button scrolls to #optin)

## Installation (10–20 Minutes)
1. Navigate to **Systeme.io → Funnels** and create a funnel (Opt-in → Thank-you).
2. Open each page, go to **Settings → Edit header code**, and paste `html/brand-head-include.html`.
3. On the squeeze page, add a **Custom HTML** block at the top and paste one hero variant:
   - For **No form**, use `html/squeeze-hero.html` and set your button link (see `README_Button_NextStep.md`).
   - For **With form**, use `html/squeeze-hero--with-form.html` and set the section below to `id="optin"`.
4. Add a **Form** block under the hero only if you want to capture emails on this page.
5. On the thank-you page, paste `html/thank-you-block.html`.
6. Create a **Campaign** named “Starter Stack” and paste emails `01` to `07` (personalize as needed).
7. Conduct a full test: click the button on the squeeze page to ensure it directs to the next step. If using the form version, test the submission and email delivery.

— Happy launching!